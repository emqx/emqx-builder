#!/usr/bin/env bash

set -euo pipefail

URL="https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh"

cd /
curl --silent --show-error -fkL "$URL" -o "zsh-in-docker.sh"
chmod +x zsh-in-docker.sh

## build

 ./zsh-in-docker.sh \
    -t https://github.com/denysdovhan/spaceship-prompt \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    -p git \
    -p git-fast \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -p 'history-substring-search' \
    -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
    -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'


## cleanup
cd /
rm -rf zsh-in-docker.sh

