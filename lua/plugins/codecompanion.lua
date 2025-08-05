return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			strategies = {
				chat = {
					adapter = {
						name = "copilot",
						model = "claude-sonnet-4",
					},
					keymaps = {
						clear = {
							modes = {
								n = "<C-l>",
								i = "<C-l>",
								v = "<C-l>",
							},
							opts = {},
						},
					},
				},
			},
		},
		config = function(opts)
			require("codecompanion").setup(opts)

			vim.keymap.set("n", "<leader>com", function()
				vim.cmd("CodeCompanionChat")
			end)
		end,
	},
}
