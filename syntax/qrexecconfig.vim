" Vim syntax file
" Language:     Qrexec Config
" Maintainer:   Ben Grande <ben.grande.b@gmail.com>
" License:      Vim (see :h license)
" Repository:   https://codeberg.org/ben.grande.b/vim-qrexec
" Last Change:  2023 May 18

" Based on: https://github.com/DemiMarie/qubes-core-qrexec/commit/49ab526960690e7ace3a2437d97e92bac9b7f1da
" TODO: after Demi's changes are accepted on
"         https://github.com/QubesOS/qubes-issues/issues/8153
"         Check if there is anything to fix. For example, she blocked lines
"         starting with whitespace (search for (Unexpected whitespace at the
"         start of line)) on libqrexec/toml.c.
" TODO: Implement error when key appears more than once. Tried, but couldn't.
"       Seems very cumbersome.


" Section: Bootstrap
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


" Section: Cluster
syn cluster qrexecconfigCommentGroup
  \ add=qrexecconfigComment
  \ add=qrexecconfigCommentModeline
  \ add=qrexecconfigTodo


" Section: Key
syn match qrexecconfigIncompleteError
  \ '^\s*\zs.*'
  \ contains=@NoSpell

syn match qrexecconfigUnknownKeyError
  \ '^\s*\zs\S\+.*\ze='
  \ contains=@NoSpell

syn match qrexecconfigBooleanIntegerKey
  \ '^\s*\zs\(wait-for-session\)\ze\s*=\s*\S\+'
  \ contains=@NoSpell
  \ nextgroup=qrexecconfigBooleanIntegerAssign
  \ skipwhite

syn match qrexecconfigStringKey
  \ /^\s*\zs\(user\)\ze\s*=\s*\S\+/
  \ contains=@NoSpell
  \ nextgroup=qrexecconfigStringAssign
  \ skipwhite


" Section: Assign
syn match qrexecconfigBooleanIntegerAssign
  \ '\S'
  \ contained
  \ contains=qrexecconfigAssignError
  \ nextgroup=qrexecconfigBooleanIntegerValue
  \ skipwhite

syn match qrexecconfigStringAssign
  \ '\S'
  \ contained
  \ contains=qrexecconfigAssignError
  \ nextgroup=qrexecconfigStringValue,qrexecconfigStringValueUnknown
  \ skipwhite


" Section: Value
syn match qrexecconfigBooleanIntegerValue
  \ '\S'
  \ contained
  \ contains=qrexecconfigBooleanIntegerValueError
  \ nextgroup=qrexecconfigMustEndError
  \ skipwhite

syn match qrexecconfigStringValueUnknown
  \ '\S\+'
  \ contained
  \ contains=@NoSpell

" Require string to start and end with single quote.
syn match qrexecconfigStringValue
  \ /\v(')%(\1@!.)+\1/
  \ contained
  \ contains=@NoSpell,qrexecconfigStringValueError
  \ nextgroup=qrexecconfigMustEndError


" Section: Errors
syn match qrexecconfigMustEndError
  \ '.*'
  \ contained

syn match qrexecconfigAssignError
  \ '\v\s@<=(\=\s*)@!\S*'
  \ contained

syn match qrexecconfigBooleanIntegerValueError
  \ '\v((0|1)\s*$)@!\S*'
  \ contained

syn match qrexecconfigStringValueError
  \ /[^0-9A-Za-z_.'-]/
  \ contained


" Section: Comments
syn match qrexecconfigComment
  \ '^\s*\zs#.*$'
  \ contains=@qrexecconfigCommentGroup
syn match qrexecconfigTodo
  \ '\s\+\zs\(TODO\|FIXME\|NOTE\|XXX\)\ze:\(\s\+\|$\)'
  \ contained
  \ contains=@NoSpell
syn match qrexecconfigCommentModeline
  \ '^\s*\zs#\S*\s\+vim:.*$'
  \ contained
  \ contains=@NoSpell


" Section: Highlight
" Config Group
hi def link qrexecconfigBooleanIntegerKey              qrexecconfigKey
hi def link qrexecconfigStringKey                      qrexecconfigKey
hi def link qrexecconfigCommentModeLine                qrexecconfigComment

" Error Group
hi def link qrexecconfigIncompleteError                qrexecconfigError
hi def link qrexecconfigMustEndError                   qrexecconfigError
hi def link qrexecconfigUnknownKeyError                qrexecconfigError
hi def link qrexecconfigAssignError                    qrexecconfigError
hi def link qrexecconfigBooleanIntegerValueError       qrexecconfigError
hi def link qrexecconfigStringValueError               qrexecconfigError
hi def link qrexecconfigStringValueUnknown             qrexecconfigError

" Reference Group
hi def link qrexecconfigKey                            Identifier
hi def link qrexecconfigBooleanIntegerValue            Number
hi def link qrexecconfigStringValue                    String
hi def link qrexecconfigTodo                           Todo
hi def link qrexecconfigComment                        Comment
hi def link qrexecconfigError                          Error


" Section: End
let b:current_syntax = "qrexecconfig"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 sts=2 et :
