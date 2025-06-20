local lspconfig = require("lspconfig")
local conform = require("conform")
local mason_install = require("costis.helpers.mason_install")

return function(on_attach)
	mason_install({
		"json-lsp",
	})

	conform.formatters_by_ft.json = {
		"prettierd",
	}

	lspconfig.jsonls.setup({
		on_attach = on_attach,
	})
end
