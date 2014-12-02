" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

let s:visual_star_search_ag_search_buf = ""

" makes * and # work on visual mode too.
function! s:VSetSearchAg()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let g:visual_star_search_ag_search_buf = '\Q' . substitute(escape(@s, '\'), '\n', '\\n', 'g') . '\E'
  let @s = temp
endfunction

map <Leader>a :let @/="<C-R><C-W>" \| LAg! "\b<C-R><C-W>\b"<cr>
vmap <leader>a :<C-u>call <SID>VSetSearchAg()<CR>:execute 'noautocmd LAg! "' . g:visual_star_search_ag_search_buf . '"'<CR>

