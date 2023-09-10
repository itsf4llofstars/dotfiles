": NeoVim init.vim
": Change: Wed Sep  6 02:50:28 PM CDT 2023

": :echo resolve(expand('%:p'))

function WriteDate()
  normal! ggj
  :r!date
  normal! kdd
  execute "normal I\": Change:\<Space>\<Esc>"
endfunction

function Indent()
  if &filetype == 'help' || &filetype == 'python'
  else
    normal! gg=G
  endif
endfunction

filetype plugin on
filetype indent on
set termguicolors
set guicursor=""

set tabstop=4
set shiftwidth =4
set textwidth=0
set expandtab
set nowrap
set number
set relativenumber

set clipboard="unnamedplus"
set completeopt=menuone,preview
set foldlevel=99
set foldlevelstart=99
set nohlsearch
set ignorecase
set incsearch
set path+=**
set statusline=(%n)\ %<%F%h%m%r%=%c%V\ [%l:%L]\ \ [%b\ 0x%B]\ \ %p%%\ %P\ \ %f\ \ |
set scrolloff=5
set showmatch
set signcolumn=yes
set smartcase
set smartindent
set updatetime=250
set wildmode=longest,list,full

set directory=~/.vim/backup
set backupdir=~/.vim/backup
set undodir=~/.vim/undodir
set noswapfile
set nobackup
set noundofile

let mapleader = " "
let maplocalleader = "\\"

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'mattn/emmet-vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'yggdroot/indentline'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

colorscheme catppuccin-mocha

let g:coc_global_extensions = [
      \ 'coc-json', 'coc-tsserver', 'coc-snippets', 'coc-eslint', 'coc-sh',
      \ 'coc-rust-analyzer', 'coc-markdownlint', 'coc-jedi', 'coc-cmake',
      \ 'coc-clangd'
      \ ]

" use <tab> to trigger completion and navigate to the next complete item
" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" inoremap <silent><expr> <Tab>
"             \ coc#pum#visible() ? coc#pum#next(1) :
"             \ CheckBackspace() ? "\<Tab>" :
"             \ coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

let g:user_emmet_mode='a'
let g:user_emmet_install_global=0
let g:user_emmet_leader_key=','

nnoremap <leader>of :FZF<cr>
nnoremap <leader>oh :FZF ~<CR>
nnoremap <leader>ob :Buffers<cr>
nnoremap <leader>oc :Colors<cr>
nnoremap <leader>oll :Lines<cr>
nnoremap <leader>olb :BLines<cr>
nnoremap <leader>ott :Tags<cr>
nnoremap <leader>otb :BTags<cr>
nnoremap <leader>om :Marks<cr>
nnoremap <leader>oj :Jumps<cr>
nnoremap <leader>op :Maps<cr>

nmap <leader>mf <Plug>(easymotion-bd-f)
nmap <leader>mf <Plug>(easymotion-overwin-f)
nmap <leader>ms <Plug>(easymotion-bd-s)
nmap <leader>ms <Plug>(easymotion-overwin-f2)
nmap <leader>ml <plug>(easymotion-bd-jk)
nmap <leader>ml <Plug>(easymotion-overwin-line)
nmap <leader>mw <Plug>(easymotion-bd-w)
nmap <leader>mw <Plug>(easymotion-overwin-w)

let g:undotree_SplitWidth=40
let g:undotree_ShortIndicators=1
let g:undotree_HighlightChangedText=0
nnoremap <leader>ut :UndotreeToggle<cr>

let g:indentLine_char = '▏'
" let g:indentLine_char_list = ['▏', '▏', '┊']
let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
" let g:indentLine_setConceal = 0

let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\s\+'

inoremap kj <ESC>
vnoremap kj <ESC>

nnoremap <leader>w :write<CR>
nnoremap <localleader>w :wall<CR>
nnoremap <leader>z :write<CR>:quit<CR>
nnoremap <localleader>z :xall<CR>
nnoremap <leader>q :quit!<CR>
nnoremap <leader>o :edit .<CR>
nnoremap <leader>t :write<CR>:term<CR>
" NOTE: TMAPS NEEDED

nnoremap <localleader>e :write<CR>:edit ~/.config/nvim/init.vim<CR>
nnoremap <localleader>ve :write<CR>:vsplit<CR><C-w>l:edit ~/.config/nvim/init.vim<CR>
nnoremap <localleader>s :write<CR>:source ~/.config/nvim/init.vim<CR>:do FileType<CR>:do BufEnter<CR>

nnoremap <leader>p "+p
nnoremap <C-f> <C-d>
nnoremap zz zt
nnoremap E $
nnoremap Y y$
nnoremap B _
nnoremap w W
nnoremap n nzz
nnoremap N Nzz
nnoremap ' `
nnoremap '' ``
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
vnoremap < <gv
vnoremap > >gv
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>

nnoremap tk g<Tab>
nnoremap th gT
nnoremap tl gt
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

nnoremap <leader>v :vsplit<cr><C-w>l
nnoremap <localleader>v :split<cr><C-w>j

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>kk :vertical resize+
nnoremap <leader>ll :resize+

nnoremap <leader>a '<S-a>
nnoremap <leader>s '<S-s>
nnoremap <leader>d '<S-d>
nnoremap <leader>f '<S-f>

augroup ALL
  autocmd!
  autocmd BufWritePre * :normal! mpHmo
  autocmd InsertEnter * set nornu
  autocmd InsertLeave * set rnu
  autocmd BufEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal g'\"" | endif
  autocmd BufWritePre * :%s/\s\+$//e
  " autocmd BufWritePre * :normal! gg=G
  autocmd BufWritePre * call Indent()
  autocmd BufWritePost * :normal! 'ozt`p
augroup END

augroup FILETYPES
  autocmd!
  autocmd FileType vim setlocal ts=2 sw=2 tw=0
  autocmd FileType python setlocal tw=0 fdm=indent
  autocmd FileType c,rust setlocal tw=0 fdm=indent noai nosi noci cin cino=ln,c2
  autocmd Filetype text setlocal
        \ ts=8 sw=8 sts=4 tw=80 noet wrap noai nosi noci cc=80
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

augroup VIM
  autocmd!
  " autocmd BufWritePre init.vim call WriteDate()
augroup END

augroup PYTHON
  autocmd FileType python let @c=':vsplitl:edit $HOME/notes/py_snips.txt:vertical resize-34h'
  autocmd BufWinEnter *.py nnoremap <F5> :write<CR>:!python3 %<CR>
  autocmd BufWinEnter *.py nnoremap <F6> :write<CR>:!black %<CR>
  autocmd BufWinEnter *.py nnoremap <F7> :write<CR>:!pylint --rcfile=~/python/pylint.conf %<CR>
augroup END

augroup HTML_CSS
  autocmd!
  autocmd FileType html,css setlocal ts=2 sw=2 tw=0 fdc=4 fdm=manual aw ut=1000 cc=80,100,120
  autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
  autocmd FileType text,html,htmldjango,css EmmetInstall
  autocmd BufReadPost,BufEnter *.html nnoremap <buffer> <localleader>c i<!----><esc>2hi<space><esc>i<space>
  autocmd BufReadPost,BufEnter *.css nnoremap <buffer> <localleader>c i/**/<esc>hi<space><esc>i<space>
  autocmd BufReadPost,BufEnter *.html onoremap <buffer> it :<c-u>normal! f<vi<<cr>
  autocmd CursorHold *.html,*.css write
augroup END

augroup RUNCODE
  autocmd!
  autocmd BufWinEnter *.py nnoremap <F5> :write<CR>:!python3 %<CR>
  autocmd BufWinEnter *.c nnoremap <buffer> <leader>mm :!make main<CR>
  autocmd BufWinEnter *.c nnoremap <F5> :write<cr>:!./main
augroup END

augroup ABBREV
  autocmd!
  autocmd BufEnter * iabbrev ifos itsf4llofstars
  autocmd BufEnter * iabbrev memail irooted4hal@mailfence.com
  autocmd BufEnter * iabbrev slef self
  autocmd BufEnter * iabbrev sefl self
  autocmd BufEnter * iabbrev sfel self
  autocmd BufEnter * iabbrev pirnt print
  autocmd BufEnter * iabbrev prnit print
  autocmd BufEnter * iabbrev pritn print
  autocmd BufEnter * iabbrev prtn print
  autocmd BufEnter * iabbrev prnt print
  autocmd BufEnter * iabbrev retrun return
augroup END
