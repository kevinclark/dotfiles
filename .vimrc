syntax on

" Incremental search
set incsearch

set tabstop=4
set smarttab
set shiftwidth=4
set autoindent
set expandtab
set backspace=start,indent
set number

colorscheme twilight

" Font
set gfn=Lucida_Sans_Typewriter:h10:cANSI

" Tags
set tags=tags,$inetroot\private\tags

" Turning on and off tags list
nmap <C-t>l :TlistToggle<CR>

" Ignoring log files
let g:fuzzy_ignore = "*.log;*.bak;*.obj;*.csv;*.pyc"
" Use this to tweak how many matches you can get
let g:fuzzy_matching_limit = 70
let g:fuzzy_ceiling = 20000

map <leader>t :FuzzyFinderTextMate<CR>
map <leader>f :FuzzyFinderFile<CR>
map <leader>b :FuzzyFinderBuffer<CR>

map <leader>d :NERDTreeToggle<CR>


" Snippets
nmap <C-i>t i// TODO(kecla): 

" Settings for VimClojure
set nocompatible
filetype plugin indent on
let g:clj_highlight_builtins=1
let g:clj_paren_rainbow=1

" Settings for Python
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" Tags
let g:ctags_statusline=1
let generate_tags=1
let Tlist_Use_Horiz_Window=0
let Tlist_Use_Right_Window=1
let TList_Use_Compact_Format=1
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_File_Fold_Auto_Close=1

