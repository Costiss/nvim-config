local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.dartls.setup({
		on_attach = on_attach,
		cmd = { "dart", "language-server", "--protocol=lsp" },
		filetypes = { "dart" },
		root_dir = lspconfig.util.root_pattern("pubspec.yaml", ".git"),
		settings = {
			dart = {
				-- sdkPath = vim.fn.expand("$DART_SDK"),
				-- analysisExcludedFolders = { vim.fn.expand("$HOME/.pub-cache") },
			},
		},
	})
end
