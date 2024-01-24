-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]
if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
    return require('packer').startup(function(use)
        use 'tpope/vim-commentary'

        use 'wbthomason/packer.nvim'

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.4',
            -- or                            , branch = '0.1.x',
            requires = { { 'nvim-lua/plenary.nvim' } }
        }

        use 'folke/tokyonight.nvim'
        vim.cmd [[colorscheme tokyonight-night]]

        use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })


        use('nvim-treesitter/playground')

        use('theprimeagen/harpoon')

        use('nvim-lua/plenary.nvim')

        use('mbbill/undotree')

        use { "bluz71/vim-nightfly-colors", as = "nightly" }

        use('tpope/vim-fugitive')

        use("lukas-reineke/lsp-format.nvim")

        use('nvim-tree/nvim-web-devicons')

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }

        use('andweeb/presence.nvim')

        use {
            'lewis6991/gitsigns.nvim',
            -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
        }

        use {
            'goolord/alpha-nvim',
            requires = { 'nvim-tree/nvim-web-devicons' },
        }


        use('nvim-tree/nvim-tree.lua')

        use {
            'Exafunction/codeium.vim',
            config = function()
                -- Change '<C-g>' here to any keycode you like.
                vim.keymap.set('i', '<tab>', function() return vim.fn['codeium#Accept']() end, { expr = true })
                vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
                vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                    { expr = true })
                vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
            end
        }

        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' }, -- Required
                {
                    -- Optional
                    'williamboman/mason.nvim',
                    run = function()
                        pcall(vim.cmd, 'MasonUpdate')
                    end,
                },
                { 'williamboman/mason-lspconfig.nvim' }, -- Optional

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },     -- Required
                { 'hrsh7th/cmp-nvim-lsp' }, -- Required
                { 'L3MON4D3/LuaSnip' },     -- Required
            }

        }

        use {
            "AstroNvim/astrocommunity",
            { import = "astrocommunity.pack.java" },
            {
                "mfussenegger/nvim-jdtls",
                opts = {
                    settings = {
                        java = {
                            configuration = {
                                runtimes = {
                                    {
                                        name = "java11",
                                        path = "/home/gabriel-costa/.jdks/corretto-11.0.21/",
                                    },
                                    {
                                        name = "java17",
                                        path = "~/.jdks/temurin-17.0.9/",
                                    },
                                },
                            },
                        },
                    },
                },
            },
        }


        use "tpope/vim-commentary"
    end)
end
