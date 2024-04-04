if vim.g.vscode then
    -- VSCode extension
else
    require("editorconfig")
    vim.g.editorconfig = true

    local lsp = require('lsp-zero')
    lsp.nvim_workspace()
    lsp.preset('recommended')
    lsp.ensure_installed({
        'bufls',
        'tsserver',
        'eslint-lsp',
        'prettier',
        'efm',
        'prismals',
        'volar',
        'vtsls',
        'rust_analyzer',
        'gopls',
        'clangd',
        'tailwindcss',
        'html-lsp',
        'json-lsp',
        'docker_compose_language_service',
        'dockerls',
        'terraformls',
        'tflint',
        'lua_ls',
        'kotlin_language_server',
        'ktlint',
        'jdtls',
        'zls',
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
    require('lsp-format').setup {
        go = {
            order = { "gopls", "goimports" }
        }
    }


    -- require('java').setup()
    local lspconfig = require('lspconfig')

    -- LspConfig/Languages -------------------------------------------------------------------------

    -- GLEAM ----------------------------------------------
    lspconfig.gleam.setup({
        cmd = { "gleam", "lsp" },
        filetypes = { "gleam" },
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    -- RUST ---------------------------------------------------------------------------------------
    lspconfig.rust_analyzer.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end,
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                inlayHints = {
                    enable = false
                },
                cargo = {
                    buildScripts = {
                        enable = true
                    }
                },
                procMacro = {
                    enable = true
                },
            }
        }
    })
    -- JAVA --------------------------------------------------------------------------------------
    lspconfig.jdtls.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end,
        settings = {
            java = {
                jdt = {
                    ls = {
                        vmargs = {
                            "-XX:+UseParallelGC",
                            "-XX:GCTimeRatio=4",
                            "-XX:AdaptiveSizePolicyWeight=90",
                            "-Dsun.zip.disableMemoryMapping=true",
                            "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
                            "-Xmx1G",
                            "-Xms100m",
                        }
                    }
                }
            }
        }
    })
    -- KOTLIN -----------------------------------------------------------------------------------
    lspconfig.kotlin_language_server.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end,
        settings = {
            kotlin = {
                java = {
                    opts = {
                        "-XX:+UseParallelGC",
                        "-XX:GCTimeRatio=4",
                        "-XX:AdaptiveSizePolicyWeight=90",
                        "-Dsun.zip.disableMemoryMapping=true",
                        "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
                        "-Xmx1G",
                        "-Xms100m",
                    },
                }
            }
        }
    })
    -- ZiG LANG -------------------------------------------------------------------------------
    lspconfig.zls.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    -- GO LANG --------------------------------------------------------------------------------
    lspconfig.gopls.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end,
        settings = {
            gopls = {
                completeUnimported = true,
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
                usePlaceholders = false,
            }
        },
    })
    -- TYPESCRIPT/JAVASCRIPT ------------------------------------------------------------------------------
    local formatters = {
        eslint_d = {
            formatCommand = 'eslint_d --stdin --fix-to-stdout',
            formatStdin = true,
        },
        prettierd = {
            formatCommand = 'prettierd ${INPUT}',
            formatStdin = true,
        }
    }

    lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end,
        settings = {
            eslint = {
                enable = true,
                format = { enable = true },
                packageManager = "npm",
                autoFixOnSave = true,
                codeActionsOnSave = {
                    mode = "all",
                    rules = { "!debugger", "!no-only-tests/*" },
                },
                lintTask = {
                    enable = true,
                },
            },
        }
    })
    lspconfig.tsserver.setup({
        settings = {
            typescript = {
                format = {
                    enable = false,
                }
            },
            javascript = {
                format = {
                    enable = false,
                }
            }
        }
    })
    lspconfig.vtsls.setup({
        settings = {
            typescript = {
                format = {
                    enable = false,
                }
            },
            javascript = {
                format = {
                    enable = false,
                }
            }
        }
    })
    lspconfig.efm.setup({
        on_attach = function(client, bufnr)
            if client.name == 'eslint' then
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            else
                require('lsp-format').on_attach(client, bufnr)
            end
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
                typescript = { formatters.prettierd },
                typescriptreact = { formatters.prettierd },
                javascript = { formatters.prettierd },
                javascriptreact = { formatters.prettierd },
                json = { formatters.prettierd },
                css = { formatters.prettierd },
                html = { formatters.prettierd },
            },
        },
    })
    -- JSON LS -----------------------------------------------------------------------------
    lspconfig.jsonls.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    -- LUA ----------------------------------------------------------------------------------
    lspconfig.lua_ls.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    -- C/C++ --------------------------------------------------------------------------------
    lspconfig.clangd.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    -- HTML/CSS -----------------------------------------------------------------------------
    lspconfig.html.setup({
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
            require("lsp-format").filetypes_map.html = 'prettier'
        end
    })
    lspconfig.tailwindcss.setup({ -- TAILWIND
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    -- CI/CD --------------------------------------------------------------------------------
    lspconfig.dockerls.setup({ -- DOCKER
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    lspconfig.docker_compose_language_service.setup({ -- DOCKER COMPOSE
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })
    lspconfig.terraformls.setup({ -- TERRAFORM
        on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
        end
    })

    -- JS ECOSSYSTEM -----------------------------------------------------------------------
    lspconfig.prismals.setup({ -- PRISMA ORM
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.volar.setup({ -- VUE
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })

    --- PROTOBUFFERS
    lspconfig.bufls.setup({ -- VUE
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })

    -------------------------------------------------------------------------------------------------------------------
    -- End LSPs Setups -- ---------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------

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
end
