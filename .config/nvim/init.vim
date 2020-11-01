" General settings
set number relativenumber
syntax on
set mouse=a
set splitbelow splitright
set wildmenu
set wildmode=longest,list,full
set spelllang=en_us,de_de
set spell
set termguicolors
set nowrap
set cursorline
" Trailing whitespace and tab characters
set list
set listchars=trail:·,tab:>-
set tabstop=4
set shiftwidth=4
set laststatus=2
set expandtab

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
    Plug 'junegunn/goyo.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'turbio/bracey.vim'             " Live web server

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    " Plug 'mattn/emmet-vim'
    " Plug 'rust-lang/rust.vim'

    " GRUVBOX
    Plug 'gruvbox-community/gruvbox'
call plug#end()

" Keybindings
let mapleader=" "

" Permanent undo
set undodir=~/.config/nvim/.vimdid
set undofile

let g:gruvbox_italic=1
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Fzf Binding
map <C-p> :GFiles<CR>

" LSP config
"   Completion
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set shortmess+=c
"   Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"   Language servers
lua require'nvim_lsp'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
lua require'nvim_lsp'.clangd.setup{ on_attach=require'completion'.on_attach }
lua require'nvim_lsp'.pyls_ms.setup{ on_attach=require'completion'.on_attach }
lua require'nvim_lsp'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'nvim_lsp'.html.setup{ on_attach=require'completion'.on_attach }
lua require'nvim_lsp'.texlab.setup{ on_attach=require'completion'.on_attach }

nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>r :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f :lua vim.lsp.buf.formatting()<CR>

autocmd Filetype markdown setlocal colorcolumn=80
" Don't jump over closing bracket when it is on the next line
let g:AutoPairsMultilineClose=0
let g:closetag_filenames = "*.html,*.xhtml,*.vue"
