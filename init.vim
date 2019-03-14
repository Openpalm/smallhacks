"""""""""""""""""""
" preambl3333     "
"""""""""""""gog!q2w1e4r3""""""
"""""""
"PLUG
"""""""
if empty(glob('~/.vim/autoload/plug.vim'))
!wget -P ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
echo "Plug found. skipping."
endif
"""""""
"GIT
"""""""
if executable('git')
echo "git found. skipping."
else
echo "installing git ..."
!sudo apt-get -y install git
endif
"""""""
"SVN
"""""""
if executable('svn')
echo "svn found. skipping."
else
echo "installing svn ..."
!sudo apt-get -y install subversion
endif

"""""""
"PYTHON
"""""""
if executable('python3')
echo "python3 found. skipping."
"!sudo -H pip3 -y install --upgrade pip
else
echo "installing python 3 ..."
!sudo apt-get -y install python3-dev
" !sudo -H pip3 -y install --upgrade pip
endif
"""""""
"CTAGS
"""""""
"if executable('ctags-exuberant')
"echo "exuberant ctags found. skipping."
"else
"echo "installing exuberant ctags skipping ..."
"!sudo apt-get -y install ctags
"!sudo apt-get -y install exuberant-ctags
"endif
"""""""
"SCREEN
"""""""
if executable('screen')
echo "screen found. skipping."
else
!sudo apt-get -y install screen
!wget https://raw.githubusercontent.com/Shokodemon/smallhacks/master/screenrc_cnc ~/.screenrc
endif
"""""""
"SCALA
"""""""
if executable('scalac')
echo "scala found. skipping."
else
echo "installing scala and sbt ..."
!sudo apt-get -y install scala sbt
endif
"""""""
"JAVA
"""""""
if executable('java')
echo "java found. skipping."
else
echo "installing java 8..."
!sudo apt-get -y install openjdk-8-jdk
endif
"""""""
"HTOP
"""""""
if executable('htop')
echo "htop found. skipping."
else
echo "installing htop..."
!sudo apt-get -y install htop
endif
"""""""
"GCC
"""""""
if executable('gcc')
echo "gcc found. skipping."
else
echo "installing gcc..."
!sudo apt-get -y install gcc
endif
if executable('rg')
echo "ripgrep found. skipping."
else
echo "installing ripgrep..."
!sudo apt-get -y install ripgrep
endif
if executable('fzf')
echo "fzf found. skipping."
else
echo "installing fzf..."
!git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
!exec ~/.fzf/install
endif

"""""""""""""""""""
" vim conf start  "
"""""""""""""""""""

set nu
call plug#begin()
" - VIM PLUG
" deoplete plugin for autocomplete autotag plugin to automatically generate ctags file Plug 'craigemery/vim-autotag'
" ctags stuff

set tags=.tags
let g:autotagTagsFile=".tags"
" Map the leader key to fullstop

"Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'greggerz/nerdtree-svn-plugin'

"git
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "✹",
\ "Staged"    : "✚",
\ "Untracked" : "✭",
\ "Renamed"   : "➜",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "✗",
\ "Clean"     : "✔︎",
\ 'Ignored'   : '☒',
\ "Unknown"   : "?"
\ }
"svn
let g:NERDTreeSvnIndicatorMapCustom = {
  \ 'Modified'  : '✹',
  \ 'Addition'  : '✚',
  \ 'Untracked' : '✭',
  \ 'Replaced'  : '➜',
  \ 'Deleted'   : '✖',
  \ 'Dirty'     : '✗',
  \ 'Clean'     : '✔︎',
  \ 'Ignored'   : '☒',
  \ 'Missing'   : '⁈',
  \ 'Conflict'  : '⇏',
  \ 'Externals' : '↰',
  \ 'Unknown'   : '?'
  \ }
map <C-i> :TagbarToggle<CR>
nnoremap <F9> :NERDTreeToggle<CR>

let mapleader = ' '

"delte trailing spaces
nnoremap <leader>s            :%s/\s\+$//<CR>
"open this file
nnoremap <leader>e            :tab new ~/.config/nvim/init.vim<CR>
"save
nnoremap <leader>w            :w!<CR>
"quit
nnoremap <leader>q            :q!<CR>
"ask/search pattern
nnoremap <leader>a            :?
"find and replace
nnoremap <leader>r            "zyiw:exe "%s=".@z."= =gg"
"lazy :
nnoremap <leader><leader>     :
"filesearch
nnoremap <leader>g    :FZF<CR>

" Regenerate tags file
map .c :!ctags -R -f ./.tags .<CR>

"optional, prefer fzf
"Plug 'ctrlpvim/ctrlp.vim'

" Ripgrep for file indexing, sort of faster, but not really, but also why not use ripgrep for everything
if executable('rg')
let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages "" .'
set grepprg=rg\ --vimgrep
endif

"togglelist - toggle quickfix list with leader-q
let g:toggle_list_no_mappings = 1
"nmap <script> <leader>q :call ToggleQuickfixList()<CR>

" Use FZF for files and tags if available, otherwise fall back onto CtrlP
" <leader>\ will search for tag using word under cursor
let g:fzf_command_prefix = 'FZF'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'sudo ./install --all' }
"Plug 'junegunn/fzf.vim', { 'dir': '~/.fzf', 'do': 'sudo ./install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
set rtp+=~/.fzf
"nnoremap <leader>t :FzfTags<cr>
"nnoremap <leader>u :call fzf#vim#tags("'".expand('<cword>'))<cr>

"if executable('fzf')
"    echo found fzf.
"
"    Plug 'autozimu/LanguageClient-neovim', {
"        \ 'branch': 'next',
"        \ 'do': 'bash install.sh',
"        \ }
"
"    " (Optional) Multi-entry selection UI.
"    "
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"    "
"
"
"    nnoremap <leader>f :FzfFiles<cr>
"    nnoremap <leader>t :FzfTags<cr>
"    nnoremap <leader>u :call fzf#vim#tags("'".expand('<cword>'))<cr>
"else
"
"    !echo fzf not found, installing.
"    !git clone https://github.com/junegunn/fzf
"    !cd ${PWD} && ./install
"
"    nnoremap <leader>f :CtrlP<Space><cr>
"    nnoremap <leader>t :CtrlPTag<Space><cr>
"
"endif
" Tagbar extra mods
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let colour = a:current ? '%#StatusLine#' : '%#StatusLineNC#'
    return colour . '[' . a:sort . '] ' . a:fname
endfunction
let g:tagbar_status_func = 'TagbarStatusFunc'
let g:tagbar_iconchars = ['▶', '▼']
let g:tagbar_type_scala = {
            \ 'ctagstype' : 'scala',
            \ 'sro'        : '.',
            \ 'kinds'     : [
            \ 'p:packages',
            \ 'T:types:1',
            \ 't:traits',
            \ 'o:objects',
            \ 'O:case objects',
            \ 'c:classes',
            \ 'C:case classes',
            \ 'm:methods',
            \ 'V:values:1',
            \ 'v:variables:1'
            \ ]
            \ }

" deoplete stuff

let g:deoplete#enable_at_startup = 1

" Remap <tab> to allow cycling through the deoplete list, but only when the
" deoplete list window is open. Leave <tab> alone the rest of the time.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" Here's the complete list of my neovim plugins, in case you're interested
" General
Plug 'scrooloose/nerdcommenter'


"" Add spaces after comment delimiters by default
"" let g:NERDSpaceDelims = 1
""
"" " Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
""
"" " Align line-wise comment delimiters flush left instead of following code
"" indentation
" let g:NERDDefaultAlign = 'left'
""
"" " Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
"" let g:NERDAltDelims_scala= 1
"""
"" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
""
"" " Allow commenting and inverting empty lines (useful when commenting a
"" region)
" let g:NERDCommentEmptyLines = 1
""
"" " Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1
""
"" " Enable NERDCommenterToggle to check all selected lines is commented or not
" let g:NERDToggleCheckAllLines = 1

Plug 'scrooloose/syntastic'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular'
Plug 'sbdchd/neoformat'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'justinmk/vim-sneak'
Plug 'embear/vim-localvimrc'
Plug 'cloudhead/neovim-fuzzy'
Plug 'bling/vim-airline'
Plug 'milkypostman/vim-togglelist'


Plug 'vim-scripts/Scala-Java-Edit'

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle 1 to enable by default

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
                \   '%dW %dE',
                \   all_non_errors,
                \   all_errors
                \)
endfunction

"set statusline+=%{LinterStatus()}
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_scala_checkers = ['scalac']
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)


" Tags
Plug 'majutsushi/tagbar'
Plug 'craigemery/vim-autotag'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


" Language plugins
" Scala plugins
if executable('scalac')
    Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
"    Plug 'w0rp/ale'
endif

if executable('rg')
    echo "rigrip available, remapping fzf#vim#grep ..."
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)
else
    echo "installing rigrip 0.9 from gitrepo ..."
    !curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb
    !sudo dpkg -i ripgrep_0.9.0_amd64.deb
endif
Plug 'eed3si9n/LanguageClient-neovim'
" SBT server
"set signcolumn=yes
"let g:LanguageClient_autoStart = 1
"let g:LanguageClient_serverCommands = {
"    \ 'scala': ['fsc']
"    \ }
"let g:LanguageClient_serverCommands = {
"            \ 'scala': ['node', expand('/usr/local/bin/sbt-server-stdio.js')]
"            \ }
"nnoremap gd :call LanguageClient_textDocument_definition()<CR>
"set omnifunc=LanguageClient#complete
"set formatexpr=LanguageClient_textDocument_rangeFormatting()
"
"let b:ale_fixers = ['fsc', 'scalac', 'scalastyle']
"let g:ale_fix_on_save = 1
"let g:ale_lint_on_text_changed = 1
"let g:ale_completion_enabled = 1



"if executable('sbt')
"    Plug 'derekwyatt/vim-sbt'
"endif

"colorscheme
Plug 'Badacadabra/vim-archery', { 'as': 'archery' }
call plug#end()
"colorscheme archery


" LOOK AND SYNTAX HILIGHTING {{{
"fix for mac terminal colors going weird
if $TERM =~ '^\(xterm\|interix\|putty\)\(-.*\)\?$'
    set notermguicolors
else
    set termguicolors
endif

syntax on
set background=dark

"colorscheme industry
"let g:airline_theme = 'industry'

"set cursorline

"shortcut to move physical lines Alt-j and Alt-k
"nnoremap <A-j> :m .+1<CR>==
"nnoremap <A-k> :m .-2<CR>==
"inoremap <A-j> <Esc>:m .+1<CR>==gi
"inoremap <A-k> <Esc>:m .-2<CR>==gi
"vnoremap <A-j> :m '>+1<CR>gv=gv
"vnoremap <A-k> :m '<-2<CR>gv=gv

" change vim scroll keys
"nnoremap <C-J> <C-D>
"nnoremap <C-K> <C-U>
"
"" change jump to definition
nnoremap <leader>. <C-]>
nnoremap <leader>, <C-T>
"
"" easier split navigations
"nnoremap <leader>j <C-W><C-J>
"nnoremap <leader>k <C-W><C-K>
"nnoremap <leader>l <C-W><C-L>
"nnoremap <leader>h <C-W><C-H>


" airline
set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="|"
let g:airline_right_sep=""
let g:airline_right_alt_sep="|"
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number not number of split panes
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline_section_z = ""


"Bassel
set tabstop=8 softtabstop=0 expandtab shiftwidth=4
set autoindent
set smartindent
set nu

set wrapscan

if exists("*shiftwidth")
    func! s:sw()
        return shiftwidth()!
    endfunc
else
    func! s:sw()
        return &sw
    endfunc
endif

"#######################
"space tabs, instead of real tabs.
"#######################
set tabstop=2
"set noexpandtab
set expandtab
"set tabstop=2




"#######################
"ruler and measurements
"#######################
set ruler "Always show current position"
set nu "enables line numbers "
set relativenumber
set foldmethod=indent
"set foldnestmax=10
set nofoldenable
set foldlevel=1

let g:auto_save = 1
set backup                        " enable backups
set noswapfile

set undodir=~/tmp/undo/     " undo files
set backupdir=~/tmp/backup/ " backups
set directory=~/tmp/swap/   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p") endif if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

set autoread
""
" Triger `autoread` when files changes on disk
" "
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" "
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
 autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" " Notification after file change
" " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
 autocmd FileChangedShellPost *
   \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." |
   echohl None
""
set history=1000
set undofile "we like the undo file"
set undolevels=1000
set undoreload=1000
" swap dir
augroup NoSimulataneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice= 'o'
    autocmd SwapExists * echomsg ErrorMsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
augroup END



"#######################
" colorization
"#######################
syntax enable
set ofu=syntaxcomplete#Complete
syntax on

"#######################
"bracket completion"
"#######################

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


inoremap _( ()<Esc>:call BC_AddChar(")")<CR>i
inoremap _{ {<CR>}<Esc>:call BC_AddChar("}")<CR><Esc>kA<CR>
inoremap _[ []<Esc>:call BC_AddChar("]")<CR>i
inoremap _" ""<Esc>:call BC_AddChar("\"")<CR>i
inoremap _' ''<Esc>:call BC_AddChar("\'")<CR>i
inoremap _< ''<Esc>:call BC_AddChar(">")<CR>i

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType scala setlocal omnifunc=scalacomplete#CompleteTags

"custom remaps

"update + close side window when done

"echo "Updating plugins ...\n"
":PlugClean
":PlugInstall
":PlugUpdate
":q


nnoremap <Leader>- <Esc>:vertical resize +5<CR>
nnoremap <Leader>= <Esc>:vertical resize -5<CR>

noremap <F5> :!scalafmt %<CR>

let g:formatdef_scalafmt = '"scalafmt --stdin 2>/dev/null"'
let g:formatters_scala = ['scalafmt']

