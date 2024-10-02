function ColorGlobal(color)
	color = color or "tokyonight-night"
	vim.cmd.colorscheme(color)
end

ColorGlobal()
-- ordinary Neovim
