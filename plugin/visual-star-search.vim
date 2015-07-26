if !exists("g:quickSearch_FindCommand")
    let g:quickSearch_FindCommand = 'LAg! --cpp'
endif

" Add extra whitespace
let g:quickSearch_FindCommand = g:quickSearch_FindCommand.' '

let s:quickSearch_VisualBuf = ""

function! s:Search(command, searchReg)
  let @/ = a:searchReg
  call histadd("search", @/)
  call histadd("cmd", a:command)
  execute a:command
endfunction

function! s:GetVisualSearch()
  let temp = @s
  norm! gv"sy
  let subst = substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let @s = temp
  return subst
endfunction

function! s:LiteralSearch(arg)
  " Use the \V Literal Switch for Verbatim Searches in vim
  let searchReg = '\V' . a:arg
  " Use --literal for perl regex verbatim searches. Both ack and ag supports it.
  " \Q and \E is not supported for ack.
  let command = g:quickSearch_FindCommand . '--literal ' . '"' . a:arg . '"'
  call s:Search(command, searchReg)
endfunction

" Sets the search register and invokes the global favorite find command in
" visual mode.
" Here we do a verbatim search,
" i.e. there is no special meaning of any characters.
function! s:VisualSearch()
  let visualBuf = s:GetVisualSearch()
  call s:LiteralSearch(visualBuf)
endfunction

" Sets the search register and invokes the global favorite find command.
" Here we do a normal (perl) regex search,
" vim's \v is pretty close to that.
function! s:NormalSearch(arg)
  "The \v (very magic) pattern search is assigning a special meaning to every symbol except _, numbers, and letters.
  "That’s easily remembered and happens to be consistent with the rules for Perl’s regular expressions.
  let searchReg = '\v'.a:arg
  let command = g:quickSearch_FindCommand.'"'.a:arg.'"'
  call s:Search(command, searchReg)
endfunction

" Shortcut for the global find command
command! -nargs=1 F call s:NormalSearch(<q-args>)

if !has("g:quickSearch_UseDefaultMappings")
    let g:quickSearch_UseDefaultMappings = 1
endif

if g:quickSearch_UseDefaultMappings == 1
  map <Leader>s :call <SID>NormalSearch("<C-R><C-W>")<CR>
  vmap <leader>s :<C-u>call <SID>VisualSearch()<CR>
endif

