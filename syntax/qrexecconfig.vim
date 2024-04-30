" Vim syntax file
" Language:     Qrexec Config
" Maintainer:   Ben Grande <ben.grande.b@gmail.com>
" License:      Vim (see :h license)
" Repository:   https://codeberg.org/ben.grande.b/vim-qrexec
" Last Change:  2024 Apr 30

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

syn match qrexecconfigKeyUnknownError
  \ '^\s*\zs\S\+.*\ze='
  \ contains=@NoSpell

syn match qrexecconfigBooleanKey
  \ '^\s*\zs\(wait-for-session\|skip-service-descriptor\)\ze\s*=\s*\S\+'
  \ contains=@NoSpell
  \ nextgroup=qrexecconfigBooleanAssign
  \ skipwhite

syn match qrexecconfigStringKey
  \ /^\s*\zs\(force-user\)\ze\s*=\s*\S\+/
  \ contains=@NoSpell
  \ nextgroup=qrexecconfigStringAssign
  \ skipwhite


" Section: Assign
syn match qrexecconfigBooleanAssign
  \ '\S'
  \ contained
  \ contains=qrexecconfigAssignError
  \ nextgroup=qrexecconfigBooleanValue,qrexecconfigBooleanValueUnknownError
  \ skipwhite

syn match qrexecconfigStringAssign
  \ '\S'
  \ contained
  \ contains=qrexecconfigAssignError
  \ nextgroup=qrexecconfigStringValue,qrexecconfigStringValueUnknownError
  \ skipwhite


" Section: Value
syn match qrexecconfigBooleanValueUnknownError
  \ '\S\+'
  \ contained
  \ contains=@NoSpell

" Boolean values 0/1 are backwards compatibility for skip-service-descriptor
" and wait-for-session.
syn match qrexecconfigBooleanValue
  \ '\(0\|1\|true\|false\)'
  \ contained
  \ contains=qrexecconfigBooleanValueError
  \ nextgroup=qrexecconfigMustEndError
  \ skipwhite

syn match qrexecconfigStringValueUnknownError
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

syn match qrexecconfigBooleanValueError
  \ '\v\s@<=((0|1|true|false)(\s|$))@!\S*'
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
hi def link qrexecconfigBooleanKey                     qrexecconfigKey
hi def link qrexecconfigStringKey                      qrexecconfigKey
hi def link qrexecconfigCommentModeLine                qrexecconfigComment

" Error Group
hi def link qrexecconfigIncompleteError                qrexecconfigError
hi def link qrexecconfigMustEndError                   qrexecconfigError
hi def link qrexecconfigKeyUnknownError                qrexecconfigError
hi def link qrexecconfigAssignError                    qrexecconfigError
hi def link qrexecconfigBooleanValueError              qrexecconfigError
hi def link qrexecconfigBooleanValueUnknownError       qrexecconfigError
hi def link qrexecconfigStringValueError               qrexecconfigError
hi def link qrexecconfigStringValueUnknownError        qrexecconfigError

" Reference Group
hi def link qrexecconfigKey                            Identifier
hi def link qrexecconfigBooleanValue                   Number
hi def link qrexecconfigStringValue                    String
hi def link qrexecconfigTodo                           Todo
hi def link qrexecconfigComment                        Comment
hi def link qrexecconfigError                          Error


" Section: End
let b:current_syntax = "qrexecconfig"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 sts=2 et :
