function! bootstrap#after() abort
  let g:neoformat_enabled_javascript = ['prettier']
  let g:neomake_javascript_jsx_enabled_makers = ['eslint']
  let g:neomake_typescript_enabled_makers = ['tsc', 'eslint']
endfunction

