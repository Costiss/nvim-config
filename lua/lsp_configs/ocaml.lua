local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.ocamllsp.setup({
		on_attach = on_attach,
	})
end
