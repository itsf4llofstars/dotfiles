" NeoVim init.vim
": Change: Mon 25 Sep 2023 11:47:04 AM CDT

function WriteDate()
  let l:view = winsaveview()
  normal! ggj
  :r!date
  normal! kdd
  execute "normal I\": Change:\<Space>\<Esc>"
  call winrestview(l:view)
endfunction

function GetLine()
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

function Indent()
  let l:view = winsaveview()
  :normal! gg=G
  call winrestview(l:view)
endfunction

function DelWhiteSpace()
  let l:view = winsaveview()
  %s/\s\+$//e
  call winrestview(l:view)
endfunction

function CleanUp()
  let l:view = winsaveview()
  %s/\s\+$//e
  let l:indent = 1

  if &filetype == 'conf' || &filetype == 'python'
    let l:indent = 0
  endif

  if l:indent == 1
    :normal! gg=G
  endif

  call winrestview(l:view)
endfunction

filetype plugin on
filetype indent on
set termguicolors
set guicursor=""

set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=0
set expandtab
set nowrap
set number
set relativenumber

set clipboard=unnamedplus
set completeopt=menuone,preview
set foldlevel=99
set foldlevelstart=99
set nohlsearch
set ignorecase
set incsearch
set cursorline
set cursorlineopt=number
set path+=**
set scrolloff=5
set shortmess=aoOstT
set showmatch
set showmode
set signcolumn=yes
set smartcase
set smartindent
set updatetime=300
set wildmode=longest,list,full
set statusline=
set noruler
set wildmode=list:longest,full

let &undodir=expand('~/.local/state/nvim/undo')
let &directory=expand('~/.local/state/nvim/swap')
let &backupdir=expand('~/.local/state/nvim/backup')
set undofile
set nobackup
set nowritebackup
set noswapfile

let g:python3_host_prog = '/usr/bin/python3'

let mapleader=" "
let maplocalleader="\\"

source ~/.config/nvim/coc_setup.vim

call plug#begin()
" Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'stevearc/dressing.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim',
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yggdroot/indentline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme catppuccin-mocha

source ~/.config/nvim/treesitter.lua
source ~/.config/nvim/dev_icons.lua
source ~/.config/nvim/dressing.lua
source ~/.config/nvim/neotree.lua

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:user_emmet_mode='a'
let g:user_emmet_install_global=0
let g:user_emmet_leader_key=','

let g:indentLine_char_list = ['▏', '▏', '▏', '┊']
let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

map <leader>mf <Plug>(easymotion-bd-f)
nmap <leader>mf <Plug>(easymotion-overwin-f)
nmap <leader>ms <Plug>(easymotion-overwin-f2)
map <leader>ml <Plug>(easymotion-bd-jk)
nmap <leader>ml <Plug>(easymotion-overwin-line)
map <leader>mw <Plug>(easymotion-bd-w)
nmap <leader>mw <Plug>(easymotion-overwin-w)

nnoremap <leader>of :FZF<cr>
nnoremap <leader>oz :FZF ~<CR>
nnoremap <leader>ob :Buffers<cr>
nnoremap <leader>oc :Colors<cr>
nnoremap <leader>oll :Lines<cr>
nnoremap <leader>olb :BLines<cr>
nnoremap <leader>ott :Tags<cr>
nnoremap <leader>otb :BTags<cr>
nnoremap <leader>om :Marks<cr>
nnoremap <leader>oj :Jumps<cr>
nnoremap <leader>op :Maps<cr>
nnoremap <leader>ot :UndotreeToggle<cr>

let g:undotree_SplitWidth=40
let g:undotree_ShortIndicators=1
let g:undotree_HighlightChangedText=0
nnoremap <leader>ut :UndotreeToggle<cr>

let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

command! MakeTags !ctags -R .

inoremap kj <ESC>
vnoremap kj <ESC>

nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <localleader>w :wall<CR>
nnoremap <leader>q ZQ
nnoremap <leader>z ZZ
nnoremap <localleader>z :xall<CR>
nnoremap <leader>oo :Neotree<CR>
nnoremap <localleader>e :edit ~/.config/nvim/init.vim<CR>
nnoremap <localleader>ve :vsplit<CR><C-w>l:edit ~/.config/nvim/init.vim<CR>
nnoremap <localleader>s
      \ :write<CR>:source ~/.config/nvim/init.vim<CR>:do FileType<CR>:do BufEnter<CR>
nnoremap <leader>t :terminal<CR>

tnoremap <ESC> <C-\><C-n>
tnoremap <C-v><ESC> <ESC>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap > >gv
vnoremap < <gv

nnoremap zz zt
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
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
nnoremap <localleader>v :split<CR><C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <leader>ll :vertical resize+
nnoremap <leader>kk :resize+
nnoremap <leader>rs <C-w>=
nnoremap <leader>to :tabnew<CR>
nnoremap L :tabnext<CR>
nnoremap H :tabprevious<CR>
nnoremap <leader>tc :tabclose<CR>

augroup ALL
  au!
  au InsertEnter * set nornu
  au InsertLeave * set rnu
  au BufWinEnter * call GetLine()
  au BufWritePre * call CleanUp()
augroup END

augroup FILETYPES
  au!
  au FileType vim,lua setlocal ts=2 sw=2
  au FileType python setlocal fdm=indent
  au FileType sh setlocal nofen scl=no
  au FileType c,cpp,rust setlocal noai nosi noci cin cino=ln,c2 fdc=4 fdm=indent
  au FileType text setlocal tw=79 wrap
  au FileType gitcommit setlocal ts=2 sw=2 tw=70 wrap cc=50,70
  au FileType html,css setlocal ts=2 sw=2 aw awa ut=1000 cc=80,90,100,120
  au FileType markdown silent setlocal cc=80,90,100
augroup END

augroup VIM
  autocmd!
  autocmd BufWritePre init.vim call WriteDate()
augroup END

augroup CODE_RUNNERS
  au!
  au BufEnter *.py nnoremap <buffer> <F5> :write<cr>:!python3 %<CR>
  au BufEnter *.py nnoremap <buffer> <F6> :!black %<CR>
  au BufEnter *.py nnoremap <buffer> <F7> :!pylint --rcfile=~/python/pylint.conf %<CR>
  au BufEnter *.sh nnoremap <buffer> <F5> :write<cr>:!./%<cr>
  au BufEnter *.rs nnoremap <buffer> <F5> :write<CR>:!cargo run<CR>
  au BufEnter *.c nnoremap <buffer> <F5> :write<CR>:!./main<CR>
  au BufEnter *.c nnoremap <buffer> <leader>mm :write<CR>:make main<CR>
augroup END

augroup HTML_CSS
  au!
  au BufEnter *.html nnoremap <buffer> <localleader>f Vatzf
  au BufEnter *.html
        \ nnoremap <buffer> <localleader>c i<!----><esc>2hi<space><esc>i<space>
  au BufEnter
        \ *.css nnoremap
        \ <buffer> <localleader>c i/**/<esc>hi<space><esc>i<space>
  au BufEnter *.html :onoremap <buffer> it :<c-u>normal! f<vi<<cr>
  au FileType text,html,htmldjango,css EmmetInstall
  au CursorHold *.html,*.css write
augroup END

augroup ABBREVS
  au!
  au FileType * abbrev memail irooted4hal@mailfence.com
  au Filetype * abbrev meme itsf4llofstars
  au Filetype * abbrev retrun return
  au FileType text,python,sh abbrev pirnt print
  au FileType text,python,sh abbrev prnit print
  au FileType text,python,sh abbrev pritn print
  au FileType text,python,sh abbrev prnt print
  au FileType text,python abbrev slef self
  au FileType text,python abbrev sefl self
  au FileType c abbrev pirntf printf
  au FileType c abbrev prnitf printf
  au FileType c abbrev pritnf printf
  au FileType c abbrev prnt printf
  au FileType c abbrev prntf printf
  au FileType python abbrev slef self
  au FileType python abbrev sefl self
augroup END

augroup FZF
  au!
  au FileType fzf set laststatus=0 noshowmode noruler
  au VimEnter,BufEnter * nnoremap <leader>fz :<C-u>FZF<CR>
augroup END
