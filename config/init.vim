" Enable indentation based on file type.
syntax on
filetype plugin indent on

au BufNewFile,BufRead *.md set filetype=markdown
au FileType markdown,rst,text call SetupText()

function! SetupText()
    set textwidth=80
    set wrapmargin=2
    set colorcolumn=80
    set linebreak
    set spell spelllang=ru_ru,en_us
    set spellcapcheck="\(См\)\@<![.?!]\_[\])'" \t]\+"
endfunction

let g:vim_markdown_new_list_item_indent = 2

au BufNewFile,BufRead * call ToggleWrap()
au BufNewFile,BufRead *.bb set filetype=bbcode

let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#branch#enabled = 1

set mouse=

set hidden

set nobackup
set nowritebackup
set noundofile

set expandtab
set smarttab
set smartindent
set tabstop=4
set softtabstop=4
set virtualedit=

" Language mapping allows the use of shortcuts even in Russian layout.
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

set number

set hlsearch
set incsearch
set showmatch  " move to the match
set smartcase  " case-sensitive search if pattern contains uppercase

set wrap       " enable word-wrap
set linebreak  " break lines at word-wraps
set nolist     " list disables linebreak

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" no idea what's this: http://www.stephendiehl.com/posts/vim_2016.html
set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu

set t_Co=256

set cmdheight=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

colorscheme elflord

" <Ctrl>+<L> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Workaround 7-bit terminal input mode.
map j <A-j>
map k <A-k>

nnoremap gb :bnext<CR>
nnoremap gB :bprev<CR>
nnoremap <C-PageDown> :bnext<CR>
nnoremap <C-PageUp> :bprev<CR>
nnoremap bc :bdelete<CR>
nnoremap ba :badd<Space>

" When long lines are wrapped, move through display lines,
" otherwise move through pysical lines.
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function! ToggleWrap()
    if &wrap
        "echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        "echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction

noremap WW :call WriteAsRoot()<CR>

function! WriteAsRoot()
    write !sudo -S tee >/dev/null %
endfunction
