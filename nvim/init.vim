call plug#begin()
" autocomplete
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }
Plug 'terryma/vim-multiple-cursors'

" File explorer
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" interfaces
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'

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

" utils
Plug 'heavenshell/vim-jsdoc'

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
command! -nargs=* Vcfg execute "vsplit $MYVIMRC"

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

" ctags
set tags=tags

" update neovim
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

" fuzzy finder
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <c-P> :Files<cr>
nnoremap <c-F> :Ag<cr>

" NERDTree
nnoremap <C-e> :NERDTreeToggle<CR>

nnoremap <leader>m :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeWinSize=20

" search
set incsearch
set hlsearch
nnoremap <leader>s :nohlsearch<cr>

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
noremap <leader>0 :tablast<cr>typescript

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

" coc configuration
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
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

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
noremap <F3> :Format<CR>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>A  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>E  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>C  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>O  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>S  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>J  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>K  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>P  :<C-u>CocListResume<CR>

let g:coc_global_extensions = ['coc-json', 'coc-eslint', 'coc-highlight', 'coc-html', 'coc-tslint', 'coc-vetur', 'coc-elixir']

" multiple-cursors

" normal mode / visual mode
"   * start:          `<C-n>` start multicursor and add a _virtual cursor + selection_ on the match
"   * next:           `<C-n>` add a new _virtual cursor + selection_ on the next match
"   * skip:           `<C-x>` skip the next match
"   * prev:           `<C-p>` remove current _virtual cursor + selection_ and go back on previous match
"   * select all:     `<A-n>` start multicursor and directly select all matches

" You can now change the _virtual cursors + selection_ with **visual mode** commands.
" For instance: `c`, `s`, `I`, `A` work without any issues.
" You could also go to **normal mode** by pressing `v` and use normal commands there.

" At any time, you can press `<Esc>` to exit back to regular Vim.

" **NOTE**: start with `g<C-n>` to match without boundaries (behaves like `g*` instead of `*`)

" ### visual mode when multiple lines are selected
"   * start: `<C-n>` add _virtual cursors_ on each line

" You can now change the _virtual cursors_ with **normal mode** commands.
" For instance: `ciw`.

" ### command
" The command `MultipleCursorsFind` accepts a range and a pattern (regexp), it creates a _visual cursor_ at the end of each match.
" If no range is passed in, then it defaults to the entire buffer.


" ## Mapping
" If you don't like the plugin taking over your key bindings, you can turn it off and reassign them the way you want:
" ```viml

" Default mapping
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-d>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-d>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

let g:multi_cursor_exit_from_visual_mode=1

" vim-airline

let g:airline#extensions#tabline#enabled = 1
