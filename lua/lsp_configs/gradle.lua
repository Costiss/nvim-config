local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.groovyls.setup({
		on_attach = on_attach,
	})

	lspconfig.gradle_ls.setup({
		on_attach = on_attach,
	})
end
