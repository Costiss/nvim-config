return {
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		config = function()
			-- local config = {
			-- 	cmd = {
			-- 		vim.fn.expand("$HOME/.sdkman/candidates/java/21.0.7-jbr/bin/java"),
			-- 		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			-- 		"-Dosgi.bundles.defaultStartLevel=4",
			-- 		"-Declipse.product=org.eclipse.jdt.ls.core.product",
			-- 		"-Dlog.protocol=true",
			-- 		"-Dlog.level=ALL",
			-- 		"-Xmx4g",
			-- 		"--add-modules=ALL-SYSTEM",
			-- 		"--add-opens",
			-- 		"java.base/java.util=ALL-UNNAMED",
			-- 		"--add-opens",
			-- 		"java.base/java.lang=ALL-UNNAMED",
			-- 		"-jar",
			-- 		vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
			-- 		"-configuration",
			-- 		vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/config_mac"),
			-- 		"-data",
			-- 		vim.fn.getcwd() .. "/.workspace",
			-- 	},
			-- 	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
			-- 	settings = {
			-- 		java = {
			-- 			configuration = {
			-- 				runtimes = {
			-- 					{
			-- 						name = "JavaSE-21",
			-- 						path = vim.fn.expand("$HOME/.sdkman/candidates/java/21.0.7-jbr"),
			-- 					},
			-- 					{
			-- 						name = "JavaSE-17",
			-- 						path = vim.fn.expand("$HOME/.sdkman/candidates/java/17.0.14-tem"),
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- }
			local config = {
				cmd = { "jdtls" },
				root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = "JavaSE-21",
									path = vim.fn.expand("$HOME/.sdkman/candidates/java/21.0.7-jbr"),
								},
								{
									name = "JavaSE-17",
									path = vim.fn.expand("$HOME/.sdkman/candidates/java/17.0.14-tem"),
								},
							},
						},
					},
				},
			}

			require("jdtls").start_or_attach(config)
			-- vim.api.nvim_create_autocmd("Filetype", {
			-- 	pattern = "java",
			-- 	callback = function()
			-- 	end,
			-- })
		end,
	},
}
