set number
set ruler
syntax on
set t_Co=256
colorscheme darcula
set tabstop=4 shiftwidth=4 expandtab softtabstop=4 autoindent
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

" copy (write) highlighted text to .vimbuffer
vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
