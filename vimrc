""" ~/.vimrc

"" default stuff


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir=~/.vim/backups
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" set swap directory
set directory=~/.vim/tmp

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


"" my custom stuff:

filetype plugin on

" ensure proper runtime
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" set tab size to four spaces
set tabstop=4
set shiftwidth=4

" use spellcheck
set spell

" use hybrid line numbers
set number relativenumber
set nu rnu

" autostart nerdtree if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" use system clipboard
set clipboard=unnamedplus
" use Shift+P to paste from xclip
map <S-P> :r!xclip -o<CR>

" syntax highlighting
syntax on

" automatic line breaking
set linebreak

" let cursor go from beginning of one line to end of previous
set whichwrap=b,s,<,>,[,]

" add latex suite
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex - interaction nonstopmode $*'

" enable table mode by default
" set g:TableModeEnable

" map ctrl+backspace to delete previous word
inoremap <C-H> <C-W>

" add powerline support
let g:powerline_pycmd="py3"
set laststatus=2
set rtp+=/usr/lib/python3.7/site-packages/powerline/bindings/vim

" enable table mode by default
" TableModeEnable

" map scrolling to undo and redo a la xkcd 1806
"set mouse=a
"map <ScrollWheelUp> <C-r>
"map <ScrollWheelDown> u

" for use as system-wide pager
let $PAGER=''

" add fzf integrations

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
