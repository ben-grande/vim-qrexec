# qrexec.vim

A Qrexec companion for the policy breakers.

Repository: https://codeberg.org/ben.grande.b/vim-qrexec

## Features

- **File types**: Qrexec Policy, Qrexec Policy Service, Qrexec Config
- **Syntax Highlighting**: strict check, errors are emphasized
- **Lint integration**: native mode or via plugins (Dispatch, Ale)
- **Code completion**: based on syntax and previous entries
- **Spell file**: good words list

## Requirements

Vim version 8.2 or newer. Planned support is for the lowest Vim version found
when comparing Dom0 Stable and Debian Stable.

The lint tool can only be run in Dom0 as it requires the Dom0 Qrexec package.

## Installation

With Vim 8.0 and beyond, you can use the native package method.

Clone the repository and move it to the `pack` autostart directory:
```sh
git clone https://codeberg.org/ben.grande.b/vim-qrexec.git vim-qrexec
mkdir -p ~/.vim/pack/vendor/start
mv vim-qrexec ~/.vim/pack/vendor/start/
vim -u NONE -c ":helptags ~/.vim/pack/vendor/start/vim-qrexec/doc" -c q
```

If you don't have your `~/.vimrc` configured yet, you will need the following
options to take advantage of this plugin:
```vim
syntax on
filetype plugin indent on
```

## Usage

If you need help, read the reference manual with `:help qrexec`.
On the other hand, if you found the help file confusing, you found a bug and

## License

Copyright (c) Ben Grande. Distributed under the same terms as Vim itself. See
`:help license`
