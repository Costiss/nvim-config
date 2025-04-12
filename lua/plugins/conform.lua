return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" }, -- if you use Mason
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					typescript = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					markdown = { "prettierd" },
					graphql = { "prettierd" },
					svelte = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					xml = { "prettierd" },
					sql = { "sql_formatter" },
					scala = { "scalafmt" },
					proto = { "buf" },
					-- elixir = { "lexical" },
					-- python = { "isort", "black" },
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
