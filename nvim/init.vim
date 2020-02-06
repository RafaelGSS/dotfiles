call plug#begin()

" autocomplete
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }

" File explorer
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-smooth-scroll'

" interfaces
Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline'
Plug 'chriskempson/base16-vim'

" languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-pug'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'hashivim/vim-terraform'

" lint
Plug 'dense-analysis/ale'

" utils
Plug 'tpope/vim-commentary'
Plug 'vimwiki/vimwiki'
Plug 'ludovicchabant/vim-gutentags'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""
" Commons Config
"""""""""""""""""""""""""""""""""""
let mapleader="\<space>"
" commons
set foldmethod=manual
set so=7
set clipboard=unnamedplus
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
nnoremap <leader>b :Buffers<CR>

" interface cfg
let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme base16-default-dark
colorscheme gruvbox8
" set termguicolors
set background=dark


" remap go to definition
nnoremap <C-]> g<C-]>

""""""""""""""""""""""""""""""""""""""
" Plugin git
""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Glog! -10 --<CR>
nnoremap <leader>gf :Glog! -10 -- %<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>

""""""""""""""""""""""""""""""""""""""
" Plugin fuzzy finder - fzf
""""""""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <c-P> :Files<cr>
nnoremap <c-F> :Ag<cr>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>

""""""""""""""""""""""""""""""""""""""
" Plugin NERDTree
""""""""""""""""""""""""""""""""""""""
nnoremap <C-e> :NERDTreeToggle<CR>

nnoremap <leader>m :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeWinSize=30

let g:NERDTreeMapOpenVSplit = "v"
setlocal indentkeys+=0.
""""""""""""""""""""""""""""""""""""""
" Plugin vue
""""""""""""""""""""""""""""""""""""""
let g:vue_pre_processors = 'detect_on_enter'

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
set updatetime=300

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

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

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

" Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
noremap <F3> :Format<CR>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-eslint', 'coc-highlight', 'coc-html', 'coc-tslint', 'coc-vetur', 'coc-elixir']

""""""""""""""""""""""""""""""""""
" Plugin vim-airline
""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""""""
" Plugin AutoPairs
""""""""""""""""""""""""""""""""""

let g:AutoPairsFlyMode = 0

""""""""""""""""""""""""""""""""""
" VimWiki
""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

""""""""""""""""""""""""""""""""""
" Plugin Smooth Scroll
""""""""""""""""""""""""""""""""""
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>


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

" reload files after changes (checkout)
nnoremap <F5> :checktime<CR>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-H> <C-w><
map <silent> <A-K> <C-W>-
map <silent> <A-J> <C-W>+
map <silent> <A-L> <C-w>>

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
