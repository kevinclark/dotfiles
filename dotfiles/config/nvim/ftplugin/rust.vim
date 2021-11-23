nmap <leader>od :execute ":CocCommand rust-analyzer.openDocs"<CR>

hi link rustIdentifier Normal
hi link rustNoise Normal
hi link rustQuestionMark Special
hi rustMacro guifg=#d33682 guibg=NONE gui=NONE cterm=NONE
hi link rustAssert rustMacro
