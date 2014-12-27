set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/impl/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
" Bundle 'gmarik/vundle'

"------------------
" Code Completions
"------------------
Bundle 'Shougo/neocomplcache'
" Bundle 'Shougo/neosnippet'
" Bundle 'Shougo/neosnippet-snippets'
" Bundle 'mattn/emmet-vim'
Bundle 'Raimondi/delimitMate'
" Bundle 'ervandew/supertab'
" snippets
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
"------ snipmate dependencies -------
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

"-----------------
" Fast navigation
"-----------------
" Bundle 'edsono/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'

"--------------
" Fast editing
"--------------
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'sjl/gundo.vim'
Bundle 'godlygeek/tabular'
Bundle 'nathanaelkane/vim-indent-guides'

"--------------
" IDE features
"--------------
" Bundle 'scrooloose/nerdtree'
" Bundle 'humiaozuzu/TabBar'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-powerline'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'bronson/vim-trailing-whitespace'
" Bundle 'itchyny/lightline.vim'
" Bundle 'vim-scripts/mru.vim'
" Bundle 'vim-scripts/taglist.vim'
"-------------
" Other Utils
"-------------
" Bundle 'humiaozuzu/fcitx-status'
" Bundle 'nvie/vim-togglemouse'

"----------------------------------------
" Syntax/Indent for language enhancement
"----------------------------------------
"------- web backend ---------
"------- web frontend ----------
"------- markup language -------
"------- Ruby --------
"------- Go ----------
"Bundle 'fatih/vim-go'
"------- FPs ------
" Bundle 'kien/rainbow_parentheses.vim'
" Bundle 'wlangstroth/vim-racket'
" Bundle 'vim-scripts/VimClojure'
" Bundle 'rosstimson/scala-vim-support'

"--------------
" Color Schemes
"--------------
Bundle 'nanotech/jellybeans.vim'
Bundle 'tomasr/molokai'
Bundle 'vim-scripts/Wombat'
Bundle 'altercation/vim-colors-solarized'
filetype plugin indent on     " required!
