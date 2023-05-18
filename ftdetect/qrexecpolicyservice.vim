" Vim support file to detect file types
" Language:     Qrexec Policy Service
" Maintainer:   Ben Grande <ben.grande.b@gmail.com>
" License:      Vim (see :h license)
" Repository:   https://codeberg.org/ben.grande.b/vim-qrexec
" Last Change:  2023 May 15

autocmd BufRead,BufNewFile /etc/qubes/policy.d/include/*
      \ setfiletype qrexecpolicyservice

" vim: sw=2 sts=2 et :
