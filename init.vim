
"dnf -y install neovim
"dnf -y install python2-neovim python3-neovim
"
"The default config file location is:
"~/.config/nvim/init.vim
"
"the plugin manager
"
"cd ~/.config/nvim/autoload &&
"wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" run nvim, type :PlugInstall
"
"install psutil
"pip3 install psutil
"
"Fedora specific before installing psutil:
"dnf install redhat-rpm-config
"dnf install python3-devel
"
"update remotes before processing to get rid of any errors
"
"spidermokney-bin
"rhino
"

filetype off                  " required

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction



call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'majutsushi/tagbar'
Plug 'neomake/neomake'
Plug 'vimlab/neojs'
Plug 'ternjs/tern_for_vim'

Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'benmills/vimux'
Plug 'dracula/vim'
Plug 'rodjek/vim-puppet'
Plug 'kchmck/vim-coffee-script'
Plug 'airblade/vim-gitgutter'
Plug 'derekwyatt/vim-scala'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Valloric/MatchTagAlways'
Plug 'jiangmiao/auto-pairs'
Plug 'c0r73x/neotags.nvim',  { 'do': function('DoRemote') }

Plug 'gosukiwi/vim-atom-dark'

Plug 'Shougo/unite.vim'
Plug 'vim-syntastic/syntastic'
call plug#end()              " required
" ycpme

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

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
"let g:deoplete#enable_at_startup = 1

" Neomake on save
autocmd! BufWritePost * Neomake


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
colorscheme torte
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

"#######################
" custom aliases, universally shared
" for convenience
"#######################
nnoremap <F3> :PlugInstall<CR>
nnoremap <F4> :source ~/.config/nvim/init.vim<CR>
"saves session"
nnoremap <F5> :call SaveSess()<CR>
"restores session"
nnoremap <F6> :source ./session.vim<CR>
nnoremap <F7> :!svn commit -m "committing %"<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F9> :NERDTreeToggle<CR>
nnoremap <C-c> :!sbt clean compile run<CR>

nnoremap <C-a> :res +1<CR>
nnoremap <C-q> :res -1<CR>
nnoremap <C-f> :vertical res +1<CR>
nnoremap <C-d> :vertical res -1<CR>

nnoremap qqq :q! <CR>
nnoremap ttt :write! <CR><CR>
nnoremap sss :%s/\s\+$//<CR>

"##
"session save and restore
"##
fu! SaveSess()
    "incase we mess up by clicking f5 instead of f6. one time protection.
    "
    "so use with care.
    execute '!mv session.vim session.vim.old'
    execute 'mksession! session.vim'
endfunction


"grepping for text in files, useful.
fu! Gfind(src, text)

endfunction

"save instead of :w
fu! SaveW()
    command! w Write
endfunction
echo ' <F3> :PlugInstall<CR>'
echo ' <F4> :source ~/.config/nvim/init.vim<CR>'
echo ' <F5> :mksession ./vimsession<CR>'
echo ' <F6> :source ./vimsession<CR>'
echo ' <F7> :!svn commit -m "committing %"<CR>'
echo ' <F8> :TagbarToggle<CR>'
echo ' <F9> :NERDTreeToggle<CR>'
echo ' <C-c> :!sbt clean compile run<CR>'
echo ' <C-a> :res +1<CR>'
echo ' <C-q> :res -1<CR>'
echo ' <C-f> :vertical res +1<CR>'
echo ' <C-d> :vertical res -1<CR>'
echo ' qqq :q! <CR>'
echo ' sss :%s/\s\+$//<CR>'

" Neomake When writing a buffer.
call neomake#configure#automake('w')
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
" Syntastic, again...
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1


