"""""""""""""""""""""""""""""""
"           gvim              "
"""""""""""""""""""""""""""""""
colorscheme slate
if has ('gui_running')
    "set guifont=Noto\ Mono\ 12
    set guifont=Ubuntu\ Mono\ 14
endif

"""""""""""""""""""""""""""""""
"           VimWiki           "
"""""""""""""""""""""""""""""""
set nocompatible
filetype plugin on
syntax on

"""""""""""""""""""""""""""""""
"           Symbols           "
"""""""""""""""""""""""""""""""

" Operators
imap <C-l><C-e> ≤
imap <C-g><C-e> ≥
imap <C-a><C-e> ≅
imap <C-n><C-e> ≠
imap <C-c><C-b> ∈
imap <C-d><C-a> ≡
imap <C-e><C-x> ∃
imap <C-a><C-n> ∧
imap <C-o><C-r> ∨
imap <C-x><C-o> ⊕
imap <C-f><C-a> ∀
imap <C-s><C-b> ⊂
imap <C-o><C-u> ∪
imap <C-o><C-i> ∩

"Identifiers
imap <C-d><C-l> δ
imap <C-d><C-u> Δ
imap <C-r><C-l> ρ
imap <C-e><C-l> ε
imap <C-a><C-l> α
imap <C-b><C-l> β
imap <C-l><C-l> λ
imap <C-b><C-p> •


"""""""""""""""""""""""""""""""
"          Syntastic          "
"""""""""""""""""""""""""""""""
execute pathogen#infect()

let g:syntastic_python_checkers=['flake8']
set statusline=
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Scripting Vim in Python 

python3 << EOF
import vim
flake8_errors = [
	'E265', # Block comment should start with "# "
	'E501', # Line too long
	'E266', # Too many leading # for block comment
	'N801', # function name should be lowercase
	'N802',
	'N803', # function arg should be lowercase
	'N806', # variable in function should be lowercase
	'N813', # camelCase
    'E402', # module level import not at top of file
    'E241', # multiple spaces after ','
]

flake8_args_list = [
	'--max-line-length 79',
	'--ignore=' + ','.join(flake8_errors)
]

flake8_args = ' '.join(flake8_args_list)
vim.command('let g:syntastic_python_flake8_args = "%s"' % flake8_args)

EOF


"""""""""""""""""""""""""""""""
"          Functions          "
"""""""""""""""""""""""""""""""

" Normal StatusLine color
function! NormalStatusLineColor()
  " status line for ACTIVE view
  highlight statusline ctermbg=10 ctermfg=0 cterm=bold
  " status line for INACTIVE view
  highlight StatusLineNC ctermbg=8 ctermfg=10 cterm=bold
endfunction

" Change statusline color on insert, replace
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermbg=none ctermfg=6 cterm=bold
  elseif a:mode == 'r'
    hi statusline ctermbg=none ctermfg=1 cterm=bold
  endif
endfunction

"function! Dvorak()
"  let s:dvorak_mode = exists('s:dvorak_mode') ? !s:dvorak_mode : 1
"  if s:dvorak_mode
"      nnoremap d h
"      nnoremap 
"""""""""""""""""""""""""""""""
"          Behavior           "
"""""""""""""""""""""""""""""""
let mapleader=";"

set tabstop=4                       " Tab is width of four chars
set sw=4                            " Python indentation
set expandtab                       " Tab becomes spaces
set number                          " Line numbers
"set nonumber                        " Line numbers
set smartindent                     " Indents smartly
set showmatch                       " highlight matching brackets
set showcmd                         " Display # characters/lines in visual selection

" Folding
autocmd BufRead *.cpp :set fdm=syntax   " C/C++ folding
autocmd BufRead *.c :set fdm=syntax     " 
autocmd BufRead *.java :set fdm=syntax  " Java folding
autocmd BufRead *.py :set fdm=indent    " Python folding
autocmd BufRead *.wiki :set fdm=indent  " VimWiki folding
autocmd BufRead *.tex :set fdm=indent   " LaTeX folding

" Maximum text width coercion (for certain files) plus marker column 
"autocmd BufRead *.md  :set tw=79        " Auto-wrap text for Markdown,
autocmd BufRead *.tex :set tw=79        "  LaTex, and
autocmd BufRead *.txt :set tw=79        "  Text files
"autocmd BufRead *.wiki :set tw=79       "  vimwiki files
set colorcolumn=80

" Don't unindent on # (Useful for python programming)
inoremap # X#

" I never want to use a semicolon in normal mode unless it is used as Leader
nnoremap ; :



"""""""""""""""""""""""""""""""
"     General Apprearance     "
"""""""""""""""""""""""""""""""
hi linenr      ctermbg=none    ctermfg=7     " Line numbers
hi Visual      ctermbg=8       ctermfg=11    " Visual selection 
hi Folded      ctermbg=none    ctermfg=15    " Folds
hi ColorColumn ctermbg=8


"""""""""""""""""""""""""""""""
"          Interface          "
"""""""""""""""""""""""""""""""
set whichwrap=<,>,h,l           " Cursor wraps around
set hlsearch                    " hilight search results
set incsearch                   " hilight search results in realtime
set ignorecase                  " Ignore cases when searching
set smartcase                   " Don't ignore cases when capitalize

" Easy window navigation when using viewports
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
noremap <C-Tab> :<C-U>tabnext<CR>
noremap <C-S-Tab> :<C-U>tabprevious<CR>
" Construct vimwiki graph
nnoremap <leader>x :w<CR>:!python $HOME/code/vimwiki_link_network/vimwiki_link_network.py "%:p" --save<CR>

" Use \c to comile (in place file lives) and \v to view in mupdf
nnoremap <leader>c :w<CR>:!rubber --inplace --pdf --warn all %; git -C $(dirname %) commit -am "compiled with rubber"; git -C $(dirname %) push<CR>
nnoremap <leader>v :!mupdf %:r.pdf &<CR><CR>
"nnoremap <leader>v :!mupdf -C FFFFDA %:r.pdf &<CR><CR>

" Pressing \s toggles search highlighting
nnoremap <leader>s :set hlsearch! hlsearch?<CR>

" pressing CTRL-o or CTRL-SHIFT-o in regular mode adds newline
"nnoremap <CR> myo<Esc>`y
nnoremap <leader>j myo<Esc>`y
nnoremap <leader>k myO<Esc>`y

" A proxy for inter-window copy/pasting
vmap <leader>y :w! /tmp/vimtmp<CR>
nmap <leader>p :r! cat /tmp/vimtmp<CR>

nnoremap <leader>f :NERDTreeToggle<CR>

" Mouse scrollwheel
set mouse=a

" Wrap visually selected text with $
"vmap <leader>4 yb/<C-r>0<CR>i$<Esc>//e<C-r>0<CR>a$<Esc>
vmap <leader>4 "mdi$$<Esc>h"mp
vmap <leader>8 "mdi**<Esc>h"mp

" Wrap line and return to last point
nmap <leader>g mgJvgq`g
vnoremap <leader>g gq`g

" Vimwiki code block
imap {{{ {{{<Enter><Esc>i     <Esc>mbi<Enter>}}}<Esc><<`ba

nnoremap <leader>t :SyntasticToggleMode<CR>


"""""""""""""""""""""""""""""""
"         Status Line         "
"""""""""""""""""""""""""""""""

set laststatus=2                  " Show file name at bottom
set statusline+=%F                " Also show path in status line
set statusline+=%=                " right align
set statusline+=%10((%l,\ %c)%)   " Line, column
set statusline+=\ \-\-\           " Separator
set statusline+=%P                " Percent

call NormalStatusLineColor()

" Change statusline color on insert, replace
au InsertEnter * call InsertStatuslineColor(v:insertmode)

" Change back on return to normal
au InsertLeave * call NormalStatusLineColor()


