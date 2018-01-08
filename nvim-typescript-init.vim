filetype off                  " required

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction



call plug#begin('~/.vim/plugged')

Plug 'neomake/neomake'
"typescript
Plug 'Quramy/tsuquyomi'
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/vimproc'
Plug 'leafgarland/typescript-vim'
Plug 'mhartington/nvim-typescript'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'benmills/vimux'
Plug 'dracula/vim'
Plug 'airblade/vim-gitgutter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'gosukiwi/vim-atom-dark'
Plug 'Valloric/MatchTagAlways'
Plug '907th/vim-auto-save'
Plug 'c0r73x/neotags.nvim',  { 'do': function('DoRemote') }

call plug#end()              " required

" Non-Plug stuff after this line
" ================================

"ctags auto completion @ leonard.io/blog/2013/04/editing-scala-with-vim/
set tags=./tags;,tags;/
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:scala_sort_across_groups=1
set regexpengine=1
nnoremap <C-T> <C-w>g] <C-r><C-w>

set tabstop=8 softtabstop=0 expandtab shiftwidth=4
set autoindent
set smartindent
set nu

%retab

"Use deoplete
"let g:python3_host_prog = "~/.pyenv/versions/neovim3/bin/python3"
let g:deoplete#enable_at_startup = 1

" typescript options 
au BufRead,BufNewFile *.ts   setfiletype typescript
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_typescript_checkers = ['tsuquyomi'] 

let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_completion_detail = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_profile = 1


let g:auto_save = 1
"autocmd TextChanged,TextChangedI <buffer> silent write
set backup                  " enable backups
set noswapfile

set undodir=~/tmp/undo/     " undo files
set backupdir=~/tmp/backup/ " backups
set directory=~/tmp/swap/   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

set history=10000
set undofile "we like the undo file"
set undolevels=10000
set undoreload=10000

" swap dir
augroup NoSimulataneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice= 'o'
    autocmd SwapExists * echomsg ErrorMsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
augroup END



" Gitgutter show more signs
let g:gitgutter_max_signs = 1500

" Function for number toggle
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <C-N> :call NumberToggle()<cr>

" Function for whitespace toggle
function! WhitespaceToggle()
    set listchars=eol:¬,tab:--,trail:~,extends:>,precedes:<
    if(&list ==1)
        set nolist
    else
        set list
    endif
endfunc

function! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun

"command! TrimWhitespace call TrimWhitespace() " Trim whitespace with command
"autocmd BufWritePre * :call TrimWhitespace() " Trim whitespace on every save

" Non-mapped function for tab toggles
function! TabToggle()
    if &expandtab
        set noexpandtab
    else
        set expandtab
    endif
endfunc

" Remappings
"        Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"    Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"    Disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"    Nerdtree
autocmd FileType nerdtree setlocal nolist
"let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Other options
set relativenumber
set number
let mapleader=','
set backspace=2
colorscheme atom-dark-256
syntax on
set shell=/bin/bash
set laststatus=2
set noshowmode

" Draw a line at 80 columns
set colorcolumn=80
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Check the function above, these
" are my default values
set tabstop=4
set shiftwidth=4
set expandtab

"typescript

"#######################
" custom aliases, universally shared
" for convenience
"#######################
nnoremap <F2> :call MyCommands()<CR>
nnoremap <F3> :PlugInstall<CR>
nnoremap <F4> :source ~/.config/nvim/init.vim<CR>
nnoremap <F5> :mksession ./vimsession<CR>
nnoremap <F6> :source ./vimsession<CR>
nnoremap <F9> :NERDTreeToggle<CR>

nnoremap qqq :q! <CR>
nnoremap sss :%s/\s\+$//<CR>
function! MyCommands()
    echo 'F2 -> prints this'
    echo 'F3 -> execute :PlugInstall'
    echo 'F4 -> reload init.vim'
    echo 'F5 -> save this session'
    echo 'F6 -> restore previously saved session'
    echo 'F9 -> NERDTree'
    echo 'sss -> removes whitespaces from EOL'
endfunction


"#######################
"bracket completion"
"#######################
inoremap _( ()<Esc>:call BC_AddChar(")")<CR>i
inoremap _{ {<CR>}<Esc>:call BC_AddChar("}")<CR><Esc>kA<CR>
inoremap _[ []<Esc>:call BC_AddChar("]")<CR>i
inoremap _" ""<Esc>:call BC_AddChar("\"")<CR>i
inoremap _' ''<Esc>:call BC_AddChar("\'")<CR>i


" jump out of parenthesis, used with the above functions
inoremap <C-j> <Esc>:call search(BC_GetChar(), "W")<CR>a

function! BC_AddChar(schar)
    if exists("b:robstack")
        let b:robstack = b:robstack . a:schar
    else
        let b:robstack = a:schar
    endif
endfunction

function! BC_GetChar()
    let l:char = b:robstack[strlen(b:robstack)-1]
    let b:robstack = strpart(b:robstack, 0, strlen(b:robstack)-1)
    return l:char
endfunction


function! BC_jumpBackChar(num)
    let l:char = b:robstack[strlen(b:robstack)-1]
    let b:robstack = strpart(b:robstack, 0, strlen(b:robstack)-1)
    return l:char
endfunction

