local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.kotlin_language_server.setup({
		on_attach = on_attach,
	})
end
