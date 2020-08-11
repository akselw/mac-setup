#!/bin/zsh

if [ ! -f ~/.zshrc ]; then
  cat >~/.zshrc <<EOL
if [ -f `pwd`/zshrc ]; then
  .  `pwd`/zshrc
else
  echo 'Finner ikke zshrc. Har repoet "mac-setup" blitt flyttet/renamet?'
fi

EOL
  source ~/.zshrc
else
  echo 'Det finnes allerede en ~/.zshrc. Slett eller rename filen'
fi
