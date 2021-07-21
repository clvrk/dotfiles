"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set showtabline=2
set nu						" Line numbers
set tabstop=2
set shiftwidth=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'sainnhe/edge'

" Syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Initialize plugin system
call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Set custom keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compiling & Debugging
noremap <F5> :make<CR>
" COC
inoremap <silent><expr> <c-space> coc#refresh()
" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERDTree configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Theming/ color schemes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('termguicolors')
	set termguicolors
endif

" The configuration options should be placed before `colorscheme edge`.
let g:edge_style = 'default'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
let g:edge_transparent_background = 1

colorscheme edge
