": Neovim Configuration

": Linux Term {{{
if $TERM == 'linux'
  source ~/.config/nvim/linux_term_init.vim
  echom "YES"
  finish
  " industry, elflord, pablo, wildcharm
endif
" }}}

function Indent() " {{{
  let l:view = winsaveview()
  :normal! gg=G
  call winrestview(l:view)
endfunction
" }}}

function GetLine() " {{{
  ": On one-line use seperate each line with a bar |
  if line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g'\""
  endif
endfunction
" }}}

function PreAleSetup() " {{{
  let g:ale_enabled = 1
  let g:ale_completion_enabled = 1
  let g:ale_completion_autoimport = 1
  let g:ale_detail_to_floating_preview = 1
  let g:ale_echo_msg_format = "% code % [%linter%] %type% "
  let g:ale_lsp_suggestions = 1

  let g:ale_cursor_detail = 0 " 1 GIVES POPUP
  let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

  if has('nvim')
    " let g:ale_use_neovim_diagnostics_api = 1 " DONT USE WITH g:ale_virturaltext_cursor
    let g:ale_virtualtext_cursor = 1
  else
    let g:ale_virtualtext_cursor = 1
  endif

  let g:ale_warn_about_trailing_blank_lines = 1
  let g:ale_warn_about_trailing_whitespace = 1
  let g:ale_sign_column_always = 1

  ": Prevents highlights in the code proper. This is a list of strings
  let g:ale_set_highlights = 1
  let g:ale_exclude_highlights = [
        \ 'docstring',
        \ 'Unused argument',
        \ 'import-error',
        \ 'inconsistent-return-statements'
        \ ]

  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '--'
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_info_str = 'I'

  let g:ale_linters_explicit = 1
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_save = 1
  let g:ale_fix_on_save = 1
endfunction
" }}}

function PostAleSetup() " {{{
  ": 'rust': ['analyzer', 'rustc', 'cargo'],
  ": 'python': ['pylint', 'isort', 'mypy', 'pyright', 'ruff'],
  let g:ale_linters = {
        \ 'python': [''],
        \ 'rust': ['analyzer'],
        \ 'vim': [''],
        \ 'cpp': ['clangd', 'cpplint'],
        \ 'json': ['eslint'],
        \ }
  let g:ale_fixers = {
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ 'python': ['autopep8', 'isort'],
        \ 'rust': ['rustfmt'],
        \ 'cpp': ['clang-format'],
        \ 'json': ['prettier'],
        \}

  let g:ale_python_pylint_options = '--rcfile ~/python/pylint.conf'
endfunction
" }}}

function CocSetup() " {{{
  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  nmap <silent>gd <Plug>(coc-definition)
  nmap <silent>gy <Plug>(coc-type-definition)
  nmap <silent>gi <Plug>(coc-implementation)
  nmap <silent>gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Symbol renaming
  nmap <leader>rn <Plug>(coc-rename)
  " Remap keys for applying refactor code actions
  nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
  xmap <silent> <leader>r <Plug>(coc-codeaction-refactor-selected)
  nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
endfunction
"" }}}

function LesserPlugins() " {{{
  let g:user_emmet_mode='inv'
  let g:user_emmet_leader_key=','

  " The colorscheme for lightline.vim.
  " Currently, wombat, solarized, powerline, powerlineish, jellybeans, molokai, seoul256, darcula,
  " selenized_dark, selenized_black, selenized_light, selenized_white, Tomorrow, Tomorrow_Night, Tomorrow_Night_Blue,
  " Tomorrow_Night_Bright, Tomorrow_Night_Eighties, PaperColor, landscape, one, materia, material, OldHope, nord, deus,
  " simpleblack, srcery_drk, ayu_mirage, ayu_light, ayu_dark, apprentice, rosepine, and 16color are available.
  let g:lightline = {
        \ 'colorscheme': 'seoul256',
        \ }

  nnoremap <leader> :WhichKey<CR>
  " nnoremap <localleader> :WhichKey

  nnoremap <leader>ut :UndotreeToggle<CR>

  nnoremap <leader>ga :write<cr>:Git add .<cr>
  nnoremap <leader>gc :Git commit<cr>
  nnoremap <leader>gs :Git status<cr>
  nnoremap <leader>gb :Git branch<cr>
  nnoremap <leader>gr :Git remote<cr>
  nnoremap <leader>gdd :Git diff<cr>
  nnoremap <leader>gds :Git diff --staged<cr>

  nnoremap <leader>mf <Plug>(easymotion-bd-f)
  nnoremap <leader>mf <Plug>(easymotion-overwin-f)
  nnoremap <leader>ms <Plug>(easymotion-bd-s)
  nnoremap <leader>ms <Plug>(easymotion-overwin-f2)
  nnoremap <leader>ml <plug>(easymotion-bd-jk)
  nnoremap <leader>ml <Plug>(easymotion-overwin-line)
  nnoremap <leader>mw <Plug>(easymotion-bd-w)
  nnoremap <leader>mw <Plug>(easymotion-overwin-w)

  nmap <leader><tab> <plug>(fzf-maps-n)
  imap <C-x><C-f> <plug>(fzf-complete-word)
  imap <C-x><C-d> <plug>(fzf-complete-path)
  imap <C-x><C-a> <plug>(fzf-complete-line)
  nnoremap <leader>fz :FZF<cr>
  nnoremap <leader>fh :FZF ~<CR>
endfunction
" }}}

": SETTINGS {{{
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
set autochdir

set copyindent
set colorcolumn=80
set cursorline
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

if $TERM == 'linux'
  set mouse=
else
  set breakindent
  set clipboard=unnamedplus
  set cursorlineopt=both
  set foldlevel=99
  set foldlevelstart=99
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
" }}}

": VIM PLUG {{{
" call PreAleSetup()
call plug#begin()
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'dense-analysis/ale'
call plug#end()
" call PostAleSetup()
call CocSetup()
call LesserPlugins()
" }}}

": TERMS {{{
if $TERM == 'xterm-256color'
  " colorscheme retrobox
  colorscheme catppuccin-mocha
elseif $TERM == 'tmux-256color'
  " colorscheme sorbet
  colorscheme catppuccin-mocha
endif
" }}}

": MAPPINGS {{{
inoremap kj <esc>
vnoremap kj <esc>
nnoremap <silent> <leader>w :write<CR>
nnoremap <leader>q ZQ
nnoremap <leader>z ZZ
nnoremap <leader>o :edit .<CR>
nnoremap <localleader>e :edit ~/.config/nvim/init.vim<cr>
nnoremap <localleader>ve :vsplit<cr><C-w>l:edit ~/.config/nvim/init.vim<cr>
nnoremap <localleader>s :write<CR>:source ~/.config/nvim/init.vim<cr>:do FileType<cr>:do BufEnter<cr>
nnoremap <leader>t :terminal<cr>

tnoremap <ESC> <C-\><C-n>
tnoremap <C-v><ESC> <ESC>
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
vnoremap > >gv
vnoremap < <gv

nnoremap <C-f> <C-d>
nnoremap <leader>p "+p
nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bp :bprevious<cr>
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
nnoremap <leader>v :vsplit<cr><C-w>l
nnoremap <leader>s :split<cr><C-w>j
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

" }}}

": GROUPS {{{
augroup ALL
  au!
  au InsertEnter * set nornu
  au InsertLeave * set rnu
  au BufReadPost * call GetLine()
augroup END

augroup ABBREVS
  au!
  au BufEnter * iabbrev pritn print
  au BufEnter * iabbrev prnit print
  au BufEnter * iabbrev pirnt print
  au BufEnter * iabbrev esle else
  au BufEnter * iabbrev tow two
  au BufEnter * iabbrev sefl self
  au BufEnter * iabbrev slef self
augroup END

augroup VIM
  au!
  au FileType vim setlocal ts=2 sw=2 tw=0 fdm=marker fdc=2 cc=120
  au BufEnter *.vim nnoremap <F8> @
  au BufEnter *.vim nnoremap <F9> @@
  " au BufEnter *.vim :normal! zozo
  au BufLeave *.vim unmap <F8>
  au BufLeave *.vim unmap <F9>
  au BufWritePre *.vim call Indent()
  au BufEnter *.vim call Indent()
augroup END

augroup PYTHON
  au!
  au FileType python setlocal ts=4 sw=4 tw=0 fdm=indent
  au BufEnter *.py nnoremap <buffer> <F5> :write<cr>:!python3 %<cr>
  " au BufEnter *.py nnoremap <buffer> <F6> :!black %<CR>
  au BufEnter *.py nnoremap <buffer> <F7> :!pylint --rcfile=~/python/pylint.conf %<CR>
  au BufWritePre *.py call Indent()
augroup END

augroup SH
  au!
  au FileType sh setlocal ts=4 sw=4 tw=0 nofen fdc=0
  au BufEnter *.sh nnoremap <buffer> <F5> :write<cr>:!./%<cr>
  au BufWritePre *.sh call Indent()
  au BufEnter *.sh nnoremap <buffer> <F5> :write<cr>:!./%<cr>
augroup END

augroup HTML_CSS
  au!
  au FileType html,css setlocal ts=2 sw=2 tw=0 fdc=4 fdm=manual aw ut=1000 cc=80,100,120
  au FileType html nnoremap <buffer> <localleader>f Vatzf
  au BufReadPost,BufEnter *.html nnoremap <buffer> <localleader>c i<!----><esc>2hi<space><esc>i<space>
  au BufReadPost,BufEnter *.css nnoremap <buffer> <localleader>c i/**/<esc>hi<space><esc>i<space>
  au BufReadPost,BufEnter *.html :onoremap <buffer> it :<c-u>normal! f<vi<<cr>
  au CursorHold *.html,*.css write
augroup END

augroup C_CPP
  au!
  au FileType c,cpp setlocal ts=4 sw=4 tw=0 noai nosi noci cin cino=ln,c2 fdc=4 fdm=indent
  au FileType c,cpp nnoremap <buffer> <leader>nb A<space>{<
  au Filetype c nnoremap <buffer> <leader>mm :!make main<CR>
  au BufWritePre *.c,*.cpp,*.h call Indent()
augroup END

augroup RUST
  au!
  au FileType rust setlocal ts=4 sw=4 tw=0 noai nosi noci cin cino=ln,c2 fdc=4 fdm=indent
  au FileType rust nnoremap <buffer> <leader>nb o{<CR>}<ESC>O
  au BufEnter *.rs nnoremap <buffer> <F5> :write<CR>:!cargo run<CR>
  au BufWritePre *.rs call Indent()
augroup END

augroup LUA
  au!
  au FileType lua setlocal ts=2 sw=2 tw=0 fdm=indent fdc=3
  au BufEnter *.lua nnoremap <buffer> <F5> :write<CR>:!lua %<CR>
  au BufWritePre *.lua call Indent()
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
  au BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
" }}}
