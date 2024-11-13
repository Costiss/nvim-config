local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.swift.setup({
		cmd = { "sourcekit-lsp" },
		filetypes = { "swift" },
		on_attach = function(client, bufnr)
			require("lsp-format").on_attach(client, bufnr)
			on_attach(client, bufnr)
		end,
		root_dir = lspconfig.util.root_pattern("Package.swift"),
	})
end
