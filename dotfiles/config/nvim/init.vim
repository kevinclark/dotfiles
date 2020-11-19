"""
""" Plugins
"""

call plug#begin('~/.vim/plugged')

Plug 'lifepillar/vim-solarized8'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'dense-analysis/ale'
Plug 'dhruvasagar/vim-zoom'

call plug#end()

"""
""" General settings
"""

set nocompatible
syntax on
filetype plugin indent on

set termguicolors
colorscheme solarized8
set background=dark

" Set leader
nnoremap <SPACE> <Nop>
let mapleader = ' '

" For git gutter
set signcolumn=yes

set number relativenumber ruler


""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set showmatch                     " Show matching parens
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

" Searching
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter



" Bindings
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :split ~/.zshrc<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader><leader> :GFiles<CR>


" NERDCommenter
let g:NERDCreateDefaultMappings = 0
map <leader>/ <plug>NERDCommenterToggle
let g:strip_whitespace_confirm = 0
let g:strip_whitespace_on_save = 0


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" COC
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Liteline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Rust
let g:rustfmt_autosave = 1
let g:ale_linters = {'rust': ['analyzer']}

" vim-test
let test#strategy = "dispatch"

nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>

