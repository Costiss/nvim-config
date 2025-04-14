-- ~/.config/nvim/lua/plugins/copilot.lua
return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			-- Disable default mappings
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true

			-- Custom key mappings
			vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("\\<Tab>")', {
				expr = true,
				silent = true,
				noremap = true,
			})

			vim.api.nvim_set_keymap("i", "<M-]>", "<Plug>(copilot-next)", {
				silent = true,
				noremap = false,
			})

			vim.api.nvim_set_keymap("i", "<M-[>", "<Plug>(copilot-previous)", {
				silent = true,
				noremap = false,
			})
		end,
	},
}
