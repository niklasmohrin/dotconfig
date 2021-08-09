return require("packer").startup {
    function(use)
        use "wbthomason/packer.nvim"

        -- Styling
        -- use "itchyny/lightline.vim"
        -- use "machakann/vim-highlightedyank"
        use "airblade/vim-gitgutter"        -- Git diff on the left
        use {
            "tjdevries/express_line.nvim",
            requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
        }

        -- Navigation and extensions
        use "airblade/vim-rooter"
        use "alvan/vim-closetag"
        use "turbio/bracey.vim"             -- Live web server
        use "tpope/vim-commentary"
        use "junegunn/vim-easy-align"

        -- Colorschemes
        use "tjdevries/colorbuddy.nvim"
        use "tjdevries/gruvbuddy.nvim"
        use "gruvbox-community/gruvbox"
        use "ayu-theme/ayu-vim"
        use "vigoux/oak"
        use "glepnir/zephyr-nvim"

        -- Debugging
        use { "puremourning/vimspector", disable = true }

        use {
            "nvim-telescope/telescope.nvim",
            requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
        }
        use "nvim-telescope/telescope-fzy-native.nvim"

        -- Extra syntaxes
        use "cespare/vim-toml"
        use "stephpy/vim-yaml"
        use "tikhomirov/vim-glsl"
        use "dag/vim-fish"
        use "rust-lang/rust.vim"
        -- use "elixir-editors/vim-elixir"
        use {
            "nvim-treesitter/nvim-treesitter",
            run = function() vim.cmd [[TSUpdate]] end
        }
        use "nvim-treesitter/playground"

        -- LSP
        use "neovim/nvim-lspconfig"
        -- use "nvim-lua/completion-nvim"
        use "hrsh7th/nvim-compe"
        use "nvim-lua/lsp_extensions.nvim"
        use "nvim-lua/lsp-status.nvim"
        use "psf/black"
        -- use "mattn/emmet-vim"

        -- use "dstein64/vim-startuptime"
    end
}
