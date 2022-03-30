set nocompatible
filetype off
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if v:version < 800
    echo "Update vim!"
endif

let mapleader = ','
let maplocalleader = ','

call plug#begin('~/.vim/plugged')
	Plug 'abaldwin88/roamer.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'tomtom/tcomment_vim' " gc{motion}, gcc
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'christoomey/vim-sort-motion'
    Plug 'vim-scripts/vis'
	Plug 'Raimondi/delimitMate'
	Plug 'kien/ctrlp.vim'
    Plug 'vim-latex/vim-latex'
    Plug 'PeterRincker/vim-argumentative'
    Plug 'w0rp/ale'
	Plug 'easymotion/vim-easymotion' " <leader><leader>w
    " Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
    " Plug 'stevearc/vim-arduino'
    " Plug 'sudar/vim-arduino-syntax'
	Plug 'ajh17/VimCompletesMe'
	Plug 'airblade/vim-gitgutter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'altercation/vim-colors-solarized'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'wellle/targets.vim' " din(, da,
    Plug 'skywind3000/asyncrun.vim'
    Plug 'pedsm/sprint' " :Sprint (in an executable file)
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'alvan/vim-closetag'
    Plug 'chrisbra/Colorizer'
    Plug 'vim-ruby/vim-ruby'
    Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-surround' " cs{CurrentSymbol}{DesiredSymbol}
    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-endwise'
    Plug 'ervandew/supertab'
  Plug 'martinda/Jenkinsfile-vim-syntax'
  Plug 'udalov/kotlin-vim'
    " Plug 'sudar/vim-arduino-snippets'
    " Plug 'honza/vim-snippets'
    " Plug 'SirVer/ultisnips'
filetype plugin indent on
call plug#end()"

let g:airline_symbols = {}
let g:airline_left_sep           = '▶'
let g:airline_right_sep          = '◀'
let g:airline_symbols.branch     = '⎇ '
let g:airline_symbols.spell      = 'Spellchecker'
let g:airline_theme              = 'dark'
set laststatus=2
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
set t_Co=256
set updatetime=250 " GitGutter
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
nnoremap <c-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" function! MyStatusLine()
"     let port = arduino#GetPort()
"     let line = '%f [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
"     if !empty(port)
"         let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
"     endif
"     return line
" endfunction
setl statusline=%!MyStatusLine()
let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
nnoremap ]e :lnext<CR>
nnoremap [e :lprev<CR>
autocmd FileType vim let b:vcm_tab_complete = 'vim'
nmap [; <Plug>Argumentative_Prev
nmap ]; <Plug>Argumentative_Next
xmap [; <Plug>Argumentative_XPrev
xmap ]; <Plug>Argumentative_XNext
nmap <; <Plug>Argumentative_MoveLeft
nmap >; <Plug>Argumentative_MoveRight
xmap i; <Plug>Argumentative_InnerTextObject
xmap a; <Plug>Argumentative_OuterTextObject
omap i; <Plug>Argumentative_OpPendingInnerTextObject
omap a; <Plug>Argumentative_OpPendingOuterTextObjectnmap [; <Plug>Argumentative_Prev
nmap ]; <Plug>Argumentative_Next
xmap [; <Plug>Argumentative_XPrev
xmap ]; <Plug>Argumentative_XNext
nmap <; <Plug>Argumentative_MoveLeft
nmap >; <Plug>Argumentative_MoveRight
xmap i; <Plug>Argumentative_InnerTextObject
xmap a; <Plug>Argumentative_OuterTextObject
omap i; <Plug>Argumentative_OpPendingInnerTextObject
omap a; <Plug>Argumentative_OpPendingOuterTextObject

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" nnoremap <leader>ac :ArduinoVerify<CR>
" nnoremap <leader>au :ArduinoUpload<CR>
" nnoremap <leader>as :ArduinoSerial<CR>
" nnoremap <leader>ad :ArduinoUploadAndSerial<CR>
" nnoremap <leader>ab :ArduinoChooseBoard<CR>
" nnoremap <leader>ap :ArduinoChooseProgrammer<CR>

nnoremap <leader>c :ColorToggle<CR>
autocmd VimEnter * ColorToggle

autocmd InsertEnter * set norelativenumber 
autocmd InsertLeave * set relativenumber

au BufNewFile,BufRead *.tex
    \ set nocursorline |
    \ set nonu |
    \ set nornu |
    \ let g:loaded_matchparen=1 |

set relativenumber
set number
silent !mkdir ~/.vim/tmp > /dev/null 2>&1
set directory=$HOME/.vim/tmp//
set undodir=$HOME/.vim/tmp//
set undofile
set autoindent
set autowrite
set pastetoggle=<F2>
set ignorecase
set smartcase
:autocmd Filetype java set softtabstop=4 shiftwidth=4 tabstop=4
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set gdefault
set incsearch
set showmatch
set showcmd
set hlsearch
set textwidth=120
set wrapmargin=2
set formatoptions=qrn1
set colorcolumn=120
set scrolloff=1
set splitright
set cursorline
set wrap
set linebreak
set spell spelllang=en_us
set backspace=indent,eol,start

inoremap jj <esc>
inoremap ww <esc>:w<cr>
inoremap <C-T> <C-R>=strftime("%m-%d (%a %b %Y)") . ":"<CR>

vnoremap <tab> %
vnoremap ; :
vnoremap : ;
vnoremap q; q:
vnoremap q: q;

nnoremap s :w<cr>
nnoremap ; :
nnoremap : ;
nnoremap q; q:
nnoremap q: q;
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <tab> %
nnoremap j gj
nnoremap k gk
nnoremap <leader><space> :noh<cr>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-T> "=strftime("%m-%d (%a %b %Y)") . ":"<CR>P
nnoremap <F11> :!./%<enter>
nnoremap ^] <Nop>

cmap w!! w !sudo tee > /dev/null %
