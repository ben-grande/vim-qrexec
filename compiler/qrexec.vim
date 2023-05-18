" Vim compiler file
" Compiler:     qubes-policy-lint
" Maintainer:   Ben Grande <ben.grande.b@gmail.com>
" License:      Vim (see :h license)
" Repository:   https://codeberg.org/ben.grande.b/vim-qrexec
" Last Change:  2023 May 18

if exists("current_compiler")
  finish
endif
let current_compiler = "qrexec"

let s:cpo_save = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeencoding=utf-8
if &filetype ==# "qrexecpolicy"
  CompilerSet makeprg=qubes-policy-lint\ %
elseif &filetype ==# "qrexecpolicyservice"
  CompilerSet makeprg=qubes-policy-lint\ --include-service\ %
elseif &filetype ==# "qrexecconfig"
  " TODO: Does it even exist?
endif
CompilerSet errorformat=%f:%l:\ %trror:\ %m,
                       \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 sts=2 et :
