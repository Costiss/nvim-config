local lspconfig = require("lspconfig")

return function(on_attach)
	local configs = require("lspconfig/configs")
	configs.swift = {
		default_config = {
			cmd = { "sourcekit-lsp" },
			root_dir = lspconfig.util.root_pattern(".git"),
			filetypes = { "swift" },
		},
	}

	lspconfig.swift.setup({
		on_attach = function(client, bufnr)
			require("lsp-format").on_attach(client, bufnr)
			on_attach(client, bufnr)
		end,
		cmd = { "sourcekit-lsp" },
		filetypes = { "swift" },
	})
end
