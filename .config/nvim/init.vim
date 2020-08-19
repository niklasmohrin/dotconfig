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
    " Navigation and extensions
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'machakann/vim-highlightedyank'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/goyo.vim'
    Plug 'jiangmiao/auto-pairs'
    " Language servers
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rust-lang/rust.vim'
    Plug 'Chiel92/vim-autoformat'
    Plug 'posva/vim-vue'
    Plug 'alvan/vim-closetag'
    Plug 'mattn/emmet-vim'
    Plug 'turbio/bracey.vim'

    Plug 'gruvbox-community/gruvbox'
call plug#end()


" Permanent undo
set undodir=~/.config/nvim/.vimdid
set undofile

autocmd Filetype markdown setlocal colorcolumn=80

" Don't jump over closing bracket when it is on the next line
let g:AutoPairsMultilineClose=0

" Fzf Binding
map <C-p> :Files<CR>

" coc.nvim config
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" let base16colorspace=256
" let g:base16_shell_path="~/.config/base16/templates/shell/scripts"

let g:gruvbox_italic=1
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

let g:closetag_filenames = "*.html,*.xhtml,*.vue"

" Keybindings
let mapleader=" "
map <silent> <leader>f :Autoformat<Cr>

" Slightly changed from default command (Base Style changed from Webkit to Google
let s:configfile_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=file'"
let s:noconfigfile_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=\"{BasedOnStyle: Google, AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(&expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() : 'UseTab: Always').'}\"'"
let g:formatdef_clangformat = "g:ClangFormatConfigFileExists() ? (" . s:configfile_def . ") : (" . s:noconfigfile_def . ")"

" Coc extensions
let g:coc_global_extensions = [
    \ "coc-tsserver",
    \ "coc-rls",
    \ "coc-python",
    \ "coc-json",
    \ "coc-html",
    \ "coc-css",
    \ "coc-clangd",
    \ "coc-emmet",
    \ ]

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

