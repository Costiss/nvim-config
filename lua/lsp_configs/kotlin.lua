local lspconfig = require("lspconfig")
local conform = require("conform")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"kotlin-language-server",
	})

	conform.formatters_by_ft.kotlin = {
		"ktlint",
	}

	vim.lsp.config("kotlin_language_server", {})

	vim.lsp.enable("kotlin_language_server")
end
