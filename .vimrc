set autoindent
set incsearch
set number
set smarttab
set wildmenu wildmode=list:full
set cursorline
set laststatus=2
set statusline=%F%r%h(Line:%l,Row:%c)%{fugitive#statusline()}


syntax on
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'wakatime/vim-wakatime'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'

call neobundle#end()
NeoBundleCheck


au BufRead,BufNewFile *.md set filetype=markdown
au FileType javascript call JavaScriptFold()
