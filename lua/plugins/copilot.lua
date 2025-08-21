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
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		lazy = false,
		priority = 100,
		commit = "75653259442a8eb895abfc70d7064e07aeb7134c",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		config = function()
			require("CopilotChat").setup({
				--model = "claude-sonnet-4",
				model = "gpt-4.1",
				--
				-- sticky = {
				-- 	"#buffers:visible",
				-- 	"$claude-sonnet-4",
				-- 	"#gitdiff:staged",
				-- },
			})

			vim.keymap.set("n", "<leader>ccc", function()
				vim.cmd("CopilotChat")
			end)
		end,
		-- See Commands section for default commands if you want to lazy load on them
	},
}
