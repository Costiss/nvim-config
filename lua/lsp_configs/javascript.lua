local lspconfig = require("lspconfig")
local conform = require("conform")

return function(on_attach)
	-- lspconfig.tsserver.setup({
	-- 	on_attach = nil,
	-- })
	conform.formatters_by_ft.javascript = {
		"prettierd",
		"eslint_d",
	}
	conform.formatters_by_ft.typescript = {
		"prettierd",
		"eslint_d",
	}
	conform.formatters_by_ft.typesriptreact = {
		"prettierd",
		"eslint_d",
	}
	conform.formatters_by_ft.javascriptreact = {
		"prettierd",
		"eslint_d",
	}

	lspconfig.vtsls.setup({
		on_attach = on_attach,
		--cmd = { "bun", "x", "--bun", "vtsls", "--stdio" },
		settings = {
			vtsls = {
				autoUseWorkspaceTsdk = true, -- Automatically use the workspace TypeScript version
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
		--cmd = { "bunx", "--bun", "vscode-eslint-language-server", "--stdio" },
		root_dir = lspconfig.util.root_pattern(".git"),
		settings = {
			-- eslint = {
			-- 	executable = "$HOME/.bun/bin/eslint_d",
			-- 	enable = true,
			-- 	format = { enable = true },
			-- 	packageManager = "bun",
			-- 	autoFixOnSave = true,
			-- 	codeActionsOnSave = {
			-- 		mode = "all",
			-- 		rules = { "!debugger", "!no-only-tests/*" },
			-- 	},
			-- 	lintTask = {
			-- 		enable = true,
			-- 	},
			-- },
		},
	})

	--:MasonInstall vue-language-server@1.8.27
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

	lspconfig.volar.setup({
		on_new_config = function(new_config, new_root_dir)
			new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		end,
		init_options = {
			vue = {
				hybridMode = false,
			},
		},
	})
end
