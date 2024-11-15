local lspconfig = require("lspconfig")
local conform = require("conform")

return function(on_attach)
	conform.formatters_by_ft.kotlin = {
		"ktlint",
	}

	lspconfig.kotlin_language_server.setup({
		on_attach = on_attach,
	})
end
