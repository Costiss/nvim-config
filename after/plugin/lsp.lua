if vim.g.vscode then
    -- VSCode extension
else
    local lsp = require('lsp-zero')


    lsp.preset('recommended')

    lsp.ensure_installed({
        'tsserver',
        'eslint',
        'rust_analyzer',
        'gopls',
        'efm'
    })


    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            -- Langs
            "tsserver",
            "rust_analyzer",
            "gopls",
            "efm",
            "lua_ls",
            "kotlin_language_server",
            "clangd",
            "zls",
            -- HTML/CSS
            "html",
            "tailwindcss",
            -- CI/CD
            "docker_compose_language_service",
            "dockerls",
            "terraformls",
            -- JS ECOSSYSTEM
            "eslint",
            "prismals",
            "volar"
        }
    })

    -- LSPs Setups ---------------------------------------------------------------------------------------------------
    local lsp_format = require('lsp-format')
    lsp_format.setup({
        tab_width = 4,
    })

    local lspconfig = require('lspconfig')

    -- LspConfig/Languages -------------------------------------------------------------------------
    lspconfig.rust_analyzer.setup({ -- RUST
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.zls.setup({ -- RUST
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.gopls.setup({ -- GOLANG
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
                usePlaceholders = false,
            }
        },
    })
    lspconfig.tsserver.setup({}) --TYPESCRIPT

    local efm_formatters = {
        prettier = {
            formatCommand = './node_modules/.bin/prettier',
            rootMarkers = { 'package.json' },
        },
        prettierd = {
            formatCommand = 'prettierd ${INPUT}',
            formatStdin = true,
        },
    }

    lspconfig.efm.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end,
        init_options = {
            documentFormatting = true,
        },
        filetypes = {
            'typescript',
            'typescriptreact',
            'javascript',
            'javascriptreact',
            'css',
            'json',
            'html',
        },
        settings = {
            languages = {
                typescript = { efm_formatters.prettierd },
                typescriptreact = { efm_formatters.prettierd },
                javascript = { efm_formatters.prettierd },
                javascriptreact = { efm_formatters.prettierd },
                json = { efm_formatters.prettierd },
                css = { efm_formatters.prettierd },
                html = { efm_formatters.prettierd },
            },
        },
    })
    lspconfig.lua_ls.setup({ -- LUA
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.clangd.setup({ -- C / C ++
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    -- LspConfig/HTML-CSS -----------------------------------------------------------------------
    lspconfig.html.setup({ -- HTML
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
            require("lsp-format").filetypes_map.html = 'prettier'
        end
    })
    lspconfig.tailwindcss.setup({ -- TAILWIND
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    -- LspConfig/CI-CD
    lspconfig.dockerls.setup({ -- DOCKER
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.docker_compose_language_service.setup({ -- DOCKER COMPOSE
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.terraformls.setup({ -- TERRAFORM
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })

    -- LspConfig/JS ECOSSYSTEM -------------------------------------------------------------------
    -- lspconfig.eslint.setup({ -- ESLINT
    --     on_attach = function(client, bufnr)
    --         require("lsp-format").on_attach(client, bufnr)

    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --             buffer = bufnr,
    --             command = "EslintFixAll",
    --         })
    --     end
    -- })
    lspconfig.prismals.setup({ -- PRISMA ORM
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.volar.setup({ -- VOLAR
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    -- End LSPs Setups -- ---------------------------------------------------------------------------------------------

    -- Fix Undefined global 'vim'
    lsp.nvim_workspace()




    local cmp = require('cmp')
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<tab>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
    })

    cmp_mappings['<Tab>'] = nil
    cmp_mappings['<S-Tab>'] = nil

    lsp.setup_nvim_cmp({
        preselect = 1,
        mapping = cmp_mappings
    })

    lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
            error = 'E',
            warn = 'W',
            hint = 'H',
            info = 'I'
        }
    })

    lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>.", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end)

    lsp.setup()

    vim.diagnostic.config({
        virtual_text = true
    })

    -- ordinary Neovim
end
