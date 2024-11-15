local lspconfig = require("lspconfig")

return function(on_attach)
    lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
    })
end
