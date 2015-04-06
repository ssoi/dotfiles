execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'

syntax on "enable highlighting and completion
filetype plugin indent on
set nocompatible	"prevents vim from emulating the original bugs
set smartindent	"guess the indent level 
set tabstop=2 "sets up 2-space tabs
set shiftwidth=2 "use 2 spaces when text is indented
set expandtab "replace tab with spaces when pressed
set showmatch "jump to a brace match when you type a closing/opening brace
set incsearch	"search for text as you enter it
set textwidth=100 "text wraps after 100 characters/line
set number "number each line
set mouse=a
set clipboard=unnamed "unnammed register copied to system clipboard

let g:solarized_termcolors=256
se t_Co=256
set background=dark
colorscheme solarized "third-party color scheme

hi Normal ctermbg=none "don't highlight when background transparent

map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
