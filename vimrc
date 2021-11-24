if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set encoding=utf-8
set guifont=Source\ Code\ Pro\ 11

set incsearch

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
     if empty(&shellxquote) let l:shxq_sav = '' set shellxquote& endif let cmd = '"' . $VIMRUNTIME . '\diff"' else let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"' endif else let cmd = $VIMRUNTIME . '\diff' endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

inoremap jk <esc>
" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <F4> :NERDTreeToggle<CR>

" Moving around with space
nnoremap <space>j :m .+1<CR>==
nnoremap <space>k :m .-2<CR>==
vnoremap <space>j :m '>+1<CR>gv=gv
vnoremap <space>k :m '<-2<CR>gv=gv

" Fuzzy file finding shortcut
nnoremap <c-p> :FZF<cr>

" Plugin section
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme', { 'do': './install.py' }
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'lambdalisue/suda.vim'
Plug 'dense-analysis/ale'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'liuchengxu/vim-which-key'
call plug#end()
" PlugInstall, PlugUpgrade, PlugUpdate to keep on track
"
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
colorscheme solarized8
set number relativenumber

" Go to definition You Complete Me
nnoremap <C-G> :YcmCompleter GoToDeclaration<CR>
nnoremap <C-B> :YcmCompleter GoToDefinition<CR>

" Close preview window automatically
let g:ycm_autoclose_preview_window_after_insertion = 1

set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.

set ignorecase
set smartcase

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Always use the global python, to not install pynvim in every python virtual environment
" let g:python_host_prog = '/usr/local/bin/python'

" Linting and Fixing
let g:ale_fixers = {
      \    'python': ['black'],
      \   'html': ['tidy'],
      \   'javascript': ['eslint'],
      \   'css': ['fecs'],
      \}
nmap <F10> :ALEFix<CR>

let g:mapleader = " "
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
nnoremap H gT
nnoremap L gt
