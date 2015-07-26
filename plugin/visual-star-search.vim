" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

if !has("g:vvsa_FindCommand")
    let g:vvsa_FindCommand = 'LAg! --cpp '
endif

let s:visual_star_search_ag_search_buf = ""

" Makes * and # work on visual mode too.
" Here we do a verbatim search,
" i.e. there is no special meaning of any characters.
function! s:VSetSearchAg()
  let temp = @s
  norm! gv"sy
  " Use the \V Literal Switch for Verbatim Searches in vim
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  " Use \Q \E for perl regex verbatim searches
  let g:visual_star_search_ag_search_buf = '\Q' . substitute(escape(@s, '\'), '\n', '\\n', 'g') . '\E'
  let @s = temp
endfunction

" Sets the search register and invokes the global favorite find command.
" Here we do a normal (perl) regex search,
" vim's \v is pretty close to that.
function! s:SearchAndSetReg(arg)
  "The \v (very magic) pattern search is assigning a special meaning to every symbol except _, numbers, and letters.
  "That’s easily remembered and happens to be consistent with the rules for Perl’s regular expressions.
  let @/ = '\v'.a:arg
  execute g:vvsa_FindCommand.'"'.a:arg.'"'
endfunction

map <Leader>s :call s:SearchAndSetReg("<C-R><C-W>")<CR>
command! -nargs=1 F call s:SearchAndSetReg(<q-args>)

vmap <leader>s :<C-u>call <SID>VSetSearchAg()<CR>:execute 'noautocmd ' . g:vvsa_FindCommand . '"' . g:visual_star_search_ag_search_buf . '"'<CR>

