" Vim filetype plugin file
" Language:     Qrexec Policy
" Maintainer:   Ben Grande <ben.grande.b@gmail.com>
" License:      Vim (see :h license)
" Repository:   https://codeberg.org/ben.grande.b/vim-qrexec
" Last Change:  2023 May 18

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

if !exists("g:qrexec_recommended_style")
  let g:qrexec_recommended_style = 1
endif

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "
  \ setlocal fileformat< comments< commentstring< formatoptions< |
  \ setlocal textwidth< iskeyword< completefunc< omnifunc< |
  \ setlocal spellfile< |
  \"

setlocal fileformat=unix
setlocal comments=:# commentstring=#\ %s
setlocal formatoptions& formatoptions-=t formatoptions+=jcrql
setlocal formatoptions=jcrql
setlocal iskeyword=33,42,43,45,46,48-57,58,61,@-@,65-90,95,97-122
setlocal completefunc=qrexeccomplete#Complete
setlocal omnifunc=qrexeccomplete#Complete
execute "setlocal spellfile+=" . expand("<sfile>:p:h:h") .
      \                      "/spell/qrexec.ascii.add"

if g:qrexec_recommended_style == 1
  let b:undo_ftplugin ..= "
    \ setlocal textwidth< |
    \"
  setlocal textwidth=78
endif

if &filetype ==# "qrexecpolicy"
  compiler qrexec
elseif &filetype ==# "qrexecpolicyservice"
  compiler qrexec
  let b:undo_ftplugin ..= "
    \ unlet b:ale_linter_aliases |
    \"
  let b:ale_linter_aliases = ['qrexecpolicy']
elseif &filetype ==# "qrexecconfig"
  " TODO: Does it even exist?
endif

let b:undo_ftplugin ..= "
  \ unlet b:dispatch |
  \"
let b:dispatch = &makeprg

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 sts=2 et :
