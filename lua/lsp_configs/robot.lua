local lspconfig = require("lspconfig")

return function(on_attach)
    lspconfig.robotframework_ls.setup({
        on_attach = on_attach,
    })
end
