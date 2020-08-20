function! bootstrap#after() abort
  let g:neoformat_enabled_javascript = ['prettier']
  let g:neomake_javascript_jsx_enabled_makers = ['eslint']
endfunction

