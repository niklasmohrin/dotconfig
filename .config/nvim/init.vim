" Plugins
set nocompatible
filetype off
set rtp+=~/.config/base16/templates/vim/
call plug#begin()
    " Styling
    Plug 'itchyny/lightline.vim'
    Plug 'machakann/vim-highlightedyank'
    Plug 'airblade/vim-gitgutter'        " Git diff on the left

    " Navigation and extensions
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'alvan/vim-closetag'
    Plug 'turbio/bracey.vim'             " Live web server
    Plug 'tpope/vim-commentary'

    " Extra syntaxes
    Plug 'cespare/vim-toml'
    Plug 'stephpy/vim-yaml'
    Plug 'tikhomirov/vim-glsl'
    Plug 'dag/vim-fish'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-lua/lsp_extensions.nvim'
    " Plug 'mattn/emmet-vim'
    Plug 'rust-lang/rust.vim'

    " Colorschemes
    Plug 'gruvbox-community/gruvbox'
    " Plug 'ayu-theme/ayu-vim'
call plug#end()

" General settings
set number relativenumber
set mouse=a termguicolors
set splitbelow splitright nowrap cursorline laststatus=2
set wildmenu wildmode=longest,list,full
set spell spelllang=en_us,de_de
set list listchars=trail:·,tab:>-
set tabstop=4 shiftwidth=4 expandtab
set undofile undodir=~/.config/nvim/.vimdid " Permanent undo
set shortmess+=c signcolumn=yes

syntax enable

" Keybindings
let mapleader=" "
map <C-p> :Files<CR>
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f :lua vim.lsp.buf.formatting()<CR>
"   Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:gruvbox_italic=1
colorscheme gruvbox
" let ayucolor="dark"
" colorscheme ayu
hi Normal guibg=NONE ctermbg=NONE

" LSP config
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

:lua << EOF
    local lspconfig = require('lspconfig')
    local completion = require('completion')
    local servers = { 'rust_analyzer', 'clangd', 'pyls', 'tsserver', 'html', 'cssls', 'texlab', 'r_language_server', 'vimls' }

    for _, server in ipairs(servers) do
        lspconfig[server].setup({ on_attach = completion.on_attach })
    end
EOF
autocmd Filetype rust autocmd BufWritePost <buffer> :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }
nnoremap <leader>T :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', aligned = true }<CR>

let g:closetag_filenames = "*.html,*.xhtml,*.vue"
autocmd Filetype markdown setlocal colorcolumn=80
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl
