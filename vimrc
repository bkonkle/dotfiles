""
"" Brandon's .vimrc
""

if has('vim_starting') && !has('nvim') && &compatible
  set nocompatible                " Be iMproved
endif

set number                        " Line numbers
set ruler                         " Line and column number
set hidden                        " Hidden buffers
syntax enable                     " Syntax highlighting and local overrides

" Neovim disallow changing 'encoding' option after initialization
" see https://github.com/neovim/neovim/pull/2929 for more details
if !has('nvim')
  set encoding=utf-8              " Set default encoding to UTF-8
endif

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen
""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Backup and Swap files
""

set backupdir^=~/.vim/_backup//
set directory^=~/.vim/_temp//
set term=screen-256color

""
"" Plugins
""

" Auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'kien/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'sbdchd/neoformat'
Plug 'pangloss/vim-javascript'

call plug#end()

""
"" Wild settings
""

" Disable output and VCS files
set wildignore=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Ignore node modules and build folders
set wildignore+=*/node_modules/*,*/build/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Everything else
""

" Add a shortcut for ctrlp
let g:ctrlp_map = '<c-\>'

" Enable jsdoc and Flow highlighting
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" Tell neoformat to use the formatprg
let g:neoformat_try_formatprg = 1

" Set the JavaScript formatter
autocmd FileType javascript set formatprg=npx\ prettier-eslint\ --stdin

" Format on save
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Read in stdin
autocmd StdinReadPre * let s:std_in=1

" Open NERDTree if started with no arguments
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree if started with a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Open NERDTree with ctrl+n
map <C-n> :NERDTreeToggle<CR>