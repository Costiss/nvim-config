local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.elixirls.setup({
        on_attach = on_attach,
	})
end
