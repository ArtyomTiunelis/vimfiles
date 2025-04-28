" Specify the directory for installed plugins
call plug#begin('~/vimfiles/plugin') 

" --- Plugins Go Here ---

Plug 'plasticboy/vim-markdown'

" vim-fugitive: Git integration
Plug 'tpope/vim-fugitive'

" vim-commentary: Easy commenting/uncommenting
Plug 'tpope/vim-commentary'

" vim-surround: Manipulate surrounding pairs
Plug 'tpope/vim-surround'

" fzf executable (needed for fzf.vim)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" fzf.vim plugin (Vim integration)
Plug 'junegunn/fzf.vim'

call plug#end() " This loads the plugins and sets up commands like :PlugInstall

" Set the leader key to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" --- General Settings ---
" Enable backspace
set backspace=indent,eol,start

" Ctrl + Backspace to delete a word in insert mode
inoremap <C-BS> <C-W>

" Block style cursor in normal mode
set guicursor=n:block

" Enable smart indentation
set smartindent

" Disable line wrapping
set nowrap

" Disable swap files
set noswapfile

" Disable backup files
set nobackup

" Set the directory for undo files (uses Vim's $HOME variable)
 set undodir=$USERPROFILE/vimfiles/undodir

" Enable persistent undo
set undofile

" Disable highlighting of search matches after search
set nohlsearch

" Enable incremental search (show matches as you type)
set incsearch

" Enable 24-bit color in the terminal (less relevant for gVim, but good practice)
set termguicolors

" Keep 8 lines of context above and below the cursor when scrolling
set scrolloff=8

" Set line numbers
set number 

" Always show the sign column (for git signs, linters, etc.)
set signcolumn=yes

" Add '@-@' to the list of characters considered part of a filename
set isfname+=@-@

" Decrease the time Vim waits before writing swap/undo files and triggering plugins
set updatetime=50

" Set tab to 4 spaces (from previous update)
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" --- Basic Built-in Statusline ---
" This configures Vim's default statusline
" Remove or comment out the 'Plug 'itchyny/lightline.vim'' line
" and the lightline.vim configuration block if you use this.
set laststatus=2

" Set colorscheme with fallback
" Try to set the preferred colorscheme 'rosepine'
try
    colorscheme rosepine
" If it fails (e.g., file not found), catch the error
catch /^Vim\%((\a\+)\)\=:E185/
    " Set a fallback colorscheme (e.g., 'default' or 'blue')
    colorscheme default
    " You could also echo a message if you want
    " echo "Colorscheme 'rosepine' not found, falling back to 'default'."
endtry

" Set gVim font with fallbacks
" List preferred fonts separated by commas. Vim will use the first one found.
" Ensure font names with spaces use underscores or are escaped.
set guifont=JetBrains_Mono:h12:cANSI:qDRAFT,Consolas:h12,Courier_New:h12

" Enable syntax highlighting
syntax enable

" Enable filetype detection, plugins, and indentation
filetype plugin indent on 

" --- Key Mappings ---
" Save file 
nmap <leader>w :w!<cr> 

" Map leader pv to the Ex command (file explorer)
nnoremap <leader>pv :Ex<CR>

" Source my vimrc
nnoremap <leader><leader> :so $MYVIMRC<CR>

" Move selected lines up/down in Visual mode
" :m '>+1 moves the selected lines down one position
" :m '<-2 moves the selected lines up one position
" <CR> executes the command
" gv re-selects the previously selected visual area
" = re-indents the selected area (useful after moving lines)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor centered when joining lines
" mz sets a mark at the current cursor position
" J joins the current and next line
" `z moves the cursor back to the mark 'z' (which is the line where J was used)
nnoremap J mzJ`z

" Keep cursor centered when scrolling down by half a page
" <C-d> scrolls down half a page
" zz centers the screen on the cursor
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor centered after finding the next match (n)
nnoremap n nzzzv
nnoremap N Nzzzv

" Re-indent the current paragraph and return cursor to original position
" ma sets a mark 'a' at the start
" =ap re-indents the 'ap' (around paragraph) text object
" 'a returns the cursor to mark 'a'
nnoremap =ap ma=ap'a

" Greatest remap ever: Paste over visual selection without yanking it
" x is for Visual mode (characterwise, linewise, blockwise)
" <leader>p is the mapped key sequence
" " serves as a prefix to specify a register
" _ is the black hole register (text put here is discarded)
" d deletes the visual selection into the black hole register
" P pastes the contents of the unnamed register (which held the original text before d)
xnoremap <leader>pp "_dP

" Next greatest remap ever: Yank to system clipboard
" { "n", "v" } means Normal and Visual modes
" <leader>y is the mapped key sequence
" " specifies a register
" + is the system clipboard register on Windows/X11
" y is the yank (copy) operation
nnoremap <leader>pp "+p
nnoremap <leader>yy "+y
vnoremap <leader>yy "+y

" Delete to black hole register (don't overwrite unnamed register)
" { "n", "v" } means Normal and Visual modes
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Navigate to the next quickfix list item and center the screen
" n is for Normal mode
" <C-k> is the key combination
" <cmd>cnext<CR> goes to the next item in the quickfix list
" zz centers the screen
nnoremap <C-k> <cmd>cnext<CR>zz

" Navigate to the previous quickfix list item and center the screen
" n is for Normal mode
" <C-j> is the key combination
" <cmd>cprev<CR> goes to the previous item in the quickfix list
" zz centers the screen
nnoremap <C-j> <cmd>cprev<CR>zz

" Navigate to the next location list item and center the screen
" n is for Normal mode
" <leader>k is the key sequence
" <cmd>lnext<CR> goes to the next item in the location list
" zz centers the screen
nnoremap <leader>k <cmd>lnext<CR>zz

" Navigate to the previous location list item and center the screen
" n is for Normal mode
" <leader>j is the key sequence
" <cmd>lprev<CR> goes to the previous item in the location list
" zz centers the screen
nnoremap <leader>j <cmd>lprev<CR>zz

" Smart find and replace for the word under the cursor
" n is for Normal mode
" <leader>s is the key sequence
" :%s/ starts a substitute command over the whole file (%)
" /\<C-r><C-w>\>/ inserts the word under the cursor (<C-r><C-w>) between word boundaries (\<\>)
" /<C-r><C-w>/gI inserts the word again, followed by /g (global) and I (case-insensitive) flags
" <Left><Left><Left> moves the cursor back to the replacement pattern to allow editing
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Move cursor to the next paragraph and center screen
nnoremap { {zz
" Move cursor to the previous paragraph and center screen
nnoremap } }zz

nnoremap Q @q 

" --- Plugin fmappings ---

" fzf.vim mappings
" Layout settings
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'y': 0.1, 'x': 0.1, 'border': 'sharp' } }

" search [p]roject [f]iles
nnoremap <leader>pf :Files<CR>

" search [b]uffers
nnoremap <leader>b :Buffers<CR>     

" [g]rep search
nnoremap <leader>g :Rg<SPACE> 

" search current [l]ines
nnoremap <leader>l :Lines<CR>

" search [h]istory
nnoremap <leader>h :History<CR>
