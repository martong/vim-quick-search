# QuickSearch
QuickSearch provides you simple and very effective search in vim.
You sould have vim Ack or Ag installed.

## Setup
Set up you favourite search command. E.g.:
```
let g:quickSearch_FindCommand = 'LAg! --cpp'
```

## Search in normal mode
If you are standing on a word, hit <leader>s and your search command is executed
with that word.
The search register is modified to contain the word.

## Search in visual mode
Select something in visual mode and hit <leader>s and the search command is executed
with the *literal* content of the visual selection.
The search register is modified to contain the *literal* visual selection,
for that \V is used.

## QuickSearch command
The plugins provides you the :F command.
This command forwards the argument to your favourite search command and sets the search register with \v.
Since \v is used, you will have the same matches in the vim buffers what you have with your search engine.
(Both ack and ag uses perl regexes, and \v is very close to that.)

## Mappings
This plugins provides you a default mapping '<leader>s'.
You can change that with
```
let g:quickSearch_UseDefaultMappings == 0
```
in your vimrc and define the mappings by copying them from the plugin's source code:
```
  map <Leader>QS :call <SID>NormalSearch("<C-R><C-W>")<CR>
  ...
```
