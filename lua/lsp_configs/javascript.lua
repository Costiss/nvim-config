local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function()
	mason_install({
		"vtsls",
		"prisma-language-server",
		"eslint-lsp",
		"prettierd",
		"eslint_d",
		"biome",
		"tailwindcss-language-server",
		"deno",
		--"vue-language-server",
	})

	vim.lsp.config("denols", {
		root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
	})

	vim.lsp.config("vtsls", {
		root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
		--single_file_support = false,
		--cmd = { "bun", "x", "--bun", "vtsls", "--stdio" },
		settings = {
			vtsls = {
				autoUseWorkspaceTsdk = true, -- Automatically use the workspace TypeScript version
				typescript = {
					preferences = {
						organizeImports = true,
					},
				},
			},
		},
	})

	vim.lsp.config("prismals", {})

	vim.lsp.config("eslint", {
		--cmd = { "bunx", "--bun", "vscode-eslint-language-server", "--stdio" },
		settings = {
			eslint = {
				enable = true,
				executable = vim.env.HOME .. "/.bun/bin/eslint_d",
				format = { enable = false },
				packageManager = "bun",
				autoFixOnSave = true,
				codeActionsOnSave = {
					enable = false,
					mode = "all",
					rules = { "!debugger", "!no-only-tests/*" },
				},
				lintTask = {
					enable = true,
				},
			},
		},
	})

	vim.lsp.config("biome", {
		root_dir = require("lspconfig.util").root_pattern("biome.json"),
		settings = {
			biome = {
				format = {
					enable = true,
				},
				lint = {
					enable = true,
				},
			},
		},
	})

	vim.lsp.config("tailwindcss", {})

	vim.lsp.config("astro", {})

	-- :MasonInstall vue-language-server@1.8.27
	local util = require("lspconfig.util")
	local function get_typescript_server_path(root_dir)
		local global_ts = vim.fn.expand("$HOME/.bun/lib/node_modules/typescript/lib")
		-- Alternative location if installed as root:
		-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
		local found_ts = ""
		local function check_dir(path)
			found_ts = util.path.join(path, "node_modules", "typescript", "lib")
			if util.path.exists(found_ts) then
				return path
			end
		end
		if util.search_ancestors(root_dir, check_dir) then
			return found_ts
		else
			print("found global")
			return global_ts
		end
	end

	vim.lsp.config("volar", {
		on_new_config = function(new_config, new_root_dir)
			new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		end,
		init_options = {
			vue = {
				hybridMode = false,
			},
		},
	})

	vim.lsp.enable("denols")
	vim.lsp.enable("vtsls")
	vim.lsp.enable("prismals")
	vim.lsp.enable("eslint")
	vim.lsp.enable("biome")
	vim.lsp.enable("tailwindcss")
	vim.lsp.enable("astro")
	-- vim.lsp.enable("volar")
end
