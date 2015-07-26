if !exists("g:quickSearch_FindCommand")
    let g:quickSearch_FindCommand = 'LAg! --cpp'
endif

" Add extra whitespace
let g:quickSearch_FindCommand = g:quickSearch_FindCommand.' '

let s:visual_star_search_ag_search_buf = ""

" Sets the search register and invokes the global favorite find command in
" visual mode.
" Here we do a verbatim search,
" i.e. there is no special meaning of any characters.
function! s:VisualSearch()
  let temp = @s
  norm! gv"sy
  " Use the \V Literal Switch for Verbatim Searches in vim
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let g:visual_star_search_ag_search_buf = substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Sets the search register and invokes the global favorite find command.
" Here we do a normal (perl) regex search,
" vim's \v is pretty close to that.
function! s:NormalSearch(arg)
  "The \v (very magic) pattern search is assigning a special meaning to every symbol except _, numbers, and letters.
  "That’s easily remembered and happens to be consistent with the rules for Perl’s regular expressions.
  let @/ = '\v'.a:arg
  execute g:quickSearch_FindCommand.'"'.a:arg.'"'
endfunction

" Shortcut for the global find command
command! -nargs=1 F call s:NormalSearch(<q-args>)

if !has("g:quickSearch_UseDefaultMappings")
    let g:quickSearch_UseDefaultMappings = 1
endif

if g:quickSearch_UseDefaultMappings == 1
  map <Leader>s :call <SID>NormalSearch("<C-R><C-W>")<CR>
  " Use --literal for perl regex verbatim searches. Both ack and ag supports it.
  " \Q and \E is not supported for ack.
  vmap <leader>s :<C-u>call <SID>VisualSearch()<CR>:execute 'noautocmd ' . g:quickSearch_FindCommand . '--literal ' . '"' . g:visual_star_search_ag_search_buf . '"'<CR>
endif

