local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		elixir = { "lexical" },
		xml = { "prettierd" },
		-- python = { "isort", "black" },
	},
	format_on_save = {
		lsp_fallback = false,
		timeout_ms = 500,
	},
})
-- Save without format
vim.keymap.set({ "n", "v" }, "<leader>s", function()
	vim.cmd([[:noautocmd w]])
end)

-- local lint = require("lint")

-- lint.linters_by_ft = {
--     javascript = { "eslint_d" },
--     typescript = { "eslint_d" },
--     javascriptreact = { "eslint_d" },
--     typescriptreact = { "eslint_d" },
--     svelte = { "eslint_d" },
--     -- python = { "pylint" },
-- }

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     callback = function()
--         require("lint").try_lint()
--     end,
-- })
