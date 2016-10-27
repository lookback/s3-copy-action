call pathogen#infect()          " Initialize pathogen

set nowrap
syntax enable
set background=dark

if has('gui_running')
    colorscheme solarized
else
    colorscheme desert
endif

set encoding=utf-8              " use utf-8 in Vim
set fileencodings=utf-8,latin1  " automatically detect utf-8 and latin1

set autoindent                  " automatically indent new lines...
set smartindent                 " ... and be clever about it
set expandtab                   " expand tabs to spaces...
set smarttab                    " ... even when indenting
set shiftwidth=2                " indent using 2 spaces...
set tabstop=2                   " ... because a tab is 2 spaces

set number                      " display line numbers
set ruler                       " display position of the cursor

"set paste                       "avoid weird tabbing when pasting (disabled to keep smartindent to work)

set ignorecase                  " ignore case when searching...
set smartcase                   " ... unless pattern contains uppercase characters
set incsearch                   " show match for partly typed search
set hlsearch                    " highlight matches
nnoremap <CR> :noh<CR><CR>      " remove last search highlighting by pressing enter
set mouse=a                     " enable mouse
set pastetoggle=<leader>p       " when we need to paste, use <leader>p before and after

set showcmd                     " show typed keys in the status line
set wildmenu                    " show match for partly typed commands in the command line
set title                       " let vim set the title of the window
let &titlestring = expand("%:n") . "%(\ %M%)" . " @ " . hostname()  " and modify it to include the host name
let mapleader=","

set iskeyword+=-                " include a dash for autocompletion so that border-box is considered one word
set relativenumber              " let line numbers be calculated from the cursor position

autocmd FileType html set shiftwidth=2 tabstop=2
autocmd FileType javascript set shiftwidth=2 tabstop=2
autocmd FileType less set shiftwidth=2 tabstop=2
filetype indent on

" make sure comments in python doesn't go to the beginning of line when trying to add them
" (http://stackoverflow.com/questions/2063175/vim-insert-mode-comments-go-to-start-of-line)
autocmd FileType python setl nosmartindent

filetype plugin indent on              " plugins are enabled
nmap gV `[v`]                   " Visually select the text that was last edited/pasted

au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.lessimport set filetype=less
au BufNewFile,BufRead *.mako set filetype=mako
au BufNewFile,BufRead *.ko set filetype=html
au BufNewFile,BufRead *.html set filetype=html.mustache

" Treat .ko as html
au BufReadPost *.ko set syntax=html

noremap <leader>c :checktime<cr>
" Automatically update the path of vim to the currently edited file
noremap <leader>d :cd %:p:h<CR>

""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
let g:CommandTMaxHeight=15
let g:CommandTAcceptSelectionSplitMap=['<C-CR>', '<C-g>']
noremap <leader>y :CommandTFlush<cr>

" A toggle to highlight 80 columns
nnoremap <silent> <Leader>l
      \ :if exists('w:long_line_match') <Bar>
      \   silent! call matchdelete(w:long_line_match) <Bar>
      \   unlet w:long_line_match <Bar>
      \ elseif &textwidth > 0 <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
      \ else <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>80v.\+', -1) <Bar>
      \ endif<CR>


" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Swap two windows keeping the same window layout
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" Automatically remove all trailing whitespace when saving a file
autocmd BufWritePre * :%s/\s\+$//e

" Faster window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" CodeKit compatibility
set nobackup
set nowritebackup
set noswapfile

" Faster pasting in insert mode (Ctrl+F)
inoremap <C-F> <C-R>"

" Macmeta mode for AutoPairs support (Alt becomes meta)
if has("gui_macvim")
    set macmeta
endif

""""""""""""""""""""""""""""""
" => Airline
""""""""""""""""""""""""""""""

" Make sure airline always runs
set laststatus=2

" Dont INSERT twice
set noshowmode

" We don't need to know file format and file type
let g:airline_section_x=""
let g:airline_section_y=""

" (Somewhat) less intrusive theme
let g:airline_theme='solarized'

" Bind leader e to open file in the current directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
"
" Bind leader e to open file in the current directory
nnoremap <Leader>x :Explore<CR>

" Bind ctrl-x to swap the current selection with the current paste buffer
:vnoremap <C-X> <Esc>`.``gvP``P`

" Easy motion

map <Leader> <Plug>(easymotion-prefix)

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Vim grep http://www.vim.org/scripts/script.php?script_id=311
:let Grep_Default_Filelist = '*.js *.html *.less *.coffee'

:let Grep_Skip_Dirs = '.meteor dump .build.* .build *node_modules*'

" For greplace
set grepprg=ack\ --nogroup\ --nocolor\ --ignore-dir=.meteor\ --ignore-dir=node_modules

" Syntastic https://github.com/scrooloose/syntastic/blob/master/doc/syntastic.txt
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_disabled_filetypes=['html']
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_loc_list_height=4
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" Use local eslint rather than global https://github.com/scrooloose/syntastic/issues/1692
let g:syntastic_javascript_eslint_exe = 'node_modules/.bin/eslint'

" vim-javascript
let g:javascript_plugin_jsdoc = 1

" init matchit
runtime! macros/matchit.vim
