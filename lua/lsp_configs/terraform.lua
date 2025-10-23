local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"terraform-ls",
		"tflint",
	})

	vim.lsp.config("terraformls", {})
	vim.lsp.enable("terraformls")

	vim.lsp.config("tflint", {})
	vim.lsp.enable("tflint")
end
