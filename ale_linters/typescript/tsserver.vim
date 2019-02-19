" Author: w0rp <devw0rp@gmail.com>
" Description: tsserver integration for ALE

call ale#Set('typescript_tsserver_executable', 'tsserver')
call ale#Set('typescript_tsserver_config_path', '')
call ale#Set('typescript_tsserver_use_global', get(g:, 'ale_use_global_executables', 0))

call ale#linter#Define('typescript', {
\   'name': 'tsserver',
\   'lsp': 'tsserver',
\   'executable_callback': ale#node#FindExecutableFunc('typescript_tsserver', [
\       'node_modules/.bin/tsserver',
\   ]),
\   'command': '%e',
\   'project_root_callback': 'ale#handlers#tsserver#GetProjectRoot',
\   'language': '',
\})
