#!/bin/bash

# Add GPG environment variables to bash and zsh configurations
sed -i '/shellAliases = {/,/};/a\
    initExtra = '\'\''\
      export GPG_TTY=$(tty)\
      export PINENTRY_USER_DATA="USE_CURSES=1"\
    '\'\'';' home.nix

echo "GPG environment variables added to home.nix"
