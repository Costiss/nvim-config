local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"json-lsp",
	})

	vim.lsp.config("jsonls", {})

	vim.lsp.enable("jsonls")
end
