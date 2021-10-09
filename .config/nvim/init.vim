" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'godlygeek/tabular'
Plugin 'edkolev/tmuxline.vim'
Plugin 'bling/vim-bufferline'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'majutsushi/tagbar'
Plugin 'chiel92/vim-autoformat'
Plugin 'valloric/youcompleteme'
Plugin 'rdnetto/YCM-Generator'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'dylanaraps/wal.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'rust-lang/rust.vim'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'airblade/vim-gitgutter'

call vundle#end()

filetype plugin indent on

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
	syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

set pastetoggle=<F3>

set noexpandtab
set tabstop=4
set shiftwidth=4

set laststatus=2
set showtabline=0

set t_Co=256
set encoding=utf-8
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}

endif

set guifont=Hack:13

let g:airline_symbols.space = "\ua0"

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline_solarized_bg='dark'

let g:ycm_show_diagnostics_ui = 1
let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.5.0/src'
set completeopt-=preview

" Bind nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

" Set ctags tagbar keybind
nmap <F8> :TagbarToggle<CR>

" Set auto brace indenting
set cindent
set cinoptions=g0
set cinkeys=0{,0},0),:,!^F,o,O,e

" Set keybind for autoformatting
nnoremap <C-F> :Autoformat markdown<CR>

" Make enter key accept autocompletion
let g:ycm_key_list_stop_completion = [ '<Enter>' ]

" Bind documentation for C family languages
nnoremap <C-Q> :YcmCompleter GetDoc<CR>

" Configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"let g:syntastic_c_checkers = ['g++']
"let g:syntastic_cpp_checkers = ['g++']
let g:syntastic_cpp_compiler_options = '--std=c++17'
nnoremap <F9> :SyntasticReset<CR>

" Add fzf to vim runtime
set rtp+=~/.fzf

" Set fzf binds
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

" Set syntastic checker for python
let g:syntastic_python_checkers = ['flake8']

" Disable latex recompile after cursor hold to reduce flickering
let g:livepreview_cursorhold_recompile = 0

" Configure vimtex for nvim
if has('nvim')
	let g:vimtex_compiler_progname = 'nvr'
endif

" Set colorscheme
colorscheme wal

" Configure clipboard support for nvim
set clipboard+=unnamedplus

" Configure fallback tex flavor
let g:tex_flavor = 'latex'
