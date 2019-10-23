 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => vim-multiple-cursors
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:multi_cursor_next_key="\<C-n>"


 """""""""""""""""""""""""""""""""""""
 " =>ale checks
 """""""""""""""""""""""""""""""""""""

let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARNING'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_list_window_size = 10
let b:ale_warn_about_trailing_whitespace = 0
let g:ale_open_list = 1

" Run both javascript and vue linters for vue files.
let g:ale_linter_aliases = {
\   'vue': ['vue', 'javascript']
\}

" phpcs psr2 config
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcs_options = '-n'

let g:ale_linters = {
\   'go': ['gobuild', 'golint', 'govet', 'staticcheck'],
\   'php': ['php', 'phpcs'],
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'vue': ['eslint', 'vls'],
\   'css': ['stylelint', 'csslint'],
\   'less': ['stylelint'],
\   'html': ['htmlhint'],
\   'json': ['jsonlint'],
\   'text': ['textlint'],
\   'markdown': ['alex', 'markdownlint', 'mdl'],
\   'yaml': ['yamllint']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports'],
\   'php': ['php_cs_fixer'],
\   'python': ['autopep8', 'yapf'],
\   'javascript': ['prettier', 'eslint'],
\   'vue': ['prettier', 'eslint'],
\   'css': ['prettier'],
\   'less': ['prettier'],
\   'html': ['prettier'],
\   'json': ['prettier'],
\   'text': ['textlint'],
\   'markdown': ['prettier'],
\   'yaml': ['prettier']
\}

set tags=tags;,ctags;,.tags;,.ctags
set nu
set rnu

" php block docs
" PHP documenter script bound to Control-P
autocmd FileType php inoremap <C-p> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-p> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-p> :call PhpDocRange()<CR>


 """""""""""""""""""""""""""""""""""""
 " => deoplete.nvim
 """""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

" php auto complete
" @see https://github.com/lvht/phpcd.vim
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
"let g:phpcd_autoload_path = 'path/to/autoload_file.php'
"let g:phpcd_php_cli_executable = 'php'


" Javascript auto complete
" @see https://github.com/carlitux/deoplete-ternjs
let g:deoplete#sources#ternjs#filetypes = [
\ 'js',
\ 'jsx',
\ 'vue'
\ ]
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]


" go auto complete
" @see https://github.com/deoplete-plugins/deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']


" python auto complete
" @see https://github.com/deoplete-plugins/deoplete-go
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'


" sql auto complete
" @see https://github.com/jjohnson338/deoplete-mssql
let g:deoplete#sources#mssql#server='mysql'
let g:deoplete#sources#mssql#user='root'
let g:deoplete#sources#mssql#password='123456'
let g:deoplete#sources#mssql#db='mysql'


" deoplete-tabnine
call deoplete#custom#var('tabnine', {
\ 'line_limit': 500,
\ 'max_num_results': 20,
\ })

" deoplete-emoji
call deoplete#custom#source('emoji', 'filetypes', ['php', 'markdown', 'text', 'html'])
call deoplete#custom#source('emoji', 'converters', ['converter_emoji'])
