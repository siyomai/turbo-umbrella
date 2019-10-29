call plug#begin()

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-haml'
Plug 'vim-ruby/vim-ruby'
Plug 'flazz/vim-colorschemes'
Plug 'sjl/badwolf'
Plug 'demorose/up.vim'
Plug 'Lokaltog/vim-powerline'
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim'
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script'
Plug 'alfredodeza/jacinto.vim'
Plug 'xero/sourcerer.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-bundler'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/neocomplcache.vim'
Plug 'slashmili/alchemist.vim'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-lang/vim-elixir'
Plug 'YorickPeterse/happy_hacking.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

set background=dark

syntax on
colorscheme happy_hacking

filetype plugin indent on

let mapleader=","

set ttymouse=xterm
set cursorline
set expandtab
set modelines=0
set mouse=ia
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
set encoding=utf-8
set tabstop=2
set nowrap
set number
set expandtab
set nowritebackup
set noswapfile
set nobackup
set hlsearch
set ignorecase
set smartcase

" Autoformatting
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.scss :%s/\s\+$//e
autocmd BufWritePre *.slim :%s/\s\+$//e
au BufNewFile * set noeol

" No show command
autocmd VimEnter * set nosc

" Quick ESC
imap jj <ESC>

" NERDCommenter
nmap <leader># :call NERDComment(0, invert)<cr>
vmap <leader># :call NERDComment(0, invert)<cr>

" JS
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Jump to the next row on long lines
map <Down> gj
map <Up> gk
nnoremap j gj
nnoremap k gk

" format the entire file
nmap <leader>fef ggVG=

" Open new buffers
nmap <leader>s<left> :leftabove vnew<cr>
nmap <leader>s<right> :rightbelow vnew<cr>
nmap <leader>s<up> :leftabove new<cr>
nmap <leader>s<down> :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w><c-w>

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
map <c-n> :NERDTreeToggle<CR>
map <c-h> <c-w><left>
map <c-k> <c-w><up>
map <c-j> <c-w><down>
map <c-l> <c-w><right>

" FZF
nmap <c-p> :FZF<CR>
nmap <c-s> :Rg<CR>

let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']

" CLIPBOARD
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
  vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
elseif os == 'Linux'
  vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']

let g:syntastic_error_symbol="❌"
let g:syntastic_warning_symbol = '❗️'
let g:syntastic_enable_balloons=1
let g:syntastic_loc_list_height = 5

let g:powerline_pycmd = 'py3'

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/bower_components/*,*/tmp/*,*/deps/*
