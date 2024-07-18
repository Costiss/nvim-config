function ColorGlobal(color)
    color = color or "tokyonight-moon"
    vim.cmd.colorscheme(color)
end

ColorGlobal()
-- ordinary Neovim
