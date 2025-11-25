return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" }, -- if you use Mason
		config = function()
			local conform = require("conform")
			local mason_install = require("lsp_configs.helpers.mason_install")
			mason_install({
				"prettierd",
				"biome",
				"sql-formatter",
				"buf",
				"goimports",
				"gopls",
				"ruff",
				"stylua",
			})

			local function has_biome_config()
				return vim.fn.filereadable("biome.json") == 1 or vim.fn.filereadable("biome.jsonc") == 1
			end

			local function has_prettier_config()
				-- Common Prettier config files
				local prettier_configs = {
					".prettierrc",
					".prettierrc.json",
					".prettierrc.js",
					".prettierrc.cjs",
					".prettierrc.toml",
					".prettierrc.yaml",
					".prettierrc.yml",
					"prettier.config.js",
					"prettier.config.cjs",
				}

				for _, config_file in ipairs(prettier_configs) do
					if vim.fn.filereadable(config_file) == 1 then
						return true
					end
				end

				-- Also check package.json for prettier configuration
				if vim.fn.filereadable("package.json") == 1 then
					local package_json = vim.fn.readfile("package.json")
					local package_content = table.concat(package_json, "\n")
					if package_content:find('"prettier"') then
						return true
					end
				end

				return false
			end

			-- Determine formatter based on config presence
			local function get_js_formatters()
				if has_prettier_config() then
					return { "prettierd" }
				elseif has_biome_config() then
					return { "biome", stop_after_first = true }
				else
					-- Default to biome if no configs found
					return { "biome", stop_after_first = true }
				end
			end

			conform.setup({
				formatters_by_ft = {
					typescript = get_js_formatters(),
					javascript = get_js_formatters(),
					javascriptreact = get_js_formatters(),
					typescriptreact = get_js_formatters(),
					markdown = { "prettierd" },
					graphql = { "prettierd" },
					svelte = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = get_js_formatters(),
					yaml = { "prettierd" },
					xml = { "prettierd" },
					sql = { "sql_formatter" },
					scala = { "scalafmt" },
					proto = { "buf" },
					go = { "goimports", "gofmt", "swag" },
					-- elixir = { "lexical" },
					python = { "ruff_format" },
					lua = { "stylua" },
					prisma = { "prisma" },
				},
				formatters = {
					biome = {
						command = "biome",
						args = { "check", "--unsafe", "--write", "$FILENAME" },
						stdin = false,
					},
					swag = {
						command = "swag",
						args = { "fmt", "-pipe" },
						stdin = true,
					},
				},
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 10000,
				},
			})

			-- Save without format
			vim.keymap.set({ "n", "v" }, "<leader>s", function()
				vim.cmd([[:noautocmd w]])
			end, { desc = "Save without formatting" })
		end,
		-- Optional: Add event triggers if you want lazy loading
		-- event = { "BufReadPre", "BufNewFile" },
	},
}
