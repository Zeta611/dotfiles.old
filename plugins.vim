" =========================================================================== "
call plug#begin('~/.local/share/nvim/plugged')

" Custom keymaps
" better dot repeat
Plug 'tpope/vim-repeat'
" faster motion
Plug 'easymotion/vim-easymotion'
" easily delete, change, and add surroundings.
Plug 'tpope/vim-surround'
" smooth scroll
Plug 'psliwka/vim-smoothie'
" commenter
Plug 'scrooloose/nerdcommenter'
" multiple cursors for vim
Plug 'terryma/vim-multiple-cursors'
" Swap two splits
Plug 'wesQ3/vim-windowswap'
" seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'


" Lint & autocomplete
" LSP support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" snippets
Plug 'honza/vim-snippets'


" Customizations for specific langauges/applications
" C/C++/Cuda/ObjC
Plug 'jackguo380/vim-lsp-cxx-highlight'
" (La)TeX
" LaTeX with vim
Plug 'lervag/vimtex'
" Swift
Plug 'keith/swift.vim'
" JavaScript
" javascript refactor
Plug 'maksimr/vim-jsbeautify'
" emmet abbreviation
Plug 'mattn/emmet-vim'
" Arduino
" compiling, uploading, and debugging arduino sketches
Plug 'stevearc/vim-arduino'


" Git support
" shows a git diff in the gutter
Plug 'mhinz/vim-signify'
" vim syntax, indent, and filetype plugin files for git
Plug 'tpope/vim-git'
" git wrapper
Plug 'tpope/vim-fugitive'
" better git commit buffer
Plug 'rhysd/committia.vim'
" shows git status flags in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'


" UI
" status bar for vim
Plug 'vim-airline/vim-airline'
" vim-airline themes
Plug 'vim-airline/vim-airline-themes'
" tint parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" use Nerd Fonts in vim
Plug 'ryanoasis/vim-devicons'
" display indentation
Plug 'nathanaelkane/vim-indent-guides'
" colorscheme
Plug 'rakr/vim-one'
" a file system explorer for vim
Plug 'scrooloose/nerdtree'
" view and search LSP simbols
Plug 'liuchengxu/vista.vim'
" visualize undo branches
Plug 'mbbill/undotree'
" fuzzy finder
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
" Easier buffer navigation
Plug 'jlanzarotta/bufexplorer'
" distraction-free writing
Plug 'junegunn/goyo.vim'
" highlight current line
Plug 'junegunn/limelight.vim'


" Third-party support
" vim time tracking via WakaTime
Plug 'wakatime/vim-wakatime'
" Carbon plugin
Plug 'kristijanhusak/vim-carbon-now-sh'
" Dash plugin
Plug 'rizzatti/dash.vim'


" Miscellaneous
" REPL with vim
Plug 'jpalardy/vim-slime'
" autoclose pairs
Plug 'cohama/lexima.vim'
" auto save changes to disk every time a buffer has been modified
Plug 'vim-scripts/vim-auto-save'
" switch to English keyboard automatically
Plug 'lyokha/vim-xkbswitch'
call plug#end()
