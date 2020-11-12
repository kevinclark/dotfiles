#!/usr/bin/env zsh

set -e

ROOT=${0:a:h}

# ZSH install

if ! [[ -d ~/.oh-my-zsh ]]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

OMZ_PLUGINS_DIR=~/.oh-my-zsh/custom/plugins
OMZ_THEMES_DIR=~/.oh-my-zsh/custom/themes

if ! [[ -d $OMZ_THEMES_DIR/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $OMZ_THEMES_DIR/powerlevel10k
fi

if ! [[ -d $OMZ_PLUGINS_DIR/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ_PLUGINS_DIR/zsh-syntax-highlighting
fi

if ! [[ -d $OMZ_PLUGINS_DIR/op ]]; then
  git clone https://github.com/sirhc/op.plugin.zsh.git $OMZ_PLUGINS_DIR/op
fi

for f in `ls zsh`; do
  ln -vsf $ROOT/zsh/$f ~/.$f
done

