local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.elixirls.setup({
		on_attach = function(client, bufnr)
			require("lsp-format").on_attach(client, bufnr)
			on_attach(client, bufnr)
		end,
	})
end
