" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup		    " keep a backup file
set history=50		" keep 50 lines of command line history
set encoding=utf-8
set ruler		    " show the cursor position all the time
set number		    " display line number
set showmode
set showmatch
set showcmd	    	" display incomplete commands
set incsearch		" do incremental searching
set ignorecase smartcase		" igonre case searching
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set laststatus=2
set wildmenu		" cmd hintet 
"set shortmess+=I	" startup message
set go-=rL		    " remove right scrollbar
set clipboard=unnamed
set listchars=tab:▸\ ,eol:¬
set hidden
colors molokai		" color scheme

" leader
let mapleader=","
let maplocalleader=","
" mapping
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <bs> <nop>
inoremap jk <esc>
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>l :set list!<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap ; :
nnoremap : ;
vnoremap . :normal.<cr>
vnoremap ; :
cnoremap %% <c-r>=fnameescape(expand('%:h')).'/'<cr>
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" abbrevation
iabbrev @@ yongjia.guo@gmail.com

runtime! ftplugin/man.vim

execute pathogen#infect()

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
"  set mouse=a
endif


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set cmdheight=2
  if has("gui_win32")
      set guifont=Consolas:h10
      set guioptions=egt
  endif
endif

if executable("par")
  set formatprg=par
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  autocmd!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType javascript set tabstop=4 softtabstop=4 shiftwidth=4 expandtab 

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
