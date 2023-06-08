### ### ### ### ### ### ### vim configuration (for usage as ~/.vimrc and /root/.vimrc)

syntax on
set clipboard=autoselect	" use X PRIMARY selection
set noswapfile			" disable swap file
set shortmess+=I		" disable intro message
set timeoutlen=333		" shorter delay after Esc key press
set history=999			" set number of lines of vim command history
set laststatus=2		" always show status line
set autochdir			" working dir is always the same as the file
set ignorecase			" ignore case when search
set smartcase			" ignore case only when lack uppercase
set hlsearch			" highlight search
set incsearch			" search while typing
set wildmenu			" show command predictions
set ttyfast			" faster scrolling
set mouse=a			" enable mouse support
set ttymouse=sgr		" available values: xterm, xterm2, netterm, dec, jsbterm, pterm
set backspace=2			" disable vi backspace behavior
set autoindent			" copy indent from current line when starting a new line
set ruler			" show cursor position
set formatoptions-=cro		" disable auto comment insertion
set scrolloff=3			" lines before and after cursor when search
set pastetoggle=<F2>		" toggle paste mode
set t_Co=256			" force to use 256 colors
"set t_ti= t_te=		" disable screen buffer
set noeb vb t_vb=		" disable beeping
set fillchars=stlnc:-,vert:\│	" split border and inactive statusline chars
set whichwrap+=<,>,[,]		" change lines with left/right arrow on start/end of line
"set list			" display TABs
set listchars=tab:+-		" characters to be used to show TABs
set title			" enable titles
set titlestring=%M%f\ -\ VIM\ -\ %P " vim titles format
if $USER == "root"
    set statusline=%2*ROOT\#%3*\ %y\ %1*%F%2*%m%3*\ %{&fileencoding?&fileencoding:&encoding}\ %=%1*%l%3*\ %L,%v\ %1*%P%*
else
    set statusline=%{$USER}\$%3*\ %y\ %1*%F%2*%m%3*\ %{&fileencoding?&fileencoding:&encoding}\ %=%1*%l%3*\ %L,%v\ %1*%P%*
endif
colorscheme desert

" change some colors
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi User1 ctermbg=NONE ctermfg=white cterm=bold,underline
hi User2 ctermbg=NONE ctermfg=red cterm=bold
hi User3 ctermbg=NONE ctermfg=gray cterm=underline
hi TabLine ctermfg=gray ctermbg=black cterm=NONE
hi TabLineSel ctermfg=white ctermbg=black cterm=bold
hi TabLineFill ctermfg=black ctermbg=black cterm=underline
hi StatusLine ctermbg=NONE ctermfg=white cterm=bold
hi StatusLineNC ctermbg=NONE ctermfg=gray cterm=NONE
hi Visual ctermfg=NONE ctermbg=black cterm=bold,standout
hi VertSplit ctermfg=white ctermbg=NONE cterm=underline

" COMMANDS                      MODES
":map     :noremap  :unmap     Normal, Visual, Select, Operator-pending
":nm[ap]  :nnoremap :nunmap    Normal
":vm[ap]  :vnoremap :vunmap    Visual and Select
":sm[ap]  :snoremap :sunmap    Select
":xm[ap]  :xnoremap :xunmap    Visual
":om[ap]  :onoremap :ounmap    Operator-pending
":map!    :noremap! :unmap!    Insert and Command-line
":im[ap]  :inoremap :iunmap    Insert
":lm[ap]  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
":cm[ap]  :cnoremap :cunmap    Command-line
command! W w
command! Q q
" alt+backspace
map <Esc><BS> dvb
im <Esc><BS> <C-w>
map <M-BS> dvb
im <M-BS> <C-W>
" alt+delete
nm <Esc>[3;3~ de
im <Esc>[3;3~ <C-o>de
" alt+z/shift+alt+z - undo/redo in insert mode
im <Esc>z <C-o>:undo<CR>
im <Esc>Z <C-o>:redo<CR>
" r -redo
nm r <C-r>
" p - replace selected
vm p pgvy
" space - clear search highlight
nm <silent> <Space> :nohlsearch<Bar>:echo<CR>
" ctrl+t - new tab in normal/visual/insert mode
map <C-t> :tabnew<CR>
" ctrl+c - close tab in normal mode
nm <C-c> :quit<CR>
" ctrl+w - write file in normal mode
nm <C-w> :write!<CR>
" ctrl+q - close session in normal mode
nm <C-q> :conf qa<CR>
" unmap shift+q in normal mode
nm Q <Nop>
" ctrl+u - update file in normal mode
nm <C-u> :edit!<CR>
" alt+c - yank selected to clipboard
vm <Esc>c "+y
vm <M-c> "+y
" alt+x - cut selected to clipboard
vm <Esc>x "+x
vm <M-x> "+x
" ctrl+v - paste from clipboard in visual/insert/normal mode
vm <C-v> "+gp
map! <C-v> <C-R>+
" ctrl+d - remove all letters or spaces near cursor
im <C-d> <C-o>ciW
nm <C-d> ciW
" ctrl+f - number of search matches
nm <C-f> :%s///gn<CR>
" ctrl+n to show/hide line numbers
nm <C-n> :set invnumber<CR>
" ctrl+l show/hide TAB characters
nm <C-l> :set list!<CR>
" ctrl+alt+w - write file with sudo
nm <Esc><C-w> :silent write !sudo tee %<CR>
" ctrl+up/down - home/end
nm <C-up> 0
nm <C-down> $
im <C-up> <C-o>0
im <C-down> <C-o>$
" alt+up/down - delete all text before/after cursor
nm <M-up> v0d
nm <M-down> d$
im <M-up> <C-o>d0
im <M-down> <C-o>d$
" alt+left/right - delete left/right word
nm <M-left> dvb
nm <M-right> de
im <M-left> <C-w>
im <M-right> <C-o>de
" ctrl+alt+up/down - remove/duplicate line
nm <C-M-up> yyp
nm <C-M-down> dd
im <C-M-up> <Esc>yyp
im <C-M-down> <Esc>dd
" ctrl+alt+left/right - backward/forward word in insert  mode
im <C-M-left> <C-o>B
im <C-M-right> <C-o>W
" add tabs to selected text
vmap <Tab> >gv
vmap <S-Tab> <gv
" up/down using same line if long
nm <Up> gk
nm <Down> gj
im <Up> <C-o>gk
im <Down> <C-o>gj
" F3/F4 - split vertically/horizontally
nm <F3> :vsplit<CR>
nm <F4> :split<CR>

" Auto paste mode when insert
if exists('$DISPLAY')
	let &t_SI .= "\<Esc>[?2004h"
	let &t_EI .= "\<Esc>[?2004l"
	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
	function! XTermPasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
	endfunction
endif

" check file changes every 4s and update file if it was changed
set autoread | au CursorHold * checktime | call feedkeys("lh")

" restore last cursor position on start
if has('autocmd')
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

