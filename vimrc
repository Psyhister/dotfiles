" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Enabling Plug plugins
source $HOME/.vim/plug.vim

" ------------------------------------------------------------------------
"    Base Options                                                           
" ------------------------------------------------------------------------
set encoding=utf-8            "utf-8 encoding is essential
set nohidden                  "Doesn't allow buffers to exist in the background
set ttyfast                   "Indicates fast terminal connection
set shortmess+=I              "No welcome screen
set secure                    "Disable unsafe commands in local .vimrc files

" ------------------------------------------------------------------------
"    Visual
" ------------------------------------------------------------------------
set showcmd                   " Show command in the last line of the screen
set wildmenu                  " Command completion
set wildmode=list:longest     " List all matches and complete till longest common string

if exists("&wildignorecase")
	set wildignorecase
endif

" Buffer Area Visuals
set scrolloff=7               " Minimal number of screen lines to keep above and below the cursor
set visualbell                " Use visual bell
set cursorline                " Highlight the current line
set number                    " Show line numbers
set wrap                      " Soft wrap at the window width
set linebreak                 " Break the line on words
set textwidth=79              " Break lines at just under 80 characters
if exists('+colorcolumn')
	set colorcolumn=+1    " Highlight the column after `textwidth`
endif

set listchars=tab:▸\ ,trail:•
set list

" Character meaning when present in 'formatoptions'
" ------ ---------------------------------------
" c Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" q Allow formatting of comments with "gq".
" r Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" t Auto-wrap text using textwidth (does not apply to comments)
" n Recognize numbered lists
" 1 Don't break line after one-letter words
" a Automatically format paragraphs
set formatoptions=cqrn1

syntax enable
set t_Co=256
colorscheme molokai

" Auto detect filetype
augroup FileType
	autocmd!
	autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
	autocmd BufRead,BufNewFile *.rs set filetype=rust
	autocmd BufRead,BufNewFile *.cpp,*.cxx,*.h,*.hpp,*hxx set filetype=cpp
augroup END

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Indentic
let g:indent_guides_auto_colors = 0
augroup Identic
	autocmd!
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=darkgrey ctermbg=darkgrey
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=darkgrey
	autocmd VimEnter * :IndentGuidesEnable
augroup END
" Syntasic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let syntastic_check_on_wq = 0

" Enable all checkers on same file
let g:syntastic_aggregate_errors = 1

" Enable syntax checkers
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_cpp_checkers = ['cppcheck', 'gcc', 'make']
let g:syntastic_markdown_checkers = ['mdl']
let g:syntastic_text_checkers = ['language_check', 'atdtool']

let g:syntastic_cpp_compiler = 'clang++' " C++ compiler
let g:syntastic_cpp_compiler_option = ' -std=c++11 -stdlib=libc++' " C++11 support
let g:syntastic_cpp_compiler_options = ' -std=c++1y' " C++14 support

" Airline UI
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'

" Separators
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = '▶'
let g:airline#extensions#tabline#right_sep = '◀'
let g:airline#extensions#tabline#right_alt_sep = '◀'
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '◀'

function! AirlineInit()
	let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
	let g:airline_section_b = airline#section#create_left(['%F'])
	let g:airline_section_c = airline#section#create(['ffenc', ' ', '[%Y]'])
	let g:airline_section_x = airline#section#create(['%P'])
	let g:airline_section_y = airline#section#create(['row:%l/%L ','(%03p%%)'])
	let g:airline_section_z = airline#section#create_right(['col:%03c'])
endfunction
augroup Airline
	autocmd!
	autocmd VimEnter * call AirlineInit()
augroup END

" Typo fix
command! Q q
command! W w

" No arrows for you
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l
nnoremap <up> <C-w>k
nnoremap <down> <C-w>j
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Navigate using displayed lines not actual lines
nnoremap j gj
nnoremap k gk

" NERDTree
augroup NERDTreeCMD
	autocmd!
	autocmd vimenter * NERDTree
	autocmd StdinReadPre * let s:std_in = 1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTRee | endif
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END
map <C-n> :NERDTreeToggle<CR>

" vim-markdown
augroup VIMMarkdown
	autocmd!
	autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

set noswapfile
set backupdir=$HOME/.vim/backupdir//
if exists('+undodir')
	set undodir=$HOME/.vim/undodir
	set undofile
endif
