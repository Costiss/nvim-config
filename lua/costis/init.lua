require("costis.remap")
require("costis.set")

vim.api.nvim_set_keymap("n", "<Leader>c", ":Commentary<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<Leader>c", ":Commentary<CR>", { noremap = true, silent = true })
