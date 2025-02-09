call plug#begin()
" autocomplete
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File explorer
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

" interfaces
Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline'
Plug 'chriskempson/base16-vim'

" languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/html5.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'hashivim/vim-terraform'

" utils
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags'

Plug 'nvim-lua/plenary.nvim'
Plug 'instant-bench/instant-bench-nvim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'

" Ib
Plug 'nvim-lua/plenary.nvim'
Plug 'instant-bench/instant-bench-nvim'
call plug#end()

"""""""""""""""""""""""""""""""""""
" Commons Config
"""""""""""""""""""""""""""""""""""
let mapleader="\<space>"
" commons
set foldmethod=manual
set so=7
set clipboard=unnamedplus
set clipboard+=unnamedplus
set backupcopy=yes
set inccommand=split
set colorcolumn=120
set nowrap
set autoread
set cursorline
set ignorecase
" hidden characters
set hidden
set list
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
" search
set incsearch
set hlsearch
" ctags
set tags=tags

filetype plugin indent on
command! -nargs=* Vcfg execute "vsplit $MYVIMRC"

command! -nargs=* W execute "w"

"navigate between buffers
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>
nnoremap <leader>b <cmd>Telescope buffers<cr>

" interface cfg
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme gruvbox8
" colorscheme base16-gruvbox-light-soft
" set termguicolors
set background=dark


" remap go to definition
nnoremap <C-]> g<C-]>

""""""""""""""""""""""""""""""""""""""
" Plugin git
""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gl :Glog! -10 --<CR>
nnoremap <leader>gf :Glog! -10 -- %<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>

""""""""""""""""""""""""""""""""""""""
" Plugin nvim-telescope
""""""""""""""""""""""""""""""""""""""
nnoremap <c-P> <cmd>Telescope find_files<cr>
nnoremap <c-F> <cmd>Telescope live_grep<cr>
nnoremap <leader>t <cmd>Telescope help_tags<cr>
nnoremap <leader>T <cmd>Telescope tags<cr>

""""""""""""""""""""""""""""""""""""""
" Plugin NvimTree
""""""""""""""""""""""""""""""""""""""
nnoremap <C-e> :NvimTreeToggle<CR>

nnoremap <leader>m :NvimTreeFindFile<cr>

lua << EOF
require("nvim-tree").setup {
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
        modified = false,
      },
    },
  },
  disable_netrw = true,
  hijack_netrw = true,
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
}
EOF

lua << EOF
require("instant-bench").setup {
  endpoint = "http://localhost:4001"
}
EOF

""""""""""""""""""""""""""""""""""""""
" Plugin css
""""""""""""""""""""""""""""""""""""""
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

""""""""""""""""""""""""""""""""""""""
" Plugin sass
""""""""""""""""""""""""""""""""""""""
autocmd FileType scss set iskeyword+=-

""""""""""""""""""""""""""""""""""""""
" Plugin elixir
""""""""""""""""""""""""""""""""""""""
setlocal formatprg=mix\ format\ -

""""""""""""""""""""""""""""""""""""""
" Plugin go
""""""""""""""""""""""""""""""""""""""
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

""""""""""""""""""""""""""""""""""""""
" Plugin ale
""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_linters_explicit = 1
let g:ale_linter_aliases = {'javascript': ['vue', 'javascript']}
let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}

""""""""""""""""""""""""""""""""""""""
" Plugin COC
""""""""""""""""""""""""""""""""""""""
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=50

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>cr :CocRestart

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
noremap <F3> :Format<CR>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-eslint', 'coc-highlight', 'coc-html', 'coc-tslint', 'coc-vetur', 'coc-elixir', 'coc-cmake', 'coc-go', 'coc-pyright']

""""""""""""""""""""""""""""""""""
" Instant Bench
""""""""""""""""""""""""""""""""""

lua << EOF
require("instant-bench").setup {
  endpoint = "http://localhost:4000",
  api_key = "XXXXXX",
}
EOF

""""""""""""""""""""""""""""""""""
" Plugin vim-airline
""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""""""
" Plugin AutoPairs
""""""""""""""""""""""""""""""""""

let g:AutoPairsFlyMode = 0

""""""""""""""""""""""""""""""""""
" Typescript
""""""""""""""""""""""""""""""""""
" You can use something like this in your .vimrc to make the QuickFix window automatically appear if :make has any errors.

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
""""""""""""""""""""""""""""""""""
" Remaps
""""""""""""""""""""""""""""""""""

" search
nnoremap <leader>s :nohlsearch<cr>

" search
nnoremap <leader>p "\"_dP"

" reload files after changes (checkout)
nnoremap <F5> :checktime<CR>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <C-H> <C-w><
map <silent> <C-K> <C-W>-
map <silent> <C-J> <C-W>+
map <silent> <C-L> <C-w>>

" move selected region
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" " Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Disable Arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
