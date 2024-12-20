syntax on
set number
set mouse=a
syntax enable
set showcmd
set encoding=utf-8
set showmatch
set clipboard+=unnamedplus
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set autoindent
set smarttab

call plug#begin()
	Plug 'folke/tokyonight.nvim'   " Tema con estética moderna y fácil de leer
    Plug 'vim-airline/vim-airline'       " Mejora la barra de estado
    Plug 'vim-airline/vim-airline-themes'  " Temas para Airline
    Plug 'preservim/nerdtree'           " Explorador de archivos lateral
    Plug 'ryanoasis/vim-devicons'       " Añade iconos a los archivos
    Plug 'Yggdroot/indentLine'          " Muestra líneas de indentación para facilitar la lectura
call plug#end()
