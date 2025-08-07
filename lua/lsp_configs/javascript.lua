local lspconfig = require("lspconfig")
local conform = require("conform")
local mason_install = require("lsp_configs.helpers.mason_install")

return function(on_attach)
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

	local formatters = {
		"prettierd",
		"eslint_d",
	}
	conform.formatters_by_ft.javascript = formatters
	conform.formatters_by_ft.typescript = formatters
	conform.formatters_by_ft.typesriptreact = formatters
	conform.formatters_by_ft.javascriptreact = formatters
	conform.formatters_by_ft.prisma = { "prisma" }

	-- lspconfig.tsserver.setup({
	-- 	on_attach = nil,
	-- })

	lspconfig.denols.setup({
		on_attach = on_attach,
		root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	})

	lspconfig.vtsls.setup({
		on_attach = on_attach,
		root_dir = function(fname)
			-- Don't start vtsls if deno.json is present
			if lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname) then
				return nil
			end
			-- Use default root pattern for other cases
			return lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
		end,
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

	lspconfig.prismals.setup({
		on_attach = on_attach,
	})

	lspconfig.eslint.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
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

	lspconfig.biome.setup({
		on_attach = on_attach,
		root_dir = lspconfig.util.root_pattern("biome.json"),
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

	lspconfig.tailwindcss.setup({
		on_attach = on_attach,
	})

	lspconfig.astro.setup({
		on_attach = on_attach,
	})

	--:MasonInstall vue-language-server@1.8.27
	-- local util = require("lspconfig.util")
	-- local function get_typescript_server_path(root_dir)
	-- 	local global_ts = vim.fn.expand("$HOME/.bun/lib/node_modules/typescript/lib")
	-- 	-- Alternative location if installed as root:
	-- 	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
	-- 	local found_ts = ""
	-- 	local function check_dir(path)
	-- 		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
	-- 		if util.path.exists(found_ts) then
	-- 			return path
	-- 		end
	-- 	end
	-- 	if util.search_ancestors(root_dir, check_dir) then
	-- 		return found_ts
	-- 	else
	-- 		print("found global")
	-- 		return global_ts
	-- 	end
	-- end

	-- lspconfig.volar.setup({
	-- 	on_new_config = function(new_config, new_root_dir)
	-- 		new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
	-- 	end,
	-- 	init_options = {
	-- 		vue = {
	-- 			hybridMode = false,
	-- 		},
	-- 	},
	-- })
end
