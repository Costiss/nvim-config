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
        ensure_installed = { "tsserver", "eslint", "rust_analyzer", "gopls", "efm", "lua_ls", "html" }
    })

    -- LSPs Setups
    local lsp_format = require('lsp-format')
    lsp_format.setup({
        tab_width = 4,
    })

    local lspconfig = require('lspconfig')

    lspconfig.html.setup({
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })

    lspconfig.tsserver.setup({
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.eslint.setup({
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.rust_analyzer.setup({
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })
    lspconfig.gopls.setup({
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
            }
        },
    })

    lspconfig.lua_ls.setup({
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })

    lspconfig.efm.setup({
        on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    })

    -- lspconfig.kotlin_language_server.setup({
    --     on_attach = function(client, bufnr) require("lsp-format").on_attach(client, bufnr) end
    -- })

    -- End LSPs Setups --

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
        vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end)

    lsp.setup()

    vim.diagnostic.config({
        virtual_text = true
    })

    -- ordinary Neovim
end
