local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"tsp-server",
	})

	vim.lsp.config("typespec", {})

	vim.lsp.enable("typespec")
end
