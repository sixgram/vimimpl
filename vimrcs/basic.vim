" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin indent on
syntax on                       " Enable syntax highlighting

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set nolist                      " don't show invisible characters by default,
                                " but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"  " Use Unix as the standard file type
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)
set nrformats=                  " make <C-a> and <C-x> play well with
                                "    zero-padded numbers (i.e. don't consider
                                "    them octal or hex)
set shortmess+=I                " hide the launch screen
set clipboard=unnamed           " normal OS clipboard interaction
set autoread                    " Set to auto read when a file is changed from the outside
" set lbr                         " Linebreak on 500 characters
" set tw=500
" set ai                          "Auto indent
" set si                          "Smart indent

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" Toggle line numbers
nnoremap <leader>N :setlocal number!<cr>

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" }}}

" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=99           " start out with everything unfolded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>
" }}}

" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high
" }}}

" Vim behaviour {{{
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
" set nowb
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.class
set wildignore+=*.o,*~,*.pyc
set wildignore+=.git\*,.hg\*,.svn\*
set title                       " change the terminal's title
" set visualbell                  " don't beep
set noerrorbells                " don't beep
set novisualbell
" set t_vb=
" set tm=500
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)
"set ttyfast                     " always use a fast terminal
set cursorline                  " underline the current line, for quick orientation
 " => Vim grep
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH
"
" Specify the behavior when switching between buffers
" try
  " set switchbuf=useopen,usetab,newtab
  " set stal=2
" catch
" endtry
" set so=7
" "Always show current position
" set ruler
" set whichwrap+=<,>,h,l
" " For regular expressions turn magic on
" set magic
" " How many tenths of a second to blink when matching brackets
 " }}}

 " Toggle the quickfix window {{{
" From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}

" Toggle the foldcolumn {{{
nnoremap <leader>f :call FoldColumnToggle()<cr>

let g:last_fold_column_width = 4  " Pick a sane default for the foldcolumn

function! FoldColumnToggle()
    if &foldcolumn
        let g:last_fold_column_width = &foldcolumn
        setlocal foldcolumn=0
    else
        let &l:foldcolumn = g:last_fold_column_width
    endif
endfunction
" }}}

" Highlighting {{{
if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif
" }}}

" Shortcut mappings {{{
" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, as I don't have to press the Shift key to form chords to
" enter ex mode.
nnoremap ; :
nnoremap <leader>; ;

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>

nnoremap <leader>Q :q<CR>    " quickly close the current window
nnoremap <leader>q :bd<CR>   " quickly close the current buffer

 " Use Q for formatting the current paragraph (or visual selection)
" vnoremap Q gq
" nnoremap Q gqap
" set breakindent on  " keep paragraph indentation when re-wrapping text

" Sort paragraphs
vnoremap <leader>s !sort -f<CR>gv
nnoremap <leader>s vip!sort -f<CR><Esc>

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Shortcut to make
nnoremap mk :make<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" nnoremap <leader>e <C-w>v<C-w>l

" Complete whole filenames/lines with a quicker shortcut key in insert mode
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>

" Quick yanking to the end of the line
nnoremap Y y$

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.vim/impl/vimrcs/vimrc<CR>
nmap <silent> <leader>sv :so ~/.vim/impl/vimrcs/vimrc<CR>

" Clears the search register
nnoremap <silent> <leader><cr> :nohlsearch<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nnoremap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n n:call PulseCursorLine()<cr>
nnoremap N N:call PulseCursorLine()<cr>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Ctrl+W to redraw
nnoremap <C-w> :redraw!<cr>

" " Jump to matching pairs easily, with Tab
" nnoremap <Tab> %
" vnoremap <Tab> %

" " Folding
" nnoremap <Space> za
" vnoremap <Space> za

" Strip all trailing whitespace from a file, using ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" grep/Ack/Ag for the word under cursor
vnoremap <leader>a y:Ack! "\b<c-r>"\b" <c-r>=expand("%:p:h")<cr>/
nnoremap <leader>a :Ack! "\b<c-r><c-w>\b" <c-r>=expand("%:p:h")<cr>/
" nnoremap K *N:Ack! "\b<c-r><c-w>\b"<cr>:cw<cr>

" Allow quick additions to the spelling dict
" nnoremap <leader>g :spellgood <c-r><c-w>

"" Define "Ag" command
" command -nargs=+ -complete=file -bar Ag silent! grep! <args> | cwindow | redraw

" " bind \ (backward slash) to grep shortcut
" nnoremap \ :Ag<SPACE>

" Creating folds for tags in HTML
"nnoremap <leader>ft Vatzf

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

 " Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabnext<CR>
map <leader>t<leader> :tabmove<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>e :e <c-r>=expand("%:p:h")<cr>/
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Buffers, preferred over tabs now with bufferline.
nnoremap gn :bnext<CR>
nnoremap gm :bprevious<CR>
nnoremap gd :bdelete<CR>
nnoremap gf <C-^>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Yank(copy) to system clipboard
noremap <leader>y "+y
noremap <leader>p "+p

iabbr m@@ sixgram@github.com
iabbr v@@ sixgram@gmail.com
iabbr ssig --<cr>liu ke<cr>sixgram@gmail

" Quote words under cursor
" nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
" nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l

" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $
 " Split previously opened file ('#') in a split window
nnoremap <leader>sh :execute "leftabove vsplit" bufname('#')<cr>
nnoremap <leader>sl :execute "rightbelow vsplit" bufname('#')<cr>
" }}}

" Disable annoying ex mode (Q)
" map Q <nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set guifont=Anonymous\ for\ Powerline:h12 linespace=2
" set guifont=Droid\ Sans\ Mono\ 10 linespace=0
" set guifont=Mensch\ for\ Powerline\ 10 linespace=0
" set guifont=saxMono:h14 linespace=3
" set guifont=Ubuntu\ Mono\ 10 linespace=3
" set guifont=Source\ Code\ Pro\ Light\ 10 linespace=0
set guifont=Monospace\ 11 linespace=0
set background=dark

" Set extra options when running in GUI mode
" Remove toolbar, left scrollbar and right scrollbar
if has("gui_running")
    " colorscheme jellybeans
    " colorscheme wombat
    colorscheme solarized
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set t_Co=256
    set guitablabel=%M\ %t
else
    colorscheme molokai
    "colorscheme railscat
    "colorscheme molokai_deep
    "colorscheme wombat256
    "colorscheme mustang
    "colorscheme mustang_silent
    "colorscheme badwolf
    set t_Co=256
    "colorscheme jellybeans
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ack after the selected text
" vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" " Open Ack and put the cursor in the right position
" map <leader>g :Ack

" " When you press <leader>r you can search and replace the selected text
" vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Switch from block-cursor to vertical-line-cursor when going into/out of
" insert mode
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" " Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
" map <leader>cv :botright cope<cr>
" map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
" map <leader>n :cn<cr>
""map <leader>p :cp<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Pressing ,ss will toggle and untoggle spell checking
" map <leader>ss :setlocal spell!<cr>
" " Shortcuts using <leader>
" map <leader>sn ]s
" map <leader>sp [s
" map <leader>sa zg
" map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Remove the Windows ^M - when the encodings gets messed up
" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" " Quickly open a buffer for scribble
" map <leader>q :e ~/buffer<cr>
" " Quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>
" " Toggle paste mode on and off
" map <leader>pp :setlocal paste!<cr>

" Pulse ------------------------------------------------------------------- {{{

function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

 "    hi CursorLine guibg=#3a3a3a
    " redraw
    " sleep 20m

"     hi CursorLine guibg=#4a4a4a
    " redraw
    " sleep 30m

    " hi CursorLine guibg=#3a3a3a
    " redraw
    " sleep 30m

    " hi CursorLine guibg=#2a2a2a
    " redraw
    " sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
