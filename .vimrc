set number
set ruler
syntax on
set t_Co=256
colorscheme darcula
set tabstop=4 shiftwidth=4 expandtab softtabstop=4 autoindent smartindent
set hlsearch
set showmatch
set ignorecase
set backspace=indent,eol,start
set nowrap
set shortmess=O
set scrolloff=10
set wildmenu
set incsearch
set sidescroll=1
set nowrap
set ignorecase
set laststatus=2
set cursorline
set colorcolumn=80
set timeoutlen=1000 ttimeoutlen=0
set mouse=a

"map <F10> :silent !pandoc % --pdf-engine=pdfroff -o %:r.pdf<CR>:redraw!<CR>
"map <F11> :silent !zathura %:r.pdf &<CR>
