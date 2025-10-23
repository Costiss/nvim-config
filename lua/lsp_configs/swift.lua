local lspconfig = require("lspconfig")
local config = require("lspconfig.configs")

return function(on_attach)
	vim.lsp.config("swift", {
		cmd = { "sourcekit-lsp" },
		filetypes = { "swift" },
		root_dir = lspconfig.util.root_pattern("Package.swift"),
	})

	vim.lsp.enable("swift")
end
