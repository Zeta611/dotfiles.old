call plug#begin('~/.local/share/nvim/plugged')
" better dot repeat
Plug 'tpope/vim-repeat'
" visualize undo branches
Plug 'mbbill/undotree'
" faster motion
Plug 'easymotion/vim-easymotion'
" easily delete, change, and add surroundings.
Plug 'tpope/vim-surround'
" tint parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" autoclose pairs
Plug 'cohama/lexima.vim'
" display indentation
Plug 'nathanaelkane/vim-indent-guides'
" smooth scroll
Plug 'psliwka/vim-smoothie'
" asynchronous autocomplete framework
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Swift deoplete
Plug 'mitsuse/autocomplete-swift'
" jedi for deoplete-jedi
Plug 'davidhalter/jedi'
" Python deoplete
Plug 'deoplete-plugins/deoplete-jedi'
" (De)activate pyenv Python correctly.
Plug 'lambdalisue/vim-pyenv', { 'for': ['python', 'python3'] }
" clang deoplete
Plug 'zchee/deoplete-clang'
" OCaml deoplete
Plug 'copy/deoplete-ocaml'
" snippet engine for vim
Plug 'SirVer/ultisnips'
" snippets
Plug 'honza/vim-snippets'
" language packs
Plug 'sheerun/vim-polyglot'
" syntax checker
Plug 'neomake/neomake'
" commenter
Plug 'scrooloose/nerdcommenter'
" multiple cursors for vim
Plug 'terryma/vim-multiple-cursors'
" a file system explorer for vim
Plug 'scrooloose/nerdtree'
" shows git status flags in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
" shows a git diff in the gutter
Plug 'mhinz/vim-signify'
" vim syntax, indent, and filetype plugin files for git
Plug 'tpope/vim-git'
" git wrapper
Plug 'tpope/vim-fugitive'
" better git commit buffer
Plug 'rhysd/committia.vim'
" LaTeX with vim
Plug 'lervag/vimtex'
" more conceal feature for LaTeX
Plug 'KeitaNakamura/tex-conceal.vim'
" javascript refactor
Plug 'maksimr/vim-jsbeautify'
" fuzzy finder
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
" gitignore file generation with fuzzy finder interface
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}
" use Nerd Fonts in vim
Plug 'ryanoasis/vim-devicons'
" status bar for vim
Plug 'vim-airline/vim-airline'
" vim-airline themes
Plug 'vim-airline/vim-airline-themes'
" colorschemes
Plug 'chriskempson/base16-vim'
" seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" switch to English keyboard automatically
Plug 'lyokha/vim-xkbswitch'
" compiling, uploading, and debugging arduino sketches
Plug 'stevearc/vim-arduino'
" vim time tracking via WakaTime
Plug 'wakatime/vim-wakatime'
" auto save changes to disk every time a buffer has been modified
Plug 'vim-scripts/vim-auto-save'
" distraction-free writing
Plug 'junegunn/goyo.vim'
" highlight current line
Plug 'junegunn/limelight.vim'
" Sublime Text like minimap
Plug 'severin-lemaignan/vim-minimap'
" Carbon plugin
Plug 'kristijanhusak/vim-carbon-now-sh'
" Dash plugin
Plug 'rizzatti/dash.vim'
" emmet abbreviation
Plug 'mattn/emmet-vim'
" REPL with vim
Plug 'jpalardy/vim-slime'
" Easier buffer navigation
Plug 'jlanzarotta/bufexplorer'
" Swap two splits
Plug 'wesQ3/vim-windowswap'
" Tag browser
Plug 'majutsushi/tagbar'
call plug#end()

" make pyenv work with neovim
let g:python_host_prog = expand('~/.pyenv/versions/neovim-python2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim-python3/bin/python')

set nocompatible
filetype plugin indent on

set number
set relativenumber
set showcmd

set visualbell

set termguicolors
set background=dark

set ignorecase
set smartcase

set textwidth=79
set colorcolumn=79

set so=7

colorscheme base16-synth-midnight-dark

" set indentation
autocmd FileType * set tabstop=4|set shiftwidth=4|set softtabstop=4|set autoindent|set cindent|set expandtab|set smarttab|set smartindent
autocmd FileType ocaml,html,xhtml,swift,sh,cpp,tex set tabstop=2|set shiftwidth=2|set softtabstop=2
autocmd FileType c,go,make set tabstop=8|set shiftwidth=8|set softtabstop=8|set noexpandtab

au FileType gitcommit set tw=1000

autocmd FileType tpp set filetype=cpp
autocmd FileType arduino set filetype=c
autocmd FileType "k--" set filetype=ocaml

set list lcs=tab:\┆\ ,eol:$,extends:>,precedes:<,trail:~

if has("syntax")
    syntax on
endif

if has("persistent_undo")
    set undodir=~/.local/share/nvim/undodir/
    set undofile
endif

" custom keymaps begin
let mapleader = ","

" resize splits
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>
nnoremap <Up> :resize -5<CR>
nnoremap <Down> :resize +5<CR>

" move splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" move line/column
nnoremap <A-k> :m .-2<CR>
nnoremap <A-j> :m .+1<CR>
nnoremap <A-h> xhP
nnoremap <A-l> xp

" make upper case
nnoremap <A-u> viwU
inoremap <A-u> <ESC>viwUi
" custom keymaps end

" undotree settings begin
let g:undotree_WindowLayout = 3
" undotree settings end

" RainbowParentheses settings begin
au VimEnter * RainbowParentheses
" RainbowParentheses settings end

" lexima settings begin
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'tex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'tex'})
" lexima settings end

" Indent Guides settings begin
let g:indent_guides_enable_on_vim_startup = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#282828
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3836
" Indent Guides settings end

" deoplete settings begin
let g:deoplete#enable_at_startup = 1

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let llvm_path = systemlist('brew --prefix llvm')[0]
let g:deoplete#sources#clang#libclang_path = llvm_path . "/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = llvm_path . "/lib/clang/"

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.ocaml = ['buffer', 'around', 'member', 'tag']

let g:deoplete#auto_complete_delay = 0
" deoplete settings end

" autocomplete-swift settings begin
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
" autocomplete-swift settings end

" UltiSnips settings begin
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
" UltiSnips settings end

" vim-polyglot settings begin
let g:polyglot_disabled = ['tex', 'latex']
" vim-polygot settings end

" Neomake settings begin
call neomake#configure#automake('nrwi', 500)
" let g:neomake_tex_enabled_makers = ['chktex', 'rubberinfo', 'proselint']
let g:neomake_ocaml_enabled_makers = ['merlin']
let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:neomake_python_flake8_maker = {
  \ 'exe': expand('~/.pyenv/versions/3.7.3/envs/neovim-python3/bin/flake8'),
  \ 'args': ['--format=default'],
  \ 'errorformat':
      \ '%E%f:%l: could not compile,%-Z%p^,' .
      \ '%A%f:%l:%c: %t%n %m,' .
      \ '%A%f:%l: %t%n %m,' .
      \ '%-G%.%#',
  \ 'postprocess': function('neomake#makers#ft#python#Flake8EntryProcess')
  \ }
let g:neomake_python_mypy_maker = {
  \ 'exe': expand('~/.pyenv/versions/3.7.3/envs/neovim-python3/bin/mypy'),
  \ }
" Neomake settings end

" NERD Commenter settings begin
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = {
  \ 'c': { 'left': '/**','right': '*/' },
  \ 'swift': { 'left': '//' }
  \ }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

nnoremap <F10> :NERDTreeToggle<cr>
" NERD Commenter settings end

" vimtex settings begin
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_progname = '/Users/jay/.pyenv/versions/neovim3/bin/nvr'
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_autoclose_after_keystrokes = 1
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

" tex-conceal settings begin
" au VimEnter * set concealcursor=nc
" set conceallevel=2
set conceallevel=0
let g:tex_conceal="abdgm"
" tex-conceal settings end

" vim-jsbeautify settings begin
autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html,xhtml noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" vim-jsbeautify settings end

" vim-airline settings begin
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
" vim-airline settings end

" XkbSwitch settings begin
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
" XkbSwitch settings end

" AutoSave settings begin
let g:auto_save = 0
" AutoSave settings end

" Limelight settings begin
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Limelight settings end

" Minimap settings begin
let g:minimap_highlight='StatusLine'
" Minimap settings end

" Correct syntax highlighting for expl3
autocmd FileType tex syn match texStatement "\\[a-zA-Z_:@]\+"

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
"
autocmd FileType ocaml source /Users/jay/.opam/4.02.3/share/ocp-indent/vim/indent/ocaml.vim


" vim-slime settings begin
let g:slime_target = "tmux"
" vim-slime settings end

" fzf settings begin
nnoremap <c-p> :FZF<cr>
" fzf settings end

" Tagbar settings begin
nnoremap <silent> <F9> :TagbarToggle<CR>
" Tagbar settings end

" Display all colorschems in base16-vim
function! DisplayColorSchemes()
   let currDir = getcwd()
   exec "cd ~/.local/share/nvim/plugged/base16-vim/colors"
   for myCol in split(glob("*"), '\n')
      if myCol =~ '\.vim'
         let mycol = substitute(myCol, '\.vim', '', '')
         exec "colorscheme " . mycol
         exec "redraw!"
         echo "colorscheme = ". myCol
         sleep 2
      endif
   endfor
   exec "cd " . currDir
endfunction
