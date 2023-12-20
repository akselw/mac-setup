# Global

# Generert med `defaults export com.apple.symbolichotkeys - >symbolichotkeys.plist`
# Tatt herfra https://stackoverflow.com/questions/34561758/is-there-a-way-to-change-keyboard-shortcuts-with-shell-in-os-x
defaults import com.apple.symbolichotkeys symbolichotkeys.plist

# Kan være at disse er unødvendige når den over kjører. Prøv det gjerne med en ny Mac
defaults write -globalDomain NSUserKeyEquivalents -dict-add "System Settings\\U2026" "@~,"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Show Next Tab" "@~\\U2192"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Show Previous Tab" "@~\\U2190"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Lock Screen" "~^l"

defaults write com.apple.dock "autohide" -bool "true" && killall Dock
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d HH:mm\""
