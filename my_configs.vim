
" nofoldenable
set foldlevel=999
" set nofoldenable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ack.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  let g:ackprg = 'ag --vimgrep -Q'
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode

" colorscheme could be powerline | wombat | jellybeans | solarized dark | solarized light etc...
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'charvaluehex'] ],
      \   'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ],
      \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }


"""""""""""""""""""""""""""""""""""""
" =>ale linter,formater
"""""""""""""""""""""""""""""""""""""
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
let g:ale_open_list = 1

let g:ale_completion_tsserver_autoimport = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARNING'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_list_window_size = 10
let b:ale_warn_about_trailing_whitespace = 0

" map to moving to between error
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Run both javascript and vue linters for vue files.
let g:ale_linter_aliases = {
\   'vue': ['vue', 'javascript']
\}

" phpcs psr2 config
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcs_options = '-n'

" python isort options
" let g:ale_python_isort_options = '--multi-line=3 --trailing-comma'
let g:ale_python_flake8_options = '--ignore=E501,W291,N806,F405'

" sql formater
let g:ale_sql_sqlformat_options = ' -k upper --indent_columns -s  -r'

let g:ale_linters = {
\   'go': ['gobuild', 'govet', 'golint', 'staticcheck'],
\   'php': ['php', 'phpcs'],
\   'python': ['flake8'],
\   'javascript': ['tsserver', 'eslint'],
\   'vue': ['vls', 'tsserver'],
\   'css': ['stylelint'],
\   'less': ['stylelint'],
\   'html': ['htmlhint'],
\   'json': ['jsonlint'],
\   'text': ['textlint'],
\   'markdown': ['markdownlint', 'mdl'],
\   'yaml': ['yamllint'],
\   'dockerfile': ['dockerfile_lint'],
\   'xml': ['xmllint'],
\   'vim': ['vint'],
\   'sh': ['shellcheck', 'language_server']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports'],
\   'php': ['php_cs_fixer'],
\   'python': ['black', 'isort'],
\   'javascript': ['prettier', 'importjs'],
\   'vue': ['prettier'],
\   'css': ['prettier'],
\   'less': ['prettier'],
\   'scss': ['prettier'],
\   'sass': ['stylelint'],
\   'html': ['prettier'],
\   'json': ['prettier'],
\   'text': ['textlint'],
\   'markdown': ['prettier'],
\   'yaml': ['prettier'],
\   'xml': ['xmllint'],
\   'sql': ['sqlformat'],
\   'sh': ['shfmt']
\}

set tags=tags;,ctags;,.tags;,.ctags
set nu
set rnu


"""""""""""""""""""""""""""""""""""""
" => deoplete.nvim
""""""""""""""""""""""""""""""""""""""

"let g:deoplete#enable_at_startup = 0

"" php auto complete
"" @see https://github.com/lvht/phpcd.vim
"let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"let g:deoplete#ignore_sources.php = ['omni']
""let g:phpcd_autoload_path = 'path/to/autoload_file.php'
""let g:phpcd_php_cli_executable = 'php'


"" Javascript auto complete
"" @see https://github.com/carlitux/deoplete-ternjs
"let g:deoplete#sources#ternjs#filetypes = [
"\ 'js',
"\ 'jsx',
"\ 'vue'
"\ ]
"let g:tern#command = ["tern"]
"let g:tern#arguments = ["--persistent"]


"" go auto complete
"" @see https://github.com/deoplete-plugins/deoplete-go
"let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
"let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']


"" python auto complete
"" @see https://github.com/deoplete-plugins/deoplete-go
"let g:python_host_prog = '/usr/bin/python'
"let g:python3_host_prog = '/usr/bin/python3'


"" sql auto complete
"" @see https://github.com/jjohnson338/deoplete-mssql
"let g:deoplete#sources#mssql#server='mysql'
"let g:deoplete#sources#mssql#user='root'
"let g:deoplete#sources#mssql#password='123456'
"let g:deoplete#sources#mssql#db='mysql'


"" deoplete-tabnine
"call deoplete#custom#var('tabnine', {
"\ 'line_limit': 500,
"\ 'max_num_results': 20,
"\ })

"" deoplete-emoji
"call deoplete#custom#source('emoji', 'filetypes', ['php', 'markdown', 'text', 'html'])
"call deoplete#custom#source('emoji', 'converters', ['converter_emoji'])





"""""""""""""""""""""""""""""""""""""
" => coc.nvim
""""""""""""""""""""""""""""""""""""""

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
