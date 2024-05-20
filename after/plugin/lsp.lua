if vim.g.vscode then
    -- VSCode extension
else
    local lsp = require("lsp-zero")
    require("mason").setup()

    require("editorconfig")
    vim.g.editorconfig = true

    lsp.nvim_workspace()
    lsp.preset("recommended")
    lsp.ensure_installed({
        "bufls",
        "tsserver",
        "eslint-lsp",
        "prettier",
        "efm",
        "prismals",
        "volar",
        "vtsls",
        "rust_analyzer",
        "gopls",
        "clangd",
        "tailwindcss",
        "html-lsp",
        "json-lsp",
        "docker_compose_language_service",
        "dockerls",
        "terraformls",
        "tflint",
        "lua_ls",
        "kotlin_language_server",
        "ktlint",
        "jdtls",
        "zls",
        "elixirls",
    })

    local lspconfig = require("lspconfig")
    lspconfig.elixirls.setup({})
    lspconfig.kotlin_language_server.setup({})



    ---------------------------------------------------------------------------
    -------------------------- JAVA CONFIG ------------------------------------
    ---------------------------------------------------------------------------

    lspconfig.jdtls.setup({
        cmd = {
            "jdtls",
            "--jvm-arg=-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
            "--jvm-arg=-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "--jvm-arg=-Dosgi.bundles.defaultStartLevel=4",
            "--jvm-arg=-Declipse.product=org.eclipse.jdt.ls.core.product",
            "--jvm-arg=-Dlog.protocol=true",
            "--jvm-arg=-Dlog.level=ALL",
            "--jvm-arg=-Xmx1g",
            "--jvm-arg=--add-modules=ALL-SYSTEM",
            "--jvm-arg=--add-opens=java.base/java.util=ALL-UNNAMED",
            "--jvm-arg=--add-opens=java.base/java.lang=ALL-UNNAMED",
            vim.fn.expand("-configuration $HOME/.cache/jdtls/config"),
            vim.fn.expand("-data $HOME/.cache/jdtls/workspace"),
        },
        settings = {
            java = {
                maven = {
                    downloadSources = true,
                    updateSnapshots = true,
                },
                eclipse = {
                    downloadSources = true,
                },
                import = {
                    maven = {
                        enabled = true,
                        offline = {
                            enabled = true,
                        },
                    },
                },
                jdt = {
                    ls = {
                        vmargs = "-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
                    },
                },
            },
        },
    })
    --

    -- lspconfig.jdtls.setup({
    -- 	cmd = {
    -- 		"java",
    -- 		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
    -- 		"-Dosgi.bundles.defaultStartLevel=4",
    -- 		"-Declipse.product=org.eclipse.jdt.ls.core.product",
    -- 		"-Dlog.protocol=true",
    -- 		"-Dlog.level=ALL",
    -- 		"-Xmx1g",
    -- 		"--add-modules=ALL-SYSTEM",
    -- 		"--add-opens",
    -- 		"java.base/java.util=ALL-UNNAMED",
    -- 		"--add-opens",
    -- 		"java.base/java.lang=ALL-UNNAMED",
    -- 		vim.fn.expand("-javaagent:$MASON/share/jdtls/lombok.jar"),
    -- 		"-jar",
    -- 		vim.fn.glob("$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    -- 		vim.fn.expand("-configuration $HOME/.cache/jdtls/config"),
    -- 		vim.fn.expand("-data $HOME/.cache/jdtls/workspace"),
    -- 	},
    -- })
    -- lsp.skip_server_setup({ "jdtls" })
    -- require("jdtls").start_or_attach({
    -- 	cmd = {
    -- 		"jdtls",
    -- 		"-jvm-args=-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
    -- 		vim.fn.expand("-configuration $HOME/.cache/jdtls/config"),
    -- 		vim.fn.expand("-data $HOME/.cache/jdtls/workspace"),
    -- 	},
    -- 	autostart = true,
    -- 	settings = {
    -- 		java = {
    -- 			maven = {
    -- 				downloadSources = true,
    -- 				updateSnapshots = true,
    -- 			},
    -- 			import = {
    -- 				maven = {
    -- 					enabled = true,
    -- 					offline = {
    -- 						enabled = true,
    -- 					},
    -- 				},
    -- 			},
    -- 			jdt = {
    -- 				ls = {
    -- 					vmargs = "-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
    -- 				},
    -- 			},
    -- 		},
    -- 	},
    -- })

    -------------------------------------------------------------------------
    --------------------- END JAVA CONFIG --------------------------------
    -------------------------------------------------------------------------

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<tab>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
    })
    cmp_mappings["<Tab>"] = nil
    cmp_mappings["<S-Tab>"] = nil
    lsp.setup_nvim_cmp({
        preselect = 1,
        mapping = cmp_mappings,
    })
    lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
            error = "E",
            warn = "W",
            hint = "H",
            info = "I",
        },
    })
    lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vws", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set("n", "<leader>vd", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set("n", "<leader>.", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set("i", "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
    end)
    vim.diagnostic.config({
        virtual_text = true,
    })
    lsp.setup()
end
