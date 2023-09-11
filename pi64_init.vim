" NVIM INIT

function GetLine()
  ": On one-line use seperate each line with a bar |
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction

fun MarkPre()
  :normal! mpHmo
endfun

fun MarkPost()
  :normal! 'ozt`p
endfun

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

let &undodir=expand('~/.local/state/nvim/undo')
let &directory=expand('~/.local/state/nvim/swap')
let &backupdir=expand('~/.local/state/nvim/backup')
set undofile
set nobackup
set noswapfile

let g:python3_host_prog = '/usr/bin/python3'

let mapleader=" "
let maplocalleader="\\"

call plug#begin()
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
call plug#end()

colorscheme retrobox

let g:indentLine_char = '▏'
" let g:indentLine_char_list = ['▏', '▏', '┊']
let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
" let g:indentLine_setConceal = 0

": <Leader>f{char} to move to {char}
map <leader>mf <Plug>(easymotion-bd-f)
nmap <leader>mf <Plug>(easymotion-overwin-f)
nmap <leader>ms <Plug>(easymotion-overwin-f2)
map <leader>ml <Plug>(easymotion-bd-jk)
nmap <leader>ml <Plug>(easymotion-overwin-line)
map <leader>mw <Plug>(easymotion-bd-w)
nmap <leader>mw <Plug>(easymotion-overwin-w)

nnoremap <leader>fz :FZF<cr>
nnoremap <leader>fh :FZF ~<CR>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fc :Colors<cr>
nnoremap <leader>fll :Lines<cr>
nnoremap <leader>flb :BLines<cr>
nnoremap <leader>ftt :Tags<cr>
nnoremap <leader>ftb :BTags<cr>
nnoremap <leader>fm :Marks<cr>
nnoremap <leader>fj :Jumps<cr>
nnoremap <leader>fp :Maps<cr>
nnoremap <leader>ut :UndotreeToggle<cr>

" let g:netrw_browse_split=4
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
nnoremap <leader>q :quit!<CR>
nnoremap <leader>z :write<CR>:quit<CR>
nnoremap <localleader>z :xall<CR>
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
nnoremap L :tabnext<CR>
nnoremap H :tabprevious<CR>
nnoremap <leader>tc :tabclose<CR>

augroup ALL
  au!
  au InsertEnter * set nornu
  au InsertLeave * set rnu
  au BufEnter * call GetLine()
  au BufWritePre * call DelWhiteSpace()
  au BufWritePre * call Indent()
augroup END

augroup FILETYPES
  au!
  au FileType vim,lua setlocal ts=2 sw=2
  au FileType python setlocal fdm=indent
  au FileType sh setlocal nofen
  au FileType c,cpp,rust setlocal noai nosi noci cin cino=ln,c2 fdc=4 fdm=indent
  au FileType text setlocal tw=79 wrap
  au FileType gitcommit setlocal ts=2 sw=2 tw=70 wrap cc=50,70
  au FileType html,css setlocal ts=2 sw=2 aw awa ut=1000
  au FileType markdown silent setlocal cc=90,100
augroup END

augroup CODE_RUNNERS
  au!
  au BufEnter *.py nnoremap <buffer> <F5> :write<cr>:!python3 %<CR>
  au BufEnter *.py nnoremap <buffer> <F6> :!black %<CR>
  au BufEnter *.py nnoremap <buffer> <F7> :!pylint --rcfile=~/python/pylint.conf %<CR>
  au BufEnter *.sh nnoremap <buffer> <F5> :write<cr>:!./%<cr>
  au BufEnter *.rs nnoremap <buffer> <F5> :write<CR>:!cargo run<CR>
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
