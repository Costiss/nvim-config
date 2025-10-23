local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function(on_attach)
	mason_install({
		"gopls",
		"goimports",
	})

	vim.lsp.config("gopls", {})

	vim.lsp.enable("gopls")
end
