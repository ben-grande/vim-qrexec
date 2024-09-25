" Vim support file to detect file types
" Language:     Qrexec Policy
" Maintainer:   Ben Grande <ben.grande.b@gmail.com>
" License:      Vim (see :h license)
" Repository:   https://codeberg.org/ben.grande.b/vim-qrexec
" Last Change:  2024 Sep 25

autocmd BufRead,BufNewFile
      \ /etc/qubes/policy.d/*.policy
      \ /run/qubes/policy.d/*.policy
      \ setfiletype qrexecpolicy

" vim: sw=2 sts=2 et :
