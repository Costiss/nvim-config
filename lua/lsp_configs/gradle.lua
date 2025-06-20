local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function(on_attach)
	mason_install({
		"groovy-language-server",
		"gradle-language-server",
	})

	lspconfig.groovyls.setup({
		on_attach = on_attach,
	})

	lspconfig.gradle_ls.setup({
		on_attach = on_attach,
	})
end
