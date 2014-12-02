" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

let s:visual_star_search_ag_search_buf = ""

" makes * and # work on visual mode too.
function! s:VSetSearchAg(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let g:visual_star_search_ag_search_buf = '\Q' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g') . '\E'
  let @s = temp
endfunction

"xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
"xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively ag for word under cursor or selection if you hit leader-star
"nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vmap <leader>a :<C-u>call <SID>VSetSearchAg('/')<CR>:execute 'noautocmd LAg! "' . g:visual_star_search_ag_search_buf . '"'<CR>

