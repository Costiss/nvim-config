local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"groovy-language-server",
		"gradle-language-server",
	})

	vim.lsp.config("groovyls", {})

	vim.lsp.config("gradle_ls", {})

	vim.lsp.enable("groovyls")
	vim.lsp.enable("gradle_ls")
end
