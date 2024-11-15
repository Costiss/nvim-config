local lspconfig = require("lspconfig")
local conform = require("conform")

return function(on_attach)
	conform.formatters_by_ft.swift = {
		"swiftformat",
	}

	lspconfig.swift.setup({
		on_attach = on_attach,
		cmd = { "sourcekit-lsp" },
		filetypes = { "swift" },
		root_dir = lspconfig.util.root_pattern("Package.swift"),
	})
end
