set nocompatible
"
" Plugins
"
call plug#begin('~/.vim/plugged')

"Plug 'sheerun/vim-polyglot'     "for many language syntax highlighting
Plug 'rhysd/vim-llvm'           "for llvm syntax highlighting
"Plug 'bfrg/vim-cpp-modern'      "for cpp syntax highlighting
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
"Plug 'ayu-theme/ayu-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'farmergreg/vim-lastplace'
Plug 'justinmk/vim-dirvish'
Plug 'simnalamburt/vim-mundo'

" Use release branch (recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim' ", {'tag': 'v0.0.78'}

" Or build from source code by using yarn: https://yarnpkg.com
"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'Yggdroot/indentLine' "https://github.com/Yggdroot/indentLine.git
Plug 'preservim/nerdtree'
" Cocinstall coc-java로 깔긴 깔았는데 어케쓰는지 모르겟음.;; https://github.com/neoclide/coc-java
call plug#end()



"
" Plugin configs
"

" nerdtree
noremap <silent> <C-n> :NERDTreeToggle<CR>
function! s:nerdtree_startup()
    if exists('s:std_in') || argc() != 1 || !isdirectory(argv()[0])
        return
    endif
    execute 'NERDTree' argv()[0]
    wincmd p
    enew
    execute 'cd '.argv()[0]
    NERDTreeFocus
endfunction
augroup vimrc_nerdtree
    autocmd!

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * call s:nerdtree_startup()
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" indentline
let g:indentLine_char_list = ['|'] ", '¦']
let g:indentLine_setColors = 0

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" vim-better-whitespace
let g:better_whitespace_guicolor='#585858'

" mundo
if has('persistent_undo')
  set undofile
  let &undodir = $HOME . '/.vim/undodir'
  silent! call mkdir(&undodir, 'p')
endif
let g:mapleader = ','
nnoremap <leader>g :MundoToggle<CR>

" coc.nvim, Press "K" to show detail
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" coc-highlight
augroup vimrc_highlight
  autocmd!
  autocmd CursorHold * silent call <SID>highlight()
augroup END
function! s:highlight()
  if exists('*CocActionAsync')
    call CocActionAsync('highlight')
  endif
endfunction
highlight CocHighlightText guibg=#232b32

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" fzf
nnoremap <F5> :call <SID>lsp_menu()<CR>
function! s:lsp_menu()
  call fzf#run({
  \ 'source': [
  \   'rename',
  \   'jumpDefinition',
  \   'jumpDeclaration',
  \   'jumpImplementation',
  \   'jumpTypeDefinition',
  \   'jumpReferences',
  \   'diagnosticInfo',
  \   'diagnosticNext',
  \   'diagnosticPrevious',
  \   'format',
  \   'openLink',
  \   'doQuickfix',
  \   'doHover',
  \   'refactor',
  \ ],
  \ 'sink': function('CocActionAsync'),
  \ 'options': '+m',
  \ 'down': 10 })
endfunction


"
" My configs
"
set smartindent
set cindent
set number
set cursorline
set nowrap     "text no extension
set pastetoggle=<F8>
set updatetime=500
set modeline

" cursor shape: filled box in normal mode, bar in insert mode
if &term =~ '^xterm'
  " Reference: " https://github.com/microsoft/terminal/issues/4335#issuecomment-577365966
  let &t_EI .= "\<Esc>[0 q"
  let &t_SI .= "\<Esc>[5 q"
endif

" Use space*2 as tab by default
set softtabstop=4
set shiftwidth=4
set expandtab		" turn off softtab(to show set list chars)

" set md
autocmd FileType markdown setlocal expandtab softtabstop=4 shiftwidth=4

" mouse wheel available
set mouse=a

" num of lines copyable
set viminfo='20,<1000

" column line 80
set colorcolumn=80

" Highlight hard-tab
set list
let &listchars = 'tab:› ,extends:»,precedes:«'

" Easy file save without switching IME
cabbrev ㅈ w
cabbrev ㅂ q
cabbrev ㅈㅂ wq
cabbrev sws StripWhitespace
cabbrev nt NERDTree

" use vim in Korean
set langmap=ㅁㅠㅊㅇㄷㄹㅎㅗㅑㅓㅏㅣㅡㅜㅐㅔㅂㄱㄴㅅㅕㅍㅈㅌㅛㅋ;abcdefghijklmnopqrstuvwxyz

" Easy command-line mode
nnoremap ; :


"
" In insert or command mode, move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>


"
" abbrevation
" C
autocmd FileType c iabbr pritnf printf
autocmd FileType c iabbr print printf
" java
autocmd FileType java iabbr main public static void main(String[] args)
autocmd FileType java,md iabbr sout System.out.println
"cpp
autocmd FileType cpp iabbr eldn endl
autocmd FileType cpp iabbr elnd endl
autocmd FileType cpp iabbr enld endl
"md
autocmd FileType md iabbr jmain public static void main(String[] args)
"ll
autocmd FileType llvm iabbr [[ [[:%.*]]


" all types
iabbr <img> <h ref="#"><img src="./.png">
iabbr todo //TODO:
iabbr fix //FIXME:

"
" Easy indentation
"
" (visual mode에서) Tab : 인덴트 하나 추가
" (visual mode에서) Shift + Tab : 인덴트 하나 삭제
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Easy delete key
vnoremap <backspace> "_d

" Easy splitting & resizing
"
" ALT + -       : 가로나누기
" ALT + \       : 세로나누기
" ALT + h/j/k/l : 크기조절
nnoremap <silent> <esc>- :split<CR>
nnoremap <silent> <esc>\ :vertical split<CR>
nnoremap <silent> <esc>h :vertical resize -5<CR>
nnoremap <silent> <esc>j :resize -3<CR>
nnoremap <silent> <esc>k :resize +3<CR>
nnoremap <silent> <esc>l :vertical resize +5<CR>

" Tab navigations
"
" ALT + t          : New tab in next pane
" ALT + T          : New tab in previous pane
" ALT + 1/2/.../9  : Browse tabs
nnoremap <esc>t :tabnew<CR>
nnoremap <esc>T :-tabnew<CR>
nnoremap <esc>1 1gt
nnoremap <esc>2 2gt
nnoremap <esc>3 3gt
nnoremap <esc>4 4gt
nnoremap <esc>5 5gt
nnoremap <esc>6 6gt
nnoremap <esc>7 7gt
nnoremap <esc>8 8gt
nnoremap <esc>9 9gt



"
" vim color scheme -------------------------------------------------
"

"
" 1. onedark.vim (atom)
"
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
""If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)

if (empty($TMUX))
   if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif
"
syntax on
colorscheme onedark

"
" cpp highlight options (bfrg/vim-cpp-modern)
"
" Enable highlighting of C++11 attributes
" let g:cpp_attributes_highlight = 1

 " Highlight struct/class member variables (affects both C and C++ files)
" let g:cpp_member_highlight = 1

 " Put all standard C and C++ keywords under Vim's highlight group 'Statement' (affects both C and C++ files)
 "let g:cpp_simple_highlight = 1


"---
"
"  ayu (잘 안 쓰고 overriding 해서 쓴듯?)
"
"set termguicolors
"let ayucolor="mirage"
"colorscheme ayu
"---
"" overriding
"if has('autocmd')
"  augroup coloroverride
"    autocmd!
""   autocmd ColorScheme * highlight LineNr  ctermfg=DarkGrey guifg=DarkGrey " Override LineNr
""    autocmd ColorScheme * highlight CursorLineNr  ctermfg=White guifg=White " Override CursorLineNr
"    autocmd ColorScheme * highlight Statement  ctermfg=11 guifg=#f6a7f8 " Override Statement
"    autocmd ColorScheme * highlight Type  ctermfg=11 guifg=#8ecaff "Override Type
"    autocmd ColorScheme * highlight Identifier  ctermfg=11 guifg=#f8989c " Override Type
"    autocmd ColorScheme * highlight Operator  ctermfg=11 guifg=#aacc41 " Override Type
"    autocmd ColorScheme * highlight Comment ctermfg=11 guifg=#737373
"    autocmd ColorScheme * highlight ColorColumn ctermfg=11 guifg=#607080
"    autocmd ColorScheme * highlight LineNr ctermfg=4 guifg=#607080
"  augroup END
"endif
"silent! colorscheme ayu" Custom color scheme


