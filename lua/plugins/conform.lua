return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" }, -- if you use Mason
		config = function()
			local conform = require("conform")

			local function has_biome_config()
				return vim.fn.filereadable("biome.json") == 1 or vim.fn.filereadable("biome.jsonc") == 1
			end

			-- Determine formatter based on biome config presence
			local js_formatters = has_biome_config() and { "biome", stop_after_first = true } or { "prettier" }

			conform.setup({
				formatters_by_ft = {
					typescript = js_formatters,
					javascript = js_formatters,
					javascriptreact = js_formatters,
					typescriptreact = js_formatters,
					markdown = { "prettierd" },
					graphql = { "prettierd" },
					svelte = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = js_formatters,
					yaml = { "prettierd" },
					xml = { "prettierd" },
					sql = { "sql_formatter" },
					scala = { "scalafmt" },
					proto = { "buf" },
					go = { "goimports", "gofmt" },
					-- elixir = { "lexical" },
					-- python = { "isort", "black" },
				},
				formatters = {
					biome = {
						command = "biome",
						args = { "check", "--write", "$FILENAME" }, --  ← this was the magic that fixed organizing imports
						stdin = false,
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
