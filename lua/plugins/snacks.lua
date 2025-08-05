return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = false },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			picker = {
				enabled = true,
				ui_select = true,
				-- formatters = {
				-- 	file = {
				-- 		filename_first = true,
				-- 	},
				-- },
			},
			notifier = { enabled = false },
			quickfile = { enabled = true },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
		config = function(_, opts)
			require("snacks").setup(opts)
			vim.ui.select = require("snacks.picker").select
		end,
	},
}
