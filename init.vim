source ~/.config/nvim/plugins.vim

" make pyenv work with neovim
let g:python_host_prog = expand('~/.pyenv/versions/neovim-python2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim-python3/bin/python')

" below two commands are redundant in Neovim
set nocompatible
filetype plugin indent on

set number
set relativenumber
set showcmd

set visualbell

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

colorscheme one
let g:one_allow_italics = 1
set background=dark

set ignorecase
set smartcase

set textwidth=79
set colorcolumn=79

set so=7

set noshowmode
set shortmess+=c

" set indentation
autocmd FileType * set tabstop=4|set shiftwidth=4|set softtabstop=4|set autoindent|set cindent|set expandtab|set smarttab|set smartindent
autocmd FileType ocaml,html,xhtml,sh,tex,ruby,yaml set tabstop=2|set shiftwidth=2|set softtabstop=2
autocmd FileType c,go,make set tabstop=8|set shiftwidth=8|set softtabstop=8|set noexpandtab

autocmd FileType gitcommit set tw=1000

autocmd FileType tpp set filetype=cpp
autocmd FileType arduino set filetype=c
autocmd FileType "k--" set filetype=ocaml
autocmd BufNewFile,BufRead Podfile,*.podspec,Fastfile,Appfile set filetype=ruby

set list lcs=tab:\┆\ ,eol:$,extends:>,precedes:<,trail:~

if has("syntax")
    syntax on
endif
" custom syntax
" Correct syntax highlighting for expl3
autocmd FileType tex syn match texStatement "\\[a-zA-Z_:@]\+"
" support comments in json (jsonc)
autocmd FileType json syntax match Comment +\/\/.\+$+


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
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" move line/column
nnoremap <A-k> :m .-2<CR>
nnoremap <A-j> :m .+1<CR>
nnoremap <A-h> xhP
nnoremap <A-l> xp

" make upper case
nnoremap <A-u> viwU
inoremap <A-u> <ESC>viwUi

" escape terminal emulator using ESC
tnoremap <ESC> <C-\><C-n>

" Edit & source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
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
" let g:vimtex_compiler_progname = expand('~/.pyenv/versions/neovim-python3/bin/nvr')
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_autoclose_after_keystrokes = 1
" let g:vimtex_view_skim_activate = 1

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
" vimtex settings end

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
let g:airline_theme='one'
" vim-airline settings end

" XkbSwitch settings begin
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = expand('~/lib/libInputSourceSwitcher.dylib')
" XkbSwitch settings end

" AutoSave settings begin
let g:auto_save = 0
" AutoSave settings end

" Limelight settings begin
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Limelight settings end

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
" ## added by OPAM user-setup for vim / ocp-indent ## 16a9c521ea63eee4413174fe9893db6c ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source expand("~/.opam/4.09.0/share/ocp-indent/vim/indent/ocaml.vim")
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
"
autocmd FileType ocaml source expand('~/.opam/4.09.0/share/ocp-indent/vim/indent/ocaml.vim')


" vim-slime settings begin
let g:slime_target = "tmux"
" vim-slime settings end

" fzf settings begin
nnoremap <c-p> :FZF<cr>
" fzf settings end

" Display all colorschemes in base16-vim
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

" coc.nvim settings begin
let g:coc_global_extensions = [
\ 'coc-calc',
\ 'coc-highlight',
\ 'coc-json',
\ 'coc-marketplace',
\ 'coc-python',
\ 'coc-snippets',
\ 'coc-solargraph',
\ 'coc-sourcekit',
\ 'coc-texlab',
\ 'coc-vimlsp',
\ 'coc-yaml'
\ ]
" Highlight symbol under cursor on CursorHold
hi CocHighlightText guibg=#444433
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
"
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 Or :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Manage extensions
nnoremap <silent> <leader>ext :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>com :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>out :<C-u>CocList outline<cr>
" Open marketplace
nnoremap <silent> <leader>mar :<C-u>CocList marketplace<cr>
" coc.nvim settings end

" Vista settings begin
nnoremap <silent> <leader>v :Vista<cr>
" Vista settings end

" vim-smoothie settings begin
let g:smoothie_no_default_mappings = v:true
silent! nmap <unique> <C-D> <Plug>(SmoothieDownwards)
silent! nmap <unique> <C-U> <Plug>(SmoothieUpwards)
" vim-smoothie settings end
