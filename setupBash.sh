#!/bin/bash

if [ ! -f ~/.bash_profile ]; then
  cat >~/.bash_profile <<EOL
if [ -f `pwd`/bash_profile ]; then
  .  `pwd`/bash_profile
else
  echo 'Finner ikke bash_profile. Har repoet "mac-setup" blitt flyttet/renamet?'
fi

EOL
  source ~/.bash_profile
else
  echo 'Det finnes allerede en ~/.bash_profile. Slett eller rename filen'
fi
