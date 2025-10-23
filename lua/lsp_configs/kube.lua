local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"helm-ls",
	})

	vim.lsp.config("helm_ls", {})

	vim.lsp.enable("helm_ls")
end
