" spcchar.vim: functions to deal with characters in the current buffer
" Maintainer:  @mpbsd
" Version:     0.1

function TableOfEquivalentNonAsciiCharacters() abort
  let l:table_of_equivalent_chars = {
        \  'à': 'a',
        \  'á': 'a',
        \  'â': 'a',
        \  'ã': 'a',
        \  'ç': 'c',
        \  'é': 'e',
        \  'ê': 'e',
        \  'í': 'i',
        \  'ó': 'o',
        \  'ô': 'o',
        \  'õ': 'o',
        \  'ú': 'u',
        \}
  return l:table_of_equivalent_chars
endfunction

function VimRemoveTrailingSpacesFromCurrentBuffer() abort
  let l:pos = getpos('.')
  let l:reg = getreg('/')
  silent 1,$s/\s\+$//e
  call setpos('.', l:pos)
  call setreg('/', l:reg)
endfunction

function VimRemoveNonASCIICharsFromCurrentBuffer() abort
  let l:pos = getpos('.')
  let l:reg = getreg('/')
  for [lhs, rhs] in items(TableOfEquivalentNonAsciiCharacters())
    silent execute printf("1,$s/%s/%s/ge", lhs, rhs)
  endfor
  call setpos('.', l:pos)
  call setreg('/', l:reg)
endfunction

" vim: set fileencoding=utf8: "
