local lspconfig = require("lspconfig")
local conform = require("conform")

return function(on_attach)
	conform.formatters_by_ft.json = {
		"prettierd",
	}

	lspconfig.jsonls.setup({
		on_attach = on_attach,
	})
end
