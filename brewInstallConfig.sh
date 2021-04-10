#!/bin/sh

brew install $(<brew-packages.txt)

brew tap homebrew/cask-versions

brew install --cask $(<brew-cask-packages.txt)
