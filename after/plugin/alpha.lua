local alpha = require('alpha')
local alpha_theme = require('alpha.themes.dashboard')


alpha.setup(alpha_theme.config)


alpha_theme.section.buttons.val = {
    alpha_theme.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    alpha_theme.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
    alpha_theme.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
    alpha_theme.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
    alpha_theme.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
    alpha_theme.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
    alpha_theme.button("q", " " .. " Quit", ":qa<CR>"),
}
