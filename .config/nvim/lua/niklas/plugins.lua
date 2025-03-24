return require("packer").startup { function(use)
        use "wbthomason/packer.nvim"

        use "nvim-lua/plenary.nvim"
        use "kyazdani42/nvim-web-devicons"
        use "lewis6991/gitsigns.nvim"
        use "feline-nvim/feline.nvim"

        -- Navigation and extensions
        use "airblade/vim-rooter"
        use "alvan/vim-closetag"
        -- use "mattn/emmet-vim"
        use "numToStr/Comment.nvim"
        use "junegunn/vim-easy-align"
        use "tpope/vim-fugitive"
        use "norcalli/nvim-colorizer.lua"

        -- Colorschemes
        -- use "tjdevries/colorbuddy.nvim"
        -- use "tjdevries/gruvbuddy.nvim"
        use "gruvbox-community/gruvbox"
        use "ayu-theme/ayu-vim"
        -- use "vigoux/oak"
        -- use "glepnir/zephyr-nvim"
        -- use "shaunsingh/nord.nvim"
        use "rmehri01/onenord.nvim"
        use "rebelot/kanagawa.nvim"

        use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }
        -- use "nvim-telescope/telescope-fzy-native.nvim"
        use "natecraddock/telescope-zf-native.nvim"

        -- Extra syntaxes
        use "stephpy/vim-yaml"
        use "tikhomirov/vim-glsl"
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                vim.cmd [[TSUpdate]]
            end,
        }
        use "nvim-treesitter/nvim-treesitter-context"
        use { "kaarmu/typst.vim", ft = "typst" }

        -- LSP
        use "neovim/nvim-lspconfig"
        use "nvim-lua/lsp-status.nvim"
        use "jose-elias-alvarez/null-ls.nvim"
        use "Julian/lean.nvim"

        -- Completion
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-cmdline"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-calc"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-emoji"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-nvim-lsp"

        use "L3MON4D3/LuaSnip"

        use "dstein64/vim-startuptime"
    end,
}
