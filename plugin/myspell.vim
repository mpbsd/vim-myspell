" spcchar.vim: functions to deal with characters in the current buffer
" Maintainer:  @mpbsd
" Version:     0.1

function VimRemoveTrailingSpacesFromCurrentBuffer() abort
  let l:pos = getpos('.')
  let l:reg = getreg('/')
  silent 1,$s/\s\+$//e
  call setpos('.', l:pos)
  call setreg('/', l:reg)
endfunction

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

function VimRemoveNonASCIICharsFromCurrentBuffer() abort
  let l:pos = getpos('.')
  let l:reg = getreg('/')
  for [lhs, rhs] in items(TableOfEquivalentNonAsciiCharacters())
    silent execute printf("1,$s/%s/%s/ge", lhs, rhs)
  endfor
  call setpos('.', l:pos)
  call setreg('/', l:reg)
endfunction

function VimRemoveNonASCIICharsFromCurrentWord(cword) abort
  let l:pword = a:cword
  for [lhs, rhs] in items(TableOfEquivalentNonAsciiCharacters())
    let l:pword = substitute(l:pword, lhs, rhs, 'gie')
  endfor
  return printf("%s %s %s", 'iabbrev' , l:pword , a:cword)
endfunction

function VimAddCurrentWordToTheAbbreviationsList() abort
  let l:abbrv = VimRemoveNonASCIICharsFromCurrentWord(expand('<cword>'))
  call writefile([l:abbrv], expand('~/.vim/spell/words.abbr'), 'a')
  echo printf("%s %s %s", 'Added', l:abbrv, 'to ~/.vim/spell/words.abbr')
endfunction

function VimAddCurrentWordToTheWordsList() abort
  let l:cword = expand('<cword>')
  call writefile([l:cword], expand('~/.vim/spell/words.dict'), 'a')
  echo printf("%s %s %s", 'Added', l:cword, 'to ~/.vim/spell/words.dict')
endfunction

" vim: set fileencoding=utf8: "
