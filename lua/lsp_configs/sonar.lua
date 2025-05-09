local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.rust_analyzer.setup({
		on_attach = function(client, bufnr)
			require("lsp-format").on_attach(client, bufnr)
			on_attach(client, bufnr)
		end,
	})
e
