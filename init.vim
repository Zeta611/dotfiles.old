call plug#begin('~/.local/share/nvim/plugged')

" easily delete, change, and add surroundings.
Plug 'tpope/vim-surround'

" tint parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" autoclose pairs
Plug 'Raimondi/delimitMate'

" display indentation
Plug 'Yggdroot/indentLine'

" smooth scroll
Plug 'terryma/vim-smooth-scroll'

" asynchronous autocomplete framework
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}

" Swift deoplete
Plug 'mitsuse/autocomplete-swift'

" clang deoplete
Plug 'tweekmonster/deoplete-clang'

" snippet engine for vim
Plug 'SirVer/ultisnips'

" snippets
Plug 'honza/vim-snippets'

" language packs
Plug 'sheerun/vim-polyglot'

" syntax checker
Plug 'vim-syntastic/syntastic'

" swift syntax and indentation with syntastic
Plug 'keith/swift.vim'

" commenter
Plug 'scrooloose/nerdcommenter'

" multiple cursors for vim
Plug 'terryma/vim-multiple-cursors'

" a file system explorer for vim
Plug 'scrooloose/nerdtree'

" shows git status flags in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'

" shows a git diff in the gutter
Plug 'airblade/vim-gitgutter'

" vim syntax, indent, and filetype plugin files for git
Plug 'tpope/vim-git'

" git wrapper
Plug 'tpope/vim-fugitive'

" LaTeX with vim
Plug 'lervag/vimtex'

" javascript refactor
Plug 'maksimr/vim-jsbeautify'

" fuzzy finder
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}

" gitignore file generation with fuzzy finder interface
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}

" use Nerd Fonts in vim
Plug 'ryanoasis/vim-devicons'

" status bar for vim
Plug 'vim-airline/vim-airline'

" vim-airline themes
Plug 'vim-airline/vim-airline-themes'

" gruvbox theme
Plug 'morhetz/gruvbox'

" switch to English keyboard automatically
Plug 'lyokha/vim-xkbswitch'

" compiling, uploading, and debugging arduino sketches
Plug 'stevearc/vim-arduino'

" vim time tracking via WakaTime
Plug 'wakatime/vim-wakatime'

call plug#end()

" make pyenv work with neovim
let g:python_host_prog = '/Users/jay/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/jay/.pyenv/versions/neovim3/bin/python'

set nocompatible
filetype plugin indent on

set number
set relativenumber
set showcmd

set visualbell

set termguicolors
set background=dark

" set indentation
autocmd FileType * set tabstop=4|set shiftwidth=4|set softtabstop=4|set autoindent|set cindent|set expandtab|set smarttab|set smartindent
autocmd FileType html,xhtml,swift set tabstop=2|set shiftwidth=2|set softtabstop=2
autocmd FileType c set tabstop=8|set shiftwidth=8|set softtabstop=8|set noexpandtab

set list lcs=tab:\┆\ ,eol:$,extends:>,precedes:<,trail:~,space:·

if has("syntax")
    syntax on
endif

au VimEnter * set concealcursor=n

" custom keymaps begin
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Up> :resize -5<CR>
nnoremap <Down> :resize +5<CR>
" custom keymaps end

" enable RainbowParentheses when launch
au VimEnter * RainbowParentheses

" indentLine settings begin
let g:indentLine_char = '┆'
" indentLine settings end

" vim-smooth-scroll settings begin
noremap <silent> <c-up> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-down> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" vim-smooth-scroll settings end

" deoplete settings begin
let g:deoplete#enable_at_startup = 1
" deoplete settings end

" autocomplete-swift settings begin
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
" autocomplete-swift settings end

" UltiSnips settings begin
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsEditSplit="vertical"
" UltiSnips settings end

" vim-polyglot settings begin
let g:polyglot_disabled = ['tex', 'latex']
" vim-polygot settings end

" Syntastic settings begin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_swift_swiftlint_use_defaults = 1
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
" Syntastic settings end

" NERD Commenter settings begin
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
" NERD Commenter settings end

" vimtex settings begin
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_progname = '/Users/jay/.pyenv/versions/neovim3/bin/nvr'
let g:vimtex_quickfix_enable = 0
let g:vimtex_view_skim_activate = 1

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
" vimtex settings end

" vim-jsbeautify settings begin
map <c-f> :call JsBeautify()<cr>
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html,xhtml noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" vim-jsbeautify settings end

" vim-airline settings begin
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" vim-airline settings end

" gruvbox settings begin
colorscheme gruvbox
let g:gruvbox_italic=1
" gruvbox settings end

" XkbSwitch settings begin
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
" XkbSwitch settings end
