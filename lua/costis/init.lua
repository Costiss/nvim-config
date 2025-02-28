require("costis.remap")
require("costis.set")

vim.keymap.set("n", "<leader>c", function()
	vim.api.nvim_feedkeys("gcc", "x", true)
end, { desc = "Toggle Line Comment" })

vim.keymap.set("v", "<leader>c", function()
	vim.api.nvim_feedkeys("gc", "v", true)
end, { desc = "Toggle Line Comment" })

vim.api.nvim_create_user_command("Json", function()
	vim.cmd("set filetype=json")
end, {})

vim.g["test#runner_commands"] = { "Vitest", "Jest" }
