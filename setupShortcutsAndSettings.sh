# Global

defaults write -globalDomain NSUserKeyEquivalents -dict-add "System Settings\\U2026" "@~,"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Show Next Tab" "@~\\U2192"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Show Previous Tab" "@~\\U2190"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Lock Screen" "~^l"

defaults write com.apple.dock "autohide" -bool "true" && killall Dock
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d HH:mm\""
