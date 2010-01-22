" linux
syntax on
" enable filetype detection and plugin loading
filetype plugin on
if has('gui_running')
  set guifont=Courier\ 10\ pitch\ 8
  set guitablabel=%t " only display the filename not the path
  set guioptions-=T "remove toolbar
  set autochdir
<<<<<<< HEAD:.vimrc
  set lines=60
  set columns=200
  let g:SuperTabMappingForward = '<c-space>'
  let g:SuperTabMappingBackward = '<s-c-space>'
endif
=======
endif
let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabLongestHighlight = 1
let g:SuperTabDefaultCompletionType = 'context'
syntax on
" enable filetype detection and plugin loading
filetype plugin on
>>>>>>> added missing plugins from mac:_vimrc_universal
colorscheme delek
set completeopt=longest,menuone,preview
set wildmode=longest:full " bash like filename completion
set wildmenu " show possible completions for filenames
set nocompatible
set backspace=indent,eol,start
set hlsearch
set incsearch
set hidden
set noswapfile " disable swapfiles
set ignorecase
set number
set smartcase
set scrolloff=1
set dictionary+=/usr/share/dict/words
set history=1000	          "keep 1000 lines of command line history
set ruler		                "show the cursor position all the time
set showcmd
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent
set vb                      "visual beep
set autoread                "reload file if permissions change due to BufWritePost below
set autowrite               "write file to disk on :make, :!, :first, :next

:noremap <A-j> gT 
:map <A-k> gt
:noremap <A-Left> gT
:noremap <A-Right> gt
imap <C-Tab> <Esc> :bn<CR>
map <C-Tab> :bn<CR>
imap <C-S-Tab> <Esc> :bp<CR>
map <C-S-Tab> :bp<CR>
imap <C-S-Tab> <Esc> :bp<CR>

noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

" moving lines
nnoremap <M-j> mz:m+<CR>`z==
nnoremap <M-k> mz:m-2<CR>`z==
inoremap <M-j> <Esc>:m+<CR>==gi
inoremap <M-k> <Esc>:m-2<CR>==gi
vnoremap <M-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

" au CursorMoved * exec 'match MyGroup /\<'.expand('<cword>').'\>/'
highlight MyGroup ctermbg=green guibg=green
" Make ',e' (in normal mode) give a prompt for opening files
" in the same dir as the current buffer's file.
if has("unix")
  map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
  map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

" plugin specific config
let macvim_hig_shift_movement = 1
let MRU_Max_Entries = 60 
let MRU_Window_Height = 25 
" haskell syntax config
let hs_highlight_delimiters = 1 " Highlight delimiter characters
let hs_highlight_boolean = 1 " Treat True and False as keywords.
let hs_highlight_types = 1 " Treat names of primitive types as keywords.
let hs_highlight_more_types = 1 " Treat names of other common types as keywords.
" hs_highlight_debug - Highlight names of debugging functions.
let g:utl_cfg_hdl_mt_application_pdf = ':silent !gnome-open %p &'
let g:utl_opt_verbose=1	" Switched on

" leo search of current word
nmap ,l :exe ":Utl ol http://dict.leo.org/?search=" . expand("<cword>")<CR>

"Vertical split then hop to new buffer
:noremap ,v :vsp<CR>^W^W<CR>
:noremap ,h :split<CR>^W^W<CR>
"Make current window the only one
:noremap ,O :only<CR>:tabo<CR>
:noremap ,o :only<CR>
"Buffer next,previous (ctrl-{n,p})
:noremap ^N :bn<CR>
:noremap ^P :bp<CR>
"Buffer delete (ctrl-c)
:noremap ^C :bd<CR>

"mapping of F-*
imap <F1> <esc>:BufExplorer<CR>
map <F1> :BufExplorer<CR>
map <S-F1> :FufBuffer<CR>
map <F2> :FufDir<CR>
map <S-F2> :FufFile<CR>
imap <F3> <Esc><c-]><CR>
map <F3> <c-]><CR>
nmap <F4> :call ToggleSpell()<CR>
imap <F4> <Esc>:call ToggleSpell()<CR>a
map <F5> :call OpenInGhci()<CR><CR>
" Prepare a :substitute command using the current word or the selected text:
vnoremap <F6> y:%s/\<<C-r>"\>//gc<Left><Left><Left>
nmap <F6> y:%s/\<<C-r>=expand("<cword>")<CR>\>//gc<Left><Left><Left>
map <F7> :!gnome-terminal --profile=light --geometry=160x50 %<CR>
" map <F7> :mksession! ~/vim_session <cr> " Quick write session 
" map <S-F7> :source ~/vim_session <cr>   " And load session 
nnoremap <F8> :grep <C-R><C-W> *<CR> " search for the keyword under the cursor in the current directory using the 'grep' command

vmap // y/<C-R>"<CR> " search for visually highlighted text
" use ghc functionality for haskell files
au BufEnter *.hs compiler ghc
:let g:ghc="/usr/bin/ghc"
function! GhciMake()
   cd %:h
   set makeprg=ghci\ %
   make
endfunction
function! OpenInGhci()
  !gnome-terminal --profile=small --geometry=160x50 -e "ghci %"
endfunction
let g:haddock_browser = "/usr/bin/firefox"
let g:haddock_browser_callformat = "%s --new-tab file://%s &"

" Spell check
function! ToggleSpell()
    if !exists("b:spell")
        setlocal spell spelllang=en_us
        let b:spell = 1
    else
        setlocal nospell
        unlet b:spell
    endif
endfunction

function! RakeCommand(command)
  cexpr system("rake " . a:command)
  cw " show quickfix window already
endfunction
command! -nargs=+ -complete=file Rake call RakeCommand(<q-args>)
function! AckGrep(command)
  cexpr system("ack-grep " . a:command)
  cw " show quickfix window already
endfunction
command! -nargs=+ -complete=file Ack call AckGrep(<q-args>)
map <leader>a :Ack<space>
map <leader>r :Rake<space>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR><C-W><C-W><CR>
map <leader>f :execute 'NERDTreeFind'<CR> 
map <leader>m :execute 'make'<CR>

" create html from text
function! Text2html()
  runtime! syntax/2html.vim :convert txt to html
endfunction 
command! Txt2html :call Text2html()

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions"
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions"
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction
au VimEnter * :call LoadSession()
au VimLeave * :call MakeSession()
augroup mkd
  autocmd BufRead *.mkd,*.md  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

