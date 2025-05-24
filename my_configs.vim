
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => basic, highlight column line, foldlevel etc...
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make sure a copy of the file is made and the original one overwritten on save
" fix system's file watching
set backupcopy=yes

" set colorcolumn=81
" highlight ColorColumn ctermbg=grey ctermfg=white guibg=lightgrey

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" highlight OverLength ctermbg=grey ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" set cursorline
" set cursorcolumn
" highlight CursorColumn ctermbg=gray ctermfg=white guibg=#592929

set foldlevel=999
" set nofoldenable

" fix java syntax/java.vim error
let g:java_ignore_markdown = 1

" NERDTree 最佳实践配置
let g:NERDTreeFileLines = 1

" 1. 设置 NERDTree 显示在左侧
let g:NERDTreeWinPos = "left"

" 2. 设置初始宽度
let g:NERDTreeWinSize = 35

" 3. 动态调整宽度
function! NERDTreeAutoWidth()
  if exists("b:NERDTree")
    let l:max_width = 0
    for l:line in getbufline(bufnr('NERDTree'), 1, '$')
      let l:line_width = strwidth(l:line)
      if l:line_width > l:max_width
        let l:max_width = l:line_width
      endif
    endfor
    let l:min_width = 20
    let l:max_width = min([l:max_width + 2, 50])
    execute 'wincmd w'
    execute 'vertical resize ' . l:max_width
    wincmd p
  endif
endfunction
autocmd BufWinEnter NERDTree call NERDTreeAutoWidth()
autocmd FileType nerdtree call NERDTreeAutoWidth()

" 4. 快捷键映射
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
" nnoremap <leader>w+ :vertical resize +5<CR>
" nnoremap <leader>w- :vertical resize -5<CR>

" 5. 启动 Vim 时自动打开 NERDTree（仅当无文件参数时）
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif

" 6. 关闭最后一个窗口时退出 NERDTree
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" 7. 显示隐藏文件
let g:NERDTreeShowHidden = 1

" 8. 优化视觉效果
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" 9. 忽略特定文件/目录
let g:NERDTreeIgnore = ['\.pyc$', '\~$', '\.swp$', '\.git$', '\.hg$', '\.svn$', '\.bzr$']

" 11. 自动刷新 NERDTree
autocmd BufEnter * if exists("b:NERDTree") | NERDTreeRefreshRoot | endif


" docker compose
"
au FileType yaml if bufname("%") =~# "docker-compose.yml" | set ft=yaml.docker-compose | endif
au FileType yaml if bufname("%") =~# "compose.yml" | set ft=yaml.docker-compose | endif
au FileType yaml if bufname("%") =~# "docker-compose.yaml" | set ft=yaml.docker-compose | endif
au FileType yaml if bufname("%") =~# "compose.yaml" | set ft=yaml.docker-compose | endif

let g:coc_filetype_map = {
  \ 'yaml.docker-compose': 'dockercompose',
  \ }


" ansible
" git@github.com:pearofducks/ansible-vim.git
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }

" scss
autocmd FileType scss setl iskeyword+=@-@

" coc-explorer
:nmap <space>ee <Cmd>CocCommand explorer<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ack.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  let g:ackprg = 'ag --vimgrep -Q'
endif


:nmap <space>f <Cmd>CocCommand explorer<CR>


"""codeium"""
let g:codeium_disable_bindings = 1
imap <script><silent><nowait><expr> <C-g> codeium#Accept()
imap <script><silent><nowait><expr> <C-h> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <C-j> codeium#AcceptNextLine()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x>   <Cmd>call codeium#Clear()<CR>


"""vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'



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
\   'go': ['gobuild',  'revive','govet', 'golint', 'staticcheck'],
\   'php': ['php', 'phpcs'],
\   'java': ['javac', 'checkstyle'],
\   'python': ['pylint', 'flake8', 'pycodestyle'],
\   'javascript': ['tsserver', 'eslint'],
\   'vue': ['vls', 'tsserver'],
\   'css': ['stylelint'],
\   'less': ['stylelint'],
\   'html': ['htmlhint'],
\   'json': ['jsonlint','jq'],
\   'text': ['textlint'],
\   'markdown': ['markdownlint', 'mdl'],
\   'yaml': ['yamllint'],
\   'dockerfile': ['dockerfile_lint'],
\   'xml': ['xmllint'],
\   'vim': ['vint'],
\   'sh': ['shellcheck', 'language_server']
\}

let g:ale_java_google_java_format_executable = 'google-java-format'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports'],
\   'java': ['google_java_format'],
\   'php': ['php_cs_fixer'],
\   'python': ['black','autoimport', 'isort', 'autopep8', 'yapf'],
\   'javascript': ['prettier'],
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
" https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
