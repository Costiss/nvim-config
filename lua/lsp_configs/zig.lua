local lspconfig = require("lspconfig")

return function(on_attach)
	vim.lsp.config("zls", {
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
