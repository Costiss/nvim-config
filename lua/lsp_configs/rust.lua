local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"rust-analyzer",
	})

	vim.lsp.config("rust-analyzer", {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		settings = {
			["rust-analyzer"] = {
				files = { watcher = "server" },
				cargo = { targetDir = true },
				check = { command = "clippy" },
				inlayHints = {
					bindingModeHints = { enabled = true },
					closureCaptureHints = { enabled = true },
					closureReturnTypeHints = { enable = "always" },
					maxLength = 100,
				},
				rustc = { source = "discover" },
			},
		},
		root_markers = { { "Config.toml" }, ".git" },
	})

	vim.lsp.enable("rust-analyzer")
end
