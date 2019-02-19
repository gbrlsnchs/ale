" Author: Gabriel Sanches <https://github.com/gbrlsnchs>
" Description: https://godoc.org/golang.org/x/tools/cmd/gopls

call ale#Set('go_gopls_executable', 'gopls')
call ale#Set('go_gopls_options', 'serve')

function! ale_linters#go#gopls#GetCommand(buffer) abort
    return '%e' . ale#Pad(ale#Var(a:buffer, 'go_gopls_options'))
endfunction

function! ale_linters#go#gopls#FindProjectRoot(buffer) abort
    let l:project_root = ale#path#FindNearestFile(a:buffer, 'go.mod')
    let l:mods = ':h'

    if empty(l:project_root)
        let l:project_root = ale#path#FindNearestDirectory(a:buffer, '.git')
        let l:mods = ':h:h'
    endif

    return !empty(l:project_root) ? fnamemodify(l:project_root, l:mods) : ''
endfunction

call ale#linter#Define('go', {
\   'name': 'gopls',
\   'lsp': 'stdio',
\   'executable_callback': ale#VarFunc('go_gopls_executable'),
\   'command_callback': 'ale_linters#go#gopls#GetCommand',
\   'project_root_callback': 'ale_linters#go#gopls#FindProjectRoot',
\})
