set nocompatible

set shell=/bin/bash\ -i

set shortmess+=|
set mouse=a
set hlsearch
set incsearch
set bg=light

set t_Co=256

set noerrorbells 
set visualbell

set tabstop=2
set shiftwidth=2
set smarttab
set smartindent
set expandtab

set laststatus=2
set encoding=utf-8
set noautoread
  
set autoindent
filetype on
filetype plugin on
filetype indent on
set fileformat=unix
set fileformats=unix,dos
set ignorecase
set smartcase
set textwidth=0
set nowrap
set number
set scrolljump=1
set path=.,,**

set scrolloff=0
set backspace=indent,eol,start
set complete-=k complete+=k

set showmode    "show current mode down the bottom
set showcmd     "show incomplete cmds down the bottom
set ruler
set showmatch
syntax on
set background=light

set nocursorcolumn
set cursorline
set norelativenumber
syntax sync minlines=256

set nofoldenable
"set foldenable=0
"set foldmethod=syntax
"set foldcolumn=2
"set foldlevel=1
"let php_folding=1
"set foldopen=all 
"set rnu

set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

let g:netrw_list_hide='^\.\/$,\.swp$,\.bak$,\.\.,\~'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

au BufRead,BufNewFile *.ts set filetype=typescript

set wildmenu
set wildmode=full
set wildignorecase
set pastetoggle=<F2>

map <cr> i<cr><esc>
map Q :w<cr>

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv
 
" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

highlight MatchParen ctermbg=blue guibg=lightyellow
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'w')?('W'):('w'))
cnoreabbrev <expr> TABP ((getcmdtype() is# ':' && getcmdline() is# 'tabp')?('TABP'):('tabp'))
cnoreabbrev <expr> TABN ((getcmdtype() is# ':' && getcmdline() is# 'tabn')?('TABN'):('tabn'))
cnoreabbrev <expr> TABR ((getcmdtype() is# ':' && getcmdline() is# 'tabr')?('TABR'):('tabr'))
cnoreabbrev <expr> TABL ((getcmdtype() is# ':' && getcmdline() is# 'tabl')?('TABL'):('tabl'))
cnoreabbrev <expr> TABE ((getcmdtype() is# ':' && getcmdline() is# 'tabe')?('TABE'):('tabe'))

hi PComment guifg=#5f5fff guisp=none ctermfg=117 ctermbg=none
hi! link perlComment PComment

hi PFunction guisp=none ctermfg=30 ctermbg=none cterm=bold
hi! link perlSubName PFunction

hi DiffChange ctermbg=LightMagenta	guibg=LightMagenta
hi DiffText ctermbg=Magenta	guibg=Magenta
hi String ctermfg=Blue
hi Comment ctermfg=Gray

inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <F4> :tabs<CR>:tabn<Space>

function MyTabLine()
    let tabline = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let tabline .= '%#TabLineSel#'
        else
            let tabline .= '%#TabLine#'
        endif
        let tabline .= '%' . (i + 1) . 'T'
        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor
    let tabline .= '%#TabLineFill#%T'
    if tabpagenr('$') > 1
        let tabline .= '%=%#TabLine#%999XX'
    endif
    return tabline
endfunction
function MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)
    let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')
    if label == ''
        let label = '[No Name]'
    endif
    let label .= ' (' . a:n . ')'
    for i in range(len(buflist))
        if getbufvar(buflist[i], "&modified")
            let label = '[+] ' . label
            break
        endif
    endfor
    return label
endfunction
function MyGuiTabLabel()
    return '%{MyTabLabel(' . tabpagenr() . ')}'
endfunction
set tabline=%!MyTabLine()
set guitablabel=%!MyGuiTabLabel()

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

function! s:Highlight_Matching_Pair()
endfunction

function! TabCloseRight(bang)
    let cur=tabpagenr()
    while cur < tabpagenr('$')
        exe 'tabclose' . a:bang . ' ' . (cur + 1)
    endwhile
endfunction

function! TabCloseLeft(bang)
    while tabpagenr() > 1
        exe 'tabclose' . a:bang . ' 1'
    endwhile
endfunction

command! -bang Tabcloseright call TabCloseRight('<bang>')
command! -bang Tabcloseleft call TabCloseLeft('<bang>')
