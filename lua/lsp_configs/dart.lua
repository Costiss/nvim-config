local lspconfig = require("lspconfig")

return function(on_attach)
	vim.lsp.config("dartls", {
		cmd = { "dart", "language-server", "--protocol=lsp" },
		filetypes = { "dart" },
		root_dir = require("lspconfig.util").root_pattern("pubspec.yaml", ".git"),
		settings = {
			dart = {
				-- sdkPath = vim.fn.expand("$DART_SDK"),
				-- analysisExcludedFolders = { vim.fn.expand("$HOME/.pub-cache") },
			},
		},
	})

	vim.lsp.enable("dartls")
end
