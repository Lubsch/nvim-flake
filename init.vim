" Remap leader key
nmap <Space> <leader>

colorscheme gruvbox

" So that neovim follows the transparency rules of alacritty
hi Normal ctermbg=NONE guibg=NONE

" Disable escape timeout
set notimeout

" Telescope binds
nnoremap <silent> <leader>f :Telescope find_files<cr>
nnoremap <silent> <leader>b :Telescope buffers<cr>
nnoremap <silent> <leader>g :Telescope live_grep<cr>

" Lightline (bottom bar)
let g:lightline = {}
let g:lightline.component_expand = {'asyncrun_status': 'lightline#asyncrun#status'}
let g:lightline#asyncrun#indicator_none = ""
let g:lightline#asyncrun#indicator_run = "Processing..."
let g:lightline.active = {'right': [ ['lineinfo'], ['percent'], ['filetype'], ['asyncrun_status'] ]}
let g:lightline.colorscheme = 'gruvbox'

" Conceal latex
set conceallevel=2
let g:tex_conceal="abdmg"

"RUNNING FILES AND OPENING RESULTS
command CompileFile :AsyncRun compileFile %
command OpenResult :silent !openResult % <cr>
nmap <silent> <leader>k :CompileFile<cr>
nmap <silent> <leader>l :OpenResult<cr>

" Use CTRL-V clipboard
set clipboard=unnamedplus

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Switch syntax highlighting on
syntax on

" Make backspace behave in a sane manner.	
set backspace=indent,eol,start

"Ignore case when searching
set ignorecase

"When searching be smart about cases
set hlsearch

"Make search like in modern browsers
set incsearch
noh

"Clear search higlighting with esc
nnoremap <silent> <esc> :noh<CR><esc>

"For regular expressions
set magic

"Persistent undo
set undofile

"Relative line numbering
set number relativenumber

"Make vim not pretend to be vi
set nocompatible

"utf8 encoding
set encoding=utf-8

"INDENT
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent
autocmd FileType nix setlocal tabstop=2 softtabstop=2 shiftwidth=2 cindent cinkeys-=0#

"Wrap lines
set wrap linebreak nolist

"4000ms by default, would lead to delays
set updatetime=50

"SHORTCUTS
"Toggle spell checking
nnoremap <leader>od :set spell spelllang=de<cr>
nnoremap <leader>oe :set spell spelllang=en<cr>
nnoremap <leader>oo :setlocal spell!<cr>
"Fast saving
nnoremap <leader>w :w<cr>
" Go to wiki index
nnoremap <leader>i :e $HOME/documents/wiki/index.md<cr>
":W doas saves file
command! W silent execute 'w !doas tee % > /dev/null' <bar> edit!

"Disable automatic commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Leave terminal insert mode with escape
tnoremap <Esc> <C-\><C-n>

"Make split windows open at the bottom
set splitbelow splitright
