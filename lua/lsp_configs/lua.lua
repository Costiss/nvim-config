local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"lua-language-server",
		"stylua",
	})

	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})

	vim.lsp.enable("lua_ls")
end
