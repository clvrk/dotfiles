set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Set options
set nu						" Line numbers
set tabstop=2
set shiftwidth=2

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'

" Initialize plugin system
call plug#end()

" Set custom keybindings
" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" COC
inoremap <silent><expr> <c-space> coc#refresh()
