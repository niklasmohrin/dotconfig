return require("packer").startup {
    function(use)
        use "wbthomason/packer.nvim"

        -- Styling
        -- use "itchyny/lightline.vim"
        use "airblade/vim-gitgutter"        -- Git diff on the left
        use {
            "tjdevries/express_line.nvim",
            requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
        }

        -- Navigation and extensions
        use "airblade/vim-rooter"
        -- use "ahmedkhalf/project.nvim"
        use "alvan/vim-closetag"
        use "turbio/bracey.vim"             -- Live web server
        -- use "tpope/vim-commentary"
        use "numToStr/Comment.nvim"
        use "junegunn/vim-easy-align"

        -- Colorschemes
        use "tjdevries/colorbuddy.nvim"
        use "tjdevries/gruvbuddy.nvim"
        use "gruvbox-community/gruvbox"
        use "ayu-theme/ayu-vim"
        use "vigoux/oak"
        -- use "glepnir/zephyr-nvim"
        use "shaunsingh/nord.nvim"
        use "rmehri01/onenord.nvim"

        -- Debugging
        use { "puremourning/vimspector", disable = true }

        use {
            "nvim-telescope/telescope.nvim",
            requires = { "nvim-lua/plenary.nvim" },
        }
        use "nvim-telescope/telescope-fzy-native.nvim"
        use "natecraddock/telescope-zf-native.nvim"

        -- Extra syntaxes
        use "stephpy/vim-yaml"
        use "tikhomirov/vim-glsl"
        -- use "rust-lang/rust.vim"
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function() vim.cmd [[TSUpdate]] end
        }
        use "nvim-treesitter/playground"

        -- LSP
        use "neovim/nvim-lspconfig"
        -- use "nvim-lua/completion-nvim"
        use "nvim-lua/lsp_extensions.nvim"
        use "nvim-lua/lsp-status.nvim"
        use "psf/black"
        -- use "mattn/emmet-vim"

        -- Completion
        -- use "hrsh7th/nvim-compe"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-cmdline"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-calc"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-emoji"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-nvim-lsp-document-symbol"

        use "L3MON4D3/LuaSnip"

        use "dstein64/vim-startuptime"

        use "mfussenegger/nvim-dap"
    end
}
