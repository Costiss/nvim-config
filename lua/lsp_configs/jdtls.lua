local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function(on_attach)
	mason_install({
		"jdtls",
	})

	lspconfig.jdtls.setup({
		on_attach = on_attach,
		cmd_env = {
			JAVA_HOME = vim.fn.expand("$HOME/.sdkman/candidates/java/21.0.7-jbr"),
		},
		cmd = {
			"jdtls",
			"--jvm-arg=-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
			"--jvm-arg=-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"--jvm-arg=-Dosgi.bundles.defaultStartLevel=4",
			"--jvm-arg=-Declipse.product=org.eclipse.jdt.ls.core.product",
			"--jvm-arg=-Dlog.protocol=true",
			"--jvm-arg=-Dlog.level=ALL",
			"--jvm-arg=-Xmx1g",
			"--jvm-arg=--add-modules=ALL-SYSTEM",
			"--jvm-arg=--add-opens=java.base/java.util=ALL-UNNAMED",
			"--jvm-arg=--add-opens=java.base/java.lang=ALL-UNNAMED",
			vim.fn.expand("-configuration $HOME/.cache/jdtls/config"),
			vim.fn.expand("-data $HOME/.cache/jdtls/workspace"),
		},
		settings = {
			java = {
				contentProvider = { preferred = "fernflower" },
				maven = {
					downloadSources = true,
					updateSnapshots = true,
				},
				eclipse = {
					downloadSources = true,
				},
				import = {
					maven = {
						enabled = true,
						offline = {
							enabled = true,
						},
					},
				},
				jdt = {
					ls = {
						vmargs = "-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
					},
				},
			},
		},
	})
end
