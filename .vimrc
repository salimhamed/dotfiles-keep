"don't try to make settings compatible with vi
set nocompatible

"==============================================================================
"PLUGINS
"==============================================================================

" automatic install of plugins
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"colors
Plug 'altercation/vim-colors-solarized'

"productivity
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'

set encoding=UTF-8

call plug#end()


"==============================================================================
"GENERAL SETTINGS
"==============================================================================

"enable filetype detection
filetype on

"rebind <Leader> key
let mapleader = ","

"copy & paste
set pastetoggle=<F2> "toggles paste mode using <F2>
set clipboard=unnamedplus "use the system clipboard

"mouse and backspace
set mouse=a  "on OSX press ALT and click
set bs=2 "make backspace behave like normal again

"bind nohl to remove highlight of your last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

"quicksave command and reapply syntax formatting
noremap <C-Z> :syn sync fromstart <bar> update<CR>
noremap <C-S> :syn sync fromstart <bar> update<CR>

vnoremap <C-Z> <C-C>:syn sync fromstart <bar> update<CR>
vnoremap <C-S> <C-C>:syn sync fromstart <bar> update<CR>

inoremap <C-Z> <C-O>:syn sync fromstart <bar> update<CR>
inoremap <C-S> <C-O>:syn sync fromstart <bar> update<CR>

"bind Ctrl+<movement> keys to move around the windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

"map sort function to a key
vnoremap <Leader>s :sort<CR>

"map white space function
map <Leader>ws :StripWhitespace<CR>

"global tab settings
"file specific settings can be changed in the ftplugin directory
set expandtab "tabs are spaces
set shiftround "round to nearest tab width when moving blocks of text
set smartindent "automatically indent when starting a new line
set tabstop=4 "number of visual spaces per tab
set shiftwidth=4 "number of spaces to use for each step of (auto)indent
set softtabstop=4 "number of spaces in tab when editing

"turn error beeps off
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"ui config
set number "show line numbers
set ruler "show the line and column number of the cursor position
set showcmd "show command in bottom bar
set colorcolumn=80 "show column at 80 characters
set wildmenu "visual autocomplete for command menu
set showmatch "highlight matching brackets and parentheses
set title

"status bar settings
set laststatus=2 "Always display the statusline in all windows
set showtabline=2 "Always display the tabline, even if there is only one tab
set noshowmode "Hide the default mode text (e.g. -- INSERT -- below the statusline)

"allow hidden buffers for switching between buffers without saving
set hidden

"turn of word wrapping
set nowrap

"disable swap files
set noswapfile

"searching"
set hlsearch "highlight matches
set incsearch "search as characters are entered
set ignorecase "ignore case on search
set smartcase "override the ignore case setting when searching with uppercase


"==============================================================================
"COLOR AND THEME SETTINGS
"==============================================================================

let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

"==============================================================================
"CAPSLOCK SETTINGS
"==============================================================================

" Use ctrl+^ for capslock
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

" Kill the capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0


"==============================================================================
"VIM AIRLINE SETTINGS
"==============================================================================

"enable virtualenv integration with vim-airline
"https://github.com/jmcantrell/vim-virtualenv.git
let g:airline#extensions#virtualenv#enabled = 1

"set airline theme
let g:airline_theme="powerlineish"

"enable enhanced vim-airline tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1  "show buffers with single tab
let g:airline#extensions#tabline#buffer_idx_mode = 1 "show buffer index
"let g:airline#extensions#tabline#formatter = 'unique_tail' "short buffer name in tabline, unless not unique
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


"==============================================================================
"AUTOCOMPLETE SETTINGS
"==============================================================================

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1


"==============================================================================
"SYNTASTIC SETTINGS
"==============================================================================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


"==============================================================================
"NERDTREE SETTINGS
"==============================================================================
" ,n to Display the file browser tree
nmap <leader>n :NERDTreeToggle<CR>
" ,p to show current file in the tree
nmap <leader>p :NERDTreeFind<CR>


"==============================================================================
"ADD THE VIRTUALENV'S SITE-PACKAGES TO VIM PATH
"==============================================================================

if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif


"==============================================================================
"VIM OS SPECIFIC SETTINGS
"==============================================================================

"Windows specific settings
if has("win32") || has ('win64')

    "Better font for Windows
    set guifont=Consolas:h10:cANSI

    "function for diff on windows
    set diffexpr=MyDiff()
    function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
        if empty(&shellxquote)
            let l:shxq_sav = ''
            set shellxquote&
        endif
        let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
    endfunction

else

    "Better font for Mac/Linux
    set guifont=Menlo:h13

endif
