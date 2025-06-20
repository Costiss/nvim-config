local lspconfig = require("lspconfig")
local conform = require("conform")
local mason_install = require("costis.helpers.mason_install")

return function(on_attach)
	mason_install({
		"lua-language-server",
		"stylua",
	})

	conform.formatters_by_ft.lua = {
		"stylua",
	}

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
