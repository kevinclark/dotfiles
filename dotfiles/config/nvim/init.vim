scriptencoding utf-8

let g:coc_global_extensions = ['coc-go', 'coc-rust-analyzer', 'coc-json', 'coc-python']

let g:ale_linters = {'rust': ['analyzer', 'cargo'], 'vim': ['vint'], 'ruby': ['rubocop'], 'go': ['gofmt']}
let g:rustfmt_autosave = 1

let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_use_check = 1
let g:ale_disable_lsp = 1

set scrolloff=9999

let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:ale_floating_preview = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_cursor_detail = 1
let g:ale_hover_cursor = 1
let g:ale_close_preview_on_insert = 1


let g:lightline#ale#indicator_checking = '⏳'
let g:lightline#ale#indicator_infos = 'ℹ'
let g:lightline#ale#indicator_warnings = '⚠️'
let g:lightline#ale#indicator_errors = '❌'
let g:lightline#ale#indicator_ok = '✔️'


"""
""" Plugins
"""

call plug#begin('~/.vim/plugged')

Plug 'lifepillar/vim-solarized8'
Plug 'Iron-E/nvim-soluarized'

Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'

Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'nanotee/zoxide.vim'

Plug 'vim-test/vim-test'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'dhruvasagar/vim-zoom'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

Plug 'Iron-E/rust.vim', {'branch': 'feature/struct-definition-identifiers'}
Plug 'neoclide/coc.nvim'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'

Plug 'junegunn/vader.vim'

call plug#end()

command! EchoHlGroup echo "Highlight Group: " . synIDattr(
\	synID(line("."), col("."), 1), "name"
\) | echo 'Namespace: ' . synIDattr(
\	synID(line("."), col("."), 0), "name"
\) | echo "Linked to: " . synIDattr(
\	synIDtrans(synID(
\		line("."), col("."), 1
\	)), "name"
\)

"""
""" General settings
"""

syntax on
filetype plugin indent on

set termguicolors

augroup Highlite
	hi link rustNoise Normal
	hi link rustQuestionMark Special
	hi link rustAssert rustMacro
	hi link rustModPathSep Normal

	autocmd ColorScheme soluarized hi! rustMacro guifg=#d33682 guibg=NONE
augroup end

colorscheme soluarized
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
nnoremap <leader>esv :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :split ~/.zshrc<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fi :Files<CR>
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>g :Rg<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


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
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction


" Liteline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'curentfunction',
      \               'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok',
      \               'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'vim-zoom',
      \                ]]
      \ },
      \ 'component': {
      \   'vim-zoom': '%{zoom#statusline()}'
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_infos': 'lightline#ale#infos',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'ok'
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ }
\ }

augroup CocInstall
  autocmd!
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

" Rust


" vim-test / vim-ultest
nmap <leader>tn :UltestNearest<CR>
nmap <leader>tf :Ultest<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :UltestLast<CR>
nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)


let test#strategy = 'dispatch'
let g:dispatch_compilers = {'bundle exec': ''}
let test#rust#cargotest#options = '--all-features'

augroup UltestRunner
    au!
    au BufWritePost * Ultest
augroup END



execute 'highlight ALEWarningSign guifg=' . g:terminal_color_2
execute 'highlight ALEErrorSign guifg=' . g:terminal_color_1

" Help Vim recognize *.sbt and *.sc as Scala files
augroup ScalaFileRecognition
  au BufRead,BufNewFile *.sbt,*.sc set filetype=scala
augroup END


" You will have a bad experience with diagnostic messages with the default 4000.
set updatetime=300




