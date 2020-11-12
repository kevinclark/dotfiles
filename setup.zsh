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

plugins=(
  zsh-syntax-highlighting zsh-users/zsh-syntax-highlighting
  op sirhc/op.plugin.zsh
)

for name gh in $plugins; do
  plugin_dir=$OMZ_PLUGINS_DIR/$name
  if ! [[ -d $plugin_dir ]]; then
    git clone --depth=1 https://github.com/$gh $plugin_dir
  fi
done


# Place actual dotfiles
for f in `ls dotfiles`; do
  ln -vsf $ROOT/dotfiles/$f ~/.$f
done
