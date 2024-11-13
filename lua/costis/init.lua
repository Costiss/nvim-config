require("costis.remap")
require("costis.set")

vim.api.nvim_set_keymap("n", "<Leader>c", ":Commentary<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<Leader>c", ":Commentary<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("Json", function()
	vim.cmd("set filetype=json")
end, {})

vim.g["test#runner_commands"] = { "Vitest" }
