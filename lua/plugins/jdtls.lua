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
			-- Improved jdtls config: use mason-installed jdtls, proper java launcher,
			-- better root detection for Android/Gradle projects and per-project workspace.
			local util = require("lspconfig.util")

			local root_files = {
				"settings.gradle",
				"settings.gradle.kts",
				"build.gradle",
				"build.gradle.kts",
				"gradlew",
				"gradle.properties",
				"local.properties",
				".git",
				"mvnw",
			}
			local root_dir = util.root_pattern(unpack(root_files))(vim.fn.getcwd())
				or util.root_pattern(unpack(root_files))(vim.api.nvim_buf_get_name(0))
			if not root_dir or root_dir == "" then
				root_dir = vim.fn.getcwd()
			end

			local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
			local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

			local java_home = vim.fn.expand("$HOME/.sdkman/candidates/java/21.0.7-jbr")
			local java_cmd = java_home .. "/bin/java"

			local mason_jdtls = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls")
			local equinox_jar = vim.fn.glob(mason_jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar")
			local os_config = vim.fn.has("mac") == 1 and "config_mac"
				or (vim.fn.has("win32") == 1 and "config_win" or "config_linux")
			local config_dir = mason_jdtls .. "/" .. os_config

			-- try to find lombok shipped with mason jdtls
			local lombok_jar = vim.fn.glob(mason_jdtls .. "/lombok.jar")
			if lombok_jar == "" then
				-- fallback to a common path
				lombok_jar = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar")
			end

			local cmd = {
				java_cmd,
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx4g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
			}

			if lombok_jar ~= "" then
				table.insert(cmd, "-javaagent:" .. lombok_jar)
			end

			table.insert(cmd, "-jar")
			table.insert(cmd, equinox_jar)
			table.insert(cmd, "-configuration")
			table.insert(cmd, config_dir)
			table.insert(cmd, "-data")
			table.insert(cmd, workspace_dir)

			local config = {
				cmd = cmd,
				root_dir = root_dir,
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
						import = {
							gradle = {
								enabled = true,
								wrapper = {
									enabled = true,
								},
							},
						},
					},
				},
				init_options = {
					bundles = {},
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
