local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
end
