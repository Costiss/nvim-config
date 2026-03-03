local conform = require("conform")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"kotlin-lsp",
	})

	conform.formatters_by_ft.kotlin = {
		"ktlint",
	}

	vim.lsp.config("kotlin_lsp", {
		cmd = { "kotlin-lsp", "--stdio" },
		filetypes = { "kotlin", "kotlin.kts", "java" },
		single_file_support = true,
		root_markers = {
			"settings.gradle.kts",
			"settings.gradle",
			"build.gradle.kts",
			"build.gradle",
			".git",
			"gradlew",
			"mvnw",
			"pom.xml",
		},
		settings = {
			kotlin = {
				compiler = {
					jvm = {
						target = "17", -- Set your project's JVM target
					},
				},
				scripts = {
					buildScriptsEnabled = true,
				},
				externalLibraries = {
					maven = {
						enabled = true,
						localRepository = vim.fn.expand("$HOME/.m2/repository"), -- Path to your local Maven repository
						useMavenWrapper = true, -- Use Maven Wrapper if available
					},
				},
			},
		},
	})

	-- Enable it for the current session
	vim.lsp.enable("kotlin_lsp")
end
