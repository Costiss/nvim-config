 require('costis.remap')
 require('costis.set')
 if vim.g.vscode then
 	vim.g.codeium_enabled = false
 else
 	vim.api.nvim_set_keymap('n', '<Leader>c', ':Commentary<CR>', { noremap = true, silent = true })

 	vim.api.nvim_set_keymap('x', '<Leader>c', ':Commentary<CR>', { noremap = true, silent = true })
 end
