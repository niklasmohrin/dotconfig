" General settings
set number relativenumber
syntax enable
set mouse=nicr
set splitbelow splitright
set list
" Trailing whitespace and tab characters
set listchars=trail:*,tab:>-
set tabstop=4
set shiftwidth=4
" Enable clang format for c and c++
autocmd FileType c,cpp setlocal equalprg=clang-format

" Plugins
call plug#begin()
	" Styling
	Plug 'itchyny/lightline.vim'
	" Navigation and extensions
	Plug 'airblade/vim-rooter'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'machakann/vim-highlightedyank'
	" Language servers
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'rust-lang/rust.vim'
call plug#end()


" Permanent undo
set undodir=~/.config/nvim/.vimdid
set undofile

" Fzf Binding
map <C-p> :Files<CR>

" coc.nvim config
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

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

