if vim.g.vscode then
    -- VSCode extension
else
    function ColorGlobal(color)
        color = color or "tokyonight-storm"
        vim.cmd.colorscheme(color)
    end

    ColorGlobal()
    -- ordinary Neovim
end
