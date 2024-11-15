local lspconfig = require("lspconfig")
local conform = require("conform")

return function(on_attach)
    conform.formatters_by_ft.lua = {
        "stylua",
    }

    lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    })
end
