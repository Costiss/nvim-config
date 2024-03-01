local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', function()
    builtin.find_files({ hidden = true })
end)
vim.keymap.set('n', '<C-f>', function()
    builtin.find_files({ hidden = true })
end)

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > "), hidden = true });
end)

-- Live grep
vim.keymap.set('n', '<leader>pg', function()
    builtin.live_grep({ default_text = vim.fn.expand('<cword>'), hidden = true });
end);


require('telescope').setup {
    defaults = {
        file_ignore_patterns = { "node_modules", "target", "build", "dist" }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}
