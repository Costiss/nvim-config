local conform = require("conform")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"kotlin-lsp",
	})

	conform.formatters_by_ft.kotlin = {
		"ktlint",
	}

	-- Define or override the configuration
	vim.lsp.config("kotlin_lsp", {
		cmd = { "kotlin-lsp", "--stdio" },
		filetypes = { "kotlin" },
		cmd_env = {
			JAVA_HOME = vim.fn.expand("$HOME/.sdkman/candidates/java/17.0.14-tem"),
		},
		root_markers = {
			"settings.gradle.kts",
			"settings.gradle",
			"build.gradle.kts",
			"build.gradle",
		},
		-- Optional: add specific initialization settings
		settings = {
			kotlin = {
				compiler = {
					jvm = {
						target = "17", -- Set your project's JVM target
					},
				},
			},
		},
	})

	-- Enable it for the current session
	vim.lsp.enable("kotlin_lsp")

	vim.lsp.enable("kotlin-lsp")
end
