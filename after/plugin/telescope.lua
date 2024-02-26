local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
-- Live grep
vim.keymap.set('n', '<leader>pg', function()
    builtin.live_grep({ default_text = vim.fn.expand('<cword>') })
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
