local keymap = vim.api.nvim_set_keymap

-- CMake
keymap('', '<leader>cg', ':CMakeGenerate<cr>', {})
keymap('', '<leader>cb', ':CMakeBuild<cr>', {})
keymap('', '<leader>cq', ':CMakeClose<cr>', {})
keymap('', '<leader>cc', ':CMakeClean<cr>', {})
