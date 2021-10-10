" Plugins ===================================
" ===========================================
call plug#begin()
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive' 
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pantharshit00/vim-prisma'
Plug 'rakr/vim-one'
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'puremourning/vimspector'
Plug 'jesseleite/vim-agriculture'
Plug 'folke/which-key.nvim'
call plug#end()


" General Nvim Setup ========================
" ===========================================
set termguicolors
filetype plugin on
set number
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
syntax enable
colorscheme one 

" Lua setup crap ============================
" ===========================================
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF


" Vimspector ================================
" ===========================================
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEval
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'vscode-cpptools', 'vscode-node-debug2' ]


" Program Paths =============================
" ===========================================
let g:python3_host_prog = "/usr/bin/python3"


" Lightline Setup ===========================
" ===========================================
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'blame' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'blame': 'LightlineGitBlame'
      \ },
      \ }
"let g:lightline = {
			"\ 'colorscheme': 'one',
      "\ 'component_function': {
      "\   }
      "\ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

"-- FOLDING --  
"set foldmethod=syntax "syntax highlighting items specify folds  
"set foldcolumn=1 "defines 1 col at window left, to indicate folding  
"let javaScript_fold=1 "activate folding by JS syntax  
"let typeScript_fold=1 "activate folding by JS syntax  
"set foldlevelstart=99 "start file with all folds opened

" Bindings ==================================
" ===========================================

" Searching ~~~~~~~~~~~~~~~~~~~~~~
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>f :Rg<CR>
nmap <Leader>F <Plug>RgRawSearch
vmap <Leader>F <Plug>RgRawVisualSelection
nmap <Leader>* <Plug>RgRawWordUnderCursor

" Syntax Tree ~~~~~~~~~~~~~~~~~~~~~~
nnoremap <silent> <Leader>b :Vista!!<CR>

" Nerd Tree ~~~~~~~~~~~~~~~~~~~~~~
let NERDTreeShowHidden=1
nmap <C-p> :NERDTreeToggle<CR>
noremap <leader>r :NERDTreeFind<CR>

" Navigation ~~~~~~~~~~~~~~~~~~~~~~ 
inoremap <C-e> <C-o>$| " Go To Line End in Insert Mode
inoremap <C-a> <C-o>0| " Go To Line Start in Insert Mode

" Buffer Switching ~~~~~~~~~~~~~~~~~~~~~~
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab Switching ~~~~~~~~~~~~~~~~~~~~~~
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>

" Delete To Null Reg ~~~~~~~~~~~~~~~~~~~~~~
nnoremap <leader>x "_x
nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>d "_d

" Git ~~~~~~~~~~~~~~~~~~~~~~
nnoremap <leader>gi :CocCommand git.chunkInfo<CR>
nnoremap <leader>gg :CocCommand git.toggleGutters<CR>

nmap <leader>gN <Plug>(coc-git-prevchunk)
nmap <leader>gn <Plug>(coc-git-nextchunk)

nmap <leader>gC <Plug>(coc-git-prevconflict)
nmap <leader>gc <Plug>(coc-git-nextconflict)

" General Commands ~~~~~~~~~~~~~~~~~~~~~~
nnoremap <C-x> :!npm run build<CR>

" Tab Completion ~~~~~~~~~~~~~~~~~~~~~~~~~

" Use tab for trigger completion with characters ahead and navigate.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Diagnostics ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo Code Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show Docs and Hover Highlight ~~~~~~~~~~~~~~~~~~~~~~~~~
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Rename ~~~~~~~~~~~~~~~~~~~~~~~~~~~
nmap <leader>n <Plug>(coc-rename)

" Code Actions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Scroll Floating Windows ~~~~~~~~~~~~~~~~~~~~~~~~~
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  vnoremap <silent><nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Mappings for CoCList ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Grep current word
nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
" Git status list
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
