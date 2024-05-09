-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]
if vim.g.vscode then
	-- VSCode extension
else
	-- ordinary Neovim
	return require("packer").startup(function(use)
		use("tpope/vim-commentary")

		use({ "wbthomason/packer.nvim" })

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.4",
			-- or                            , branch = '0.1.x',
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		use("folke/tokyonight.nvim")
		vim.cmd([[colorscheme tokyonight-moon]])

		use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

		use("nvim-treesitter/playground")

		use("theprimeagen/harpoon")

		use("nvim-lua/plenary.nvim")

		use("mbbill/undotree")

		use({ "bluz71/vim-nightfly-colors", as = "nightly" })

		use("tpope/vim-fugitive")

		use("lukas-reineke/lsp-format.nvim")

		use("nvim-tree/nvim-web-devicons")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
		})

		use("andweeb/presence.nvim")

		use({
			"lewis6991/gitsigns.nvim",
			-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
		})

		use({
			"goolord/alpha-nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
		})

		use("nvim-tree/nvim-tree.lua")

		use({
			"Exafunction/codeium.vim",
			tag = "1.6.13",
			config = function()
				-- Change '<C-g>' here to any keycode you like.
				vim.keymap.set("i", "<tab>", function()
					return vim.fn["codeium#Accept"]()
				end, { expr = true })
				vim.keymap.set("i", "<c-;>", function()
					return vim.fn["codeium#CycleCompletions"](1)
				end, { expr = true })
				vim.keymap.set("i", "<c-,>", function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end, { expr = true })
				vim.keymap.set("i", "<c-x>", function()
					return vim.fn["codeium#Clear"]()
				end, { expr = true })
			end,
		})

		use({
			"VonHeikemen/lsp-zero.nvim",
			branch = "v2.x",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" }, -- Required
				{
					-- Optional
					"williamboman/mason.nvim",
					run = function()
						pcall(vim.cmd, "MasonUpdate")
					end,
				},
				{ "williamboman/mason-lspconfig.nvim" }, -- Optional

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" }, -- Required
				{ "hrsh7th/cmp-nvim-lsp" }, -- Required
				{ "L3MON4D3/LuaSnip" }, -- Required
			},
		})

		-- use {
		--     "AstroNvim/astrocommunity",
		--     { import = "astrocommunity.pack.java" },
		--     {
		--         "mfussenegger/nvim-jdtls",
		--     },
		-- }

		-- packer.nvim
		use({ "smithbm2316/centerpad.nvim" })

		use({ "vim-test/vim-test" })

		use({
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		})

		use({
			"m4xshen/autoclose.nvim",
			config = function()
				require("autoclose").setup()
			end,
		})

		use({ "cdelledonne/vim-cmake" })

		use({ "folke/trouble.nvim" })
		use({ "gleam-lang/gleam.vim" })

		-- cd ~/.local/share/nvim/site/pack/packer/start/
		-- git clone https://github.com/iamcco/markdown-preview.nvim.git
		-- cd markdown-preview.nvim
		-- npx --yes yarn install
		-- npx --yes yarn build
		use({ "iamcco/markdown-preview.nvim" })

		use({
			"stevearc/conform.nvim",
			config = function()
				require("conform").setup()
			end,
		})
		use("mfussenegger/nvim-lint")
	end)
end
