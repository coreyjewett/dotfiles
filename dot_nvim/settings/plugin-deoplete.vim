let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
  \ 'auto_complete_delay': 200,
  \ 'ignore_case': v:true,
  \ 'camel_case': v:true,
  \ 'smart_case': v:true,
  \ 'keyword_patterns': {
    \ 'default': '\h\w*',
    \ 'tex': '\\?[a-zA-Z_]\w*'
  \ }
\ })

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,mustache setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Define dictionary.
if !exists('g:deoplete#sources#dictionary#dictionaries')
  let g:deoplete#sources#dictionary#dictionaries = {}
endif
let g:deoplete#sources#dictionary#dictionaries.javascript = expand('~/.yadr/vim/dict/javascript.dict')

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return deoplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? deoplete#close_popup() : "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
" Close popup by <ESC>.
"inoremap <expr><ESC> pumvisible() ? deoplete#close_popup() : "\<ESC>"
