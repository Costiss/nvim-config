local function on_attach(bufnr)
    local api = require "nvim-tree.api"


    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', '<S-t>', api.tree.toggle)
end

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        git_ignored = false,
        dotfiles = false,
        custom = { "^.git$" }
    },
    on_attach = on_attach
})
