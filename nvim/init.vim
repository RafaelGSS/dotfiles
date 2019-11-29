call plug#begin()
" autocomplete
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'

" File explorer
Plug 'scrooloose/nerdtree'

" interfaces
Plug 'morhetz/gruvbox'

" languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-scripts/svg.vim'
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-pug'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'vim-ruby/vim-ruby'

" lint
Plug 'dense-analysis/ale'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
call plug#end()

colorscheme gruvbox
set background=dark

" leader key
let mapleader="\<space>"

" commons
set foldmethod=manual
set clipboard=unnamedplus
set backupcopy=yes
set inccommand=split
filetype plugin indent on
set colorcolumn=120

" hidden characters
set hidden
set list
set listchars=tab:>-,trail:.
"set lcs+=space:.

" enable mouse
set mouse=a

" lines with relative numbers
set number
set relativenumber

" encoding
set fileencoding=utf-8
set encoding=utf-8

" spaces
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set softtabstop=2

" ctags
set tags=tags

" update neovim
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" navigate between buffers
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>

" git
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>

" escape the terminal
"tnoremap <Esc> <C-\><C-n>

" NERDTree
"nnoremap <s-e> :NERDTreeToggle<cr>
nnoremap <C-e> :NERDTreeToggle<CR>

nnoremap <leader>e :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" search
set incsearch
set hlsearch
nnoremap <leader>s :nohlsearch<cr>
:
" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-H> <C-w><
map <silent> <A-K> <C-W>-
map <silent> <A-J> <C-W>+
map <silent> <A-L> <C-w>>

" typescript
setlocal indentkeys+=0.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" vue
let g:vue_pre_processors = 'detect_on_enter'

" css
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" sass
autocmd FileType scss set iskeyword+=-

" elixir
setlocal formatprg=mix\ format\ -

" ale
let g:ale_linters_explicit = 1
let g:ale_linter_aliases = {'javascript': ['vue', 'javascript']}
let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}

