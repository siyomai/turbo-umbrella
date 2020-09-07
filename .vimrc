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
Plug 'Townk/vim-autoclose'
Plug 'Lokaltog/vim-powerline'
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim'
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script'
Plug 'alfredodeza/jacinto.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-bundler'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'slashmili/alchemist.vim'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-lang/vim-elixir'
" Colors
Plug 'xero/sourcerer.vim'
Plug 'YorickPeterse/happy_hacking.vim'
Plug 'zefei/simple-dark'
Plug 'sainnhe/sonokai'
Plug 'gryf/wombat256grf'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-mix-format'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'ajh17/VimCompletesMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wakatime/vim-wakatime'
Plug 'sheerun/vim-polyglot'
Plug 'habamax/vim-elixir-mix-test'

call plug#end()

set background=dark

syntax on
colorscheme happy_hacking

filetype plugin indent on

let mapleader=","

set hlsearch
set novisualbell
set ttymouse=xterm
set cursorline
set expandtab
set modelines=0
set mouse=ia
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
set encoding=UTF-8
set tabstop=2
set nowrap
set nonumber
set expandtab
set nowritebackup
set noswapfile
set nobackup
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

" Fugutive
nmap <leader>gs :Git<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gcb :Git checkout -b
nmap <leader>gco :Git checkout
nmap <leader>gpd :Git pull origin develop --rebase<CR>

" NERDTree
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']
nmap <leader>n :NERDTreeToggle<CR>
map <c-n> :NERDTreeToggle<CR>
map <c-h> <c-w><left>
map <c-k> <c-w><up>
map <c-j> <c-w><down>
map <c-l> <c-w><right>

" Mix Test
let g:elixir_mix_test_position = "bottom"
nmap <leader>ta <Plug>(MixTestRun)

" Mix Format
let g:mix_format_on_save=1

" FZF
"nmap <c-p> :FZF!<CR>
nmap <c-p> :GFiles<CR>
nmap <c-\> :Rg<CR>

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

let g:doeplete#enable_at_startup=1

let b:vcm_tab_complete='vim'

" Startify
let g:startify_bookmarks=[{'a': '~/.vimrc'}, {'b': '~/.zshrc'}]
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]
let g:startify_session_persistence=1

nnoremap <leader>ls :SSave<CR>
nnoremap <leader>ll :SClose<CR>

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#autoformat_require_pragma=0
let g:prettier#config#semi='false'

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/bower_components/*,*/tmp/*,*/deps/*
