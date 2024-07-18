local lspconfig = require("lspconfig")

return function(on_attach)
	lspconfig.zls.setup({
		on_attach = on_attach,
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
