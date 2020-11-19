let g:ale_linters = {'rust': ['analyzer', 'cargo']}
let g:rustfmt_autosave = 1

let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_use_check = 1
let g:ale_disable_lsp = 1

let g:ale_sign_error = '❌'
let g:ale_sign_style_error = '⁉️'
let g:ale_sign_warning = '⚠️'
let g:ale_sign_style_warning = '💩'

"""
""" Plugins
"""

call plug#begin('~/.vim/plugged')

Plug 'lifepillar/vim-solarized8'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
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


" COC
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <leader>rn <Plug>(coc-rename)

" Fold whole file
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


" Liteline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'curentfunction', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'vim-zoom' ]]
      \ },
      \ 'component': {
      \   'vim-zoom': '%{zoom#statusline()}'
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ }
\ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Rust

highlight clear ALEErrorSign
highlight clear ALEWarningSign

" vim-test
let test#strategy = "dispatch"

nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>



