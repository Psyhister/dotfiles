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
autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile *.rs set filetype=rust
autocmd BufRead,BufNewFile *.cpp,*.cxx,*.h,*.hpp,*hxx set filetype=cpp

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
map <C-n> :NERDTreeToggle<CR>

set noswapfile
set backupdir=$HOME/.vim/backupdir//
if exists('+undodir')
	set undodir=$HOME/.vim/undodir
	set undofile
endif
