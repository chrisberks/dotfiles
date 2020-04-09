set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on     " required



" Set leader
let g:mapleader = ','



"
" Settings
"
set encoding=utf-8              " Set default encoding to UTF-8
set noerrorbells                " No beeps
set nofoldenable                " Disable code folding
set noshowmode                  " Don't show which mode, we're using Airline
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set showmatch                   " Show bracket matches
set splitbelow                  " Split horizontal windows below to the current windows
set splitright                  " Split vertical windows right to the current windows
set autoread                    " Automatically reread changed files without asking me anything
set autowrite                   " Automatically save before :next, :make etc.
set laststatus=2                " Always show status bar
set ruler                       " Show cursor's line and column number

" Backups
set backupcopy=yes              " Make sure file watchers work - ref: webpack#781
set backupdir=~/.vim-tmp,/tmp   " Keep my project directory clean
set directory=~/.vim-tmp,/tmp   " 〃

" Search
set incsearch                   " Show search matches while typing
set hlsearch                    " Highlight all search matches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters

" Tab control
set autoindent                  " Automatically indent new line
set backspace=indent,eol,start  " Makes backspace key more powerful
set expandtab                   " Use spaces to insert a tab
set shiftround                  " Round indent to a multiple of 'shiftwidth'
set shiftwidth=4                " Number of spaces to use for indent and unindent
set smarttab                    " Tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4                   " Visible width of a tab

" Model citizen
set colorcolumn=80              " Keep code to 79 columns
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Speed up syntax highlighting
set nocursorcolumn              " Don't highlight the cursor's column
set nocursorline                " Don't highlight the cursor's line
set regexpengine=1              " Use the old regex engine
set synmaxcol=300               " Only highlight first 300 columns, default is 3000
syntax sync minlines=256        " Use third syncing method :syn-sync-third

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

set ttyfast

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Use list mode to show some unprintable characters
"
" - Tab                   U+23B8 left vertical box line
" - Trailing space        U+00B7 middle dot
" - Non-breaking space    U+00B0 degree sign
"
set list listchars=tab:\⎸\ ,trail:·,nbsp:°

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Windmenu completion
set wildmenu                    " Enable bash style tab completion
set wildmode=list:longest,full  " Complete files like a shell



syntax enable



" Open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L



"
" vim-airline
"
let g:airline_theme = 'simple'
let g:airline_powerline_fonts=1

" Use powerline fonts when not in a ssh session
let g:remoteSession = ($STY == "")
if !g:remoteSession
  let g:airline_powerline_fonts=1
endif



" Clear search highlighting
nnoremap <silent> <leader>/ :nohlsearch<cr>



" Faster window navigation
map <C-h> <C-w><C-h>
map <C-j> <C-w><C-j>
map <C-k> <C-w><C-k>
map <C-l> <C-w><C-l>

"
" Disable repetitive strain injury mode
"
" Use hjkl
noremap <Left> :echoe "Use h"<CR>
noremap <Down> :echoe "Use j"<CR>
noremap <Up> :echoe "Use k"<CR>
noremap <Right> :echoe "Use l"<CR>
" noremap <BS> :echoe "Use cw"<CR>

" Get out of Insert mode
inoremap <Left> <nop>
inoremap <Down> <nop>
inoremap <Up> <nop>
inoremap <Right> <nop>
" inoremap <BS> <nop>



"
" File type settings
"
" Go settings
autocmd BufNewFile,BufRead *.go setlocal ts=4 sw=4 sts=4 noexpandtab
