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
call pathogen#infect()          " Initialize pathogen

au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.lessimport set filetype=less
au BufNewFile,BufRead *.mako set filetype=mako
au BufNewFile,BufRead *.ko set filetype=html

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

" Macmeta mode for AutoPairs support (Alt becomes meta)
if has("gui_macvim")
    set macmeta
endif

" CodeKit compatibility
set nobackup
set nowritebackup
set noswapfile

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
