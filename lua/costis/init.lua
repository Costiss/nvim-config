require("costis.remap")
require("costis.set")
if vim.g.vscode then
	vim.g.codeium_enabled = false
else
	vim.api.nvim_set_keymap("n", "<Leader>c", ":Commentary<CR>", { noremap = true, silent = true })

	vim.api.nvim_set_keymap("x", "<Leader>c", ":Commentary<CR>", { noremap = true, silent = true })
end

return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{
		import = "astrocommunity.editing-support.refactoring-nvim",
	},
	{ import = "astrocommunity.pack.java" },
	{
		import = "astrocommunity.pack.kotlin",
	},
}
