" Set options
set nu

call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Syntax highlighting
Plug 'elkowar/yuck.vim'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
