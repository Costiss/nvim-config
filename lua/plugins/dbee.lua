return {
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install("go")
		end,
		config = function()
			local dbee = require("dbee")
			dbee.setup(--[[optional config]])

			vim.keymap.set("n", "<leader>DB", function()
				dbee.toggle()
			end, { noremap = true, silent = true })
		end,
	},
}
