local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.zls.setup({
		on_attach = function(client, bufnr)
			require("lsp-format").on_attach(client, bufnr)
			on_attach(client, bufnr)
		end,
		settings = {
			zig = {
				zls = {
					inlayHintsShowVariableTypeHints = false,
					inlayHintsShowParameterName = false,
					inlayHintsShowBuiltin = false,
					inlayHintsExcludeSingleArgument = false,
					enableArgumentPlaceholders = false,
					completionLabelDetails = false,
					completionsWithReplace = false,
					enableInlayHints = false,
					enableSnippets = false,
				},
			},
		},
	})
end
