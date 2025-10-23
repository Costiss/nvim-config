local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"basedpyright",
	})

	vim.lsp.config("basedpyright", {})

	vim.lsp.enable("basedpyright")
end
