" NVIM INIT

function GetLine()
  ": On one-line use seperate each line with a bar |
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

filetype indent plugin on
syntax on
set termguicolors
set background=dark
set guicursor=""

set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=0
set expandtab
set nowrap

set copyindent
set colorcolumn=80
set cursorline
set cursorlineopt=number
set completeopt=menuone,preview

set nohlsearch
set ignorecase
set number

set path+=**
set relativenumber
set scrolloff=5
set shortmess=aoOstT
set showmatch
set showmode
set signcolumn=yes
set smartcase
set smartindent
set statusline=
set noruler
set updatetime=50
set wildmode=list:longest,full
set foldlevel=99
set foldlevelstart=99

if $TERM == 'linux'
  set mouse=
else
  set breakindent
  set clipboard=unnamedplus
  set laststatus=2
  set lazyredraw
  set mouse=a
endif

let &undodir=expand('~/.local/state/nvim/undo')
let &directory=expand('~/.local/state/nvim/swap')
let &backupdir=expand('~/.local/state/nvim/backup')
set undofile
set nobackup
set noswapfile

let g:python3_host_prog = '/usr/bin/python3'

let mapleader=" "
let maplocalleader="\\"

" source ~/.config/nvim/setup_ale.vim
" source ~/.config/nvim/setup_coc.vim
source ~/.config/nvim/plugins.vim

" call PreAleSetup()

call plug#begin()
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'dense-analysis/ale'
call plug#end()

colorscheme catppuccin-mocha

" call PostAleSetup()
" call CocSetup()
call LesserPlugins()

inoremap kj <ESC>
vnoremap kj <ESC>

nnoremap <silent> <leader>w :write<CR>
nnoremap <leader>q ZQ
nnoremap <leader>z ZZ
nnoremap <leader>o :edit .<CR>
nnoremap <localleader>e :edit ~/.config/nvim/init.vim<CR>
nnoremap <localleader>ve :vsplit<CR><C-w>l:edit ~/.config/nvim/init.vim<CR>
nnoremap <localleader>s :write<CR>:source ~/.config/nvim/init.vim<CR>:do FileType<CR>:do BufEnter<CR>
nnoremap <leader>t :terminal<CR>

tnoremap <ESC> <C-\><C-n>
tnoremap <C-v><ESC> <ESC>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap > >gv
vnoremap < <gv

nnoremap <C-f> <C-d>
nnoremap <leader>p "+p
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <leader>a zt
nnoremap ' `
nnoremap '' ``
nnoremap n nzz
nnoremap N Nzz
nnoremap w W
nnoremap <leader>* :%s/\<C-r><C-w>//gI<left><left><left>
nnoremap <leader>& :%s/\<C-r><C-w>//gcI<left><left><left><left>
nnoremap Y y$
nnoremap B _
nnoremap E $
nnoremap w W
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>( viw<esc>a(<esc>bi(<esc>lel
nnoremap <leader>[ viw<esc>a[<esc>bi[<esc>lel
nnoremap <leader>{ viw<esc>a{<esc>bi{<esc>lel
nnoremap <leader>< viw<esc>a<<esc>bi<<esc>lel
nnoremap <leader>v :vsplit<CR><C-w>l
nnoremap <leader>s :split<CR><C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <leader>ll :vertical resize+5<CR>
nnoremap <leader>jj :resize-5<CR>
nnoremap <leader>rs <C-w>=
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tc :tabclose<CR>

augroup ALL
  au!
  au InsertEnter * set nornu
  au InsertLeave * set rnu
  au BufEnter,BufWritePre * :normal! mpHmogg=G'ozt`p
  au BufEnter * call GetLine()
augroup END

augroup VIM
  au!
  au FileType vim setlocal ts=2 sw=2 tw=0 fdm=marker fdc=2 cc=120
augroup END

augroup PYTHON
  au!
  au FileType python setlocal ts=4 sw=4 tw=0 fdm=indent
  au BufEnter *.py nnoremap <buffer> <F5> :write<cr>:!clear && python3 %<cr>
  au BufEnter *.py nnoremap <buffer> <F6> :!black %<CR>
  au BufEnter *.py nnoremap <buffer> <F7> :!pylint --rcfile=~/python/pylint.conf %<CR>
augroup END

augroup SH
  au!
  au FileType sh setlocal ts=4 sw=4 tw=0 nofen fdc=0
  au BufEnter *.sh nnoremap <buffer> <F5> :write<cr>:!./%<cr>
  au BufEnter *.sh nnoremap <buffer> <F5> :write<cr>:!./%<cr>
augroup END

augroup C-CPP
  au!
  au FileType c,cpp setlocal ts=4 sw=4 tw=0 noai nosi noci cin cino=ln,c2 fdc=4 fdm=indent
  au FileType c,cpp nnoremap <buffer> <leader>nb o{<CR>}<ESC>O
augroup END

augroup RUST
  au!
  au FileType rust setlocal ts=4 sw=4 tw=0 noai nosi noci cin cino=ln,c2 fdc=4 fdm=indent
  au FileType rust nnoremap <buffer> <leader>nb o{<CR>}<ESC>O
  au BufEnter *.rs nnoremap <buffer> <F5> :write<CR>:!cargo run<CR>
augroup END

augroup LUA
  au!
  au FileType lua setlocal ts=2 sw=2 tw=0 fdm=indent fdc=3
  au BufEnter *.lua nnoremap <buffer> <F5> :write<CR>:!lua %<CR>
augroup END

augroup TEXT
  au!
  au FileType text setlocal ts=4 sw=4 tw=79 wrap fdc=1
augroup END

augroup GITCOMMIT
  au!
  au FileType gitcommit setlocal ts=2 sw=2 tw=70 wrap cc=50,70
augroup END

augroup FZF
  au!
  au FileType fzf set laststatus=0 noshowmode noruler
  " au BufLeave * <buffer> set laststatus=2 showmode ruler
  au VimEnter,BufEnter * nnoremap <leader>fz :<C-u>FZF<CR>
augroup END

augroup SNIPPETS
  au!
  au BufEnter *.py nnoremap <buffer> <leader>hs :-1read $HOME/.vim/snippets/py_hash<CR>
  au BufEnter *.py abbrev def def():<left><left><esc>i
  au BufEnter *.py abbrev <buffer> fori for i, item in enumerate():<esc>0f(
  au BufEnter *.py nnoremap <buffer> <leader>cl :-1read $HOME/.vim/snippets/py_class<CR>wi
augroup END
