local lspconfig = require("lspconfig")
local conform = require("conform")
local mason = require("mason")

return function(on_attach)
	mason.setup({
		ensure_installed = {
			"black",
			"pylsp",
		},
	})

	conform.formatters_by_ft.python = {
		"black",
	}

	lspconfig.pylsp.setup({
		on_attach = on_attach,
	})
end
