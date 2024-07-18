local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.terraformls.setup({
		on_attach = on_attach,
	})

	lspconfig.tflint.setup({
		on_attach = on_attach,
	})
end
