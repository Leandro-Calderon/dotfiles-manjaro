" ==============================================================================
" Configuración básica de Neovim
" ==============================================================================
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
set shortmess+=A
set relativenumber
set cursorline
set showcmd

" ==============================================================================
" Configuración de plugins (vim-plug)
" ==============================================================================
call plug#begin()

" Temas y apariencia
Plug 'folke/tokyonight.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navegación y exploración de archivos
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Líneas de indentación
Plug 'Yggdroot/indentLine'

" LSP y autocompletado
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Integración con Git
Plug 'lewis6991/gitsigns.nvim'

" Atajos de teclado
Plug 'folke/which-key.nvim'

" Formateo de código
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'psf/black', { 'branch': 'stable' }

" Depuración
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

" ==============================================================================
" Configuración del tema
" ==============================================================================
set termguicolors
let g:tokyonight_style = 'night' " Puedes cambiar a 'storm', 'day', o 'night'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

" Configuración de vim-airline
let g:airline_theme = 'onedark'  " Usa un tema compatible con airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" ==============================================================================
" Configuración de NERDTree
" ==============================================================================
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeStatusline = ''

" ==============================================================================
" Configuración de indentLine
" ==============================================================================
let g:indentLine_char = '│'
let g:indentLine_color_term = 239

" ==============================================================================
" Configuración de LSP y autocompletado
" ==============================================================================
lua << EOF
local nvim_lsp = require('lspconfig')

-- Función para adjuntar el servidor LSP al buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mapeos de teclado
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', { noremap = true, silent = true })
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
end

-- Configuración de servidores LSP
nvim_lsp.ts_ls.setup { on_attach = on_attach }  -- TypeScript/JavaScript
nvim_lsp.pyright.setup { on_attach = on_attach }   -- Python
nvim_lsp.clangd.setup { on_attach = on_attach }    -- C/C++
EOF
" ==============================================================================
" Configuración de Telescope
" ==============================================================================
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ==============================================================================
" Configuración de Git
" ==============================================================================
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
}
EOF

" ==============================================================================
" Configuración de WhichKey
" ==============================================================================
lua << EOF
require("which-key").setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
}
EOF

" ==============================================================================
" Configuración de Prettier y Black
" ==============================================================================
autocmd FileType javascript setlocal formatprg=prettier\ --stdin-filepath\ %
autocmd FileType python setlocal formatprg=black\ --quiet\ -

" ==============================================================================
" Configuración de Snippets
" ==============================================================================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ==============================================================================
" Configuración de Depuración
" ==============================================================================
lua << EOF
require('dap').adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}
EOF
let g:python3_host_prog = '/usr/bin/python3'
