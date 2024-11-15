local lspconfig = require("lspconfig")

return function(on_attach)
    lspconfig.gleam.setup({
        cmd = { "gleam", "lsp" },
        filetypes = { "gleam" },
        on_attach = on_attach,
    })
end
