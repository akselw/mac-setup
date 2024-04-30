# Set up Mac

1. Set up TouchID
2. Set up iCloud
3. Installer Brew med:

    ```
    ./installBrew.sh
    ```

4. Installer ting gjennom Brew:

    ```
    ./brewInstallConfig.sh
    ```

5. Logg inn i Dropbox for å begynne å synce
6. Launch 1Password
7. Last ned Magnet fra App Store
8. Inconsolata font
   - Last ned font fra [Google Fonts](https://fonts.google.com/specimen/Inconsolata)
   - Installer font (ved å dobbeltklikke på `.ttf)
   - Legg til i Terminal > Settings > Profiles > Basic > Font: Inconsolata Regular 14pt
9. Sett opp ssh-key:
   - `ssh-keygen -t rsa`
   - `cat ~/.ssh/id_rsa.pub`
   - Legg til key i [GitHub settings](https://github.com/settings/keys)
10. Launch IntelliJ
    - Last ned Plugin "Settings Repository"
    - File > Manage IDE Settings > Settings Repository
    - https://github.com/akselw/intellij-settings
    - Overwrite Local
    - Opprett Personal Access Token
        - Github
        - Settings
        - Developer Settings
        - Personal access tokens
        - Generate new token
        - repo og workflow
11. Setup zsh med:
   
    ```
    ./setupZsh.sh
    ```

12. Fiks shortcuts for Mac: [instruksjoner](./shortcuts.md)
13. Setup Emacs:
    - Endre ~/.emacs til følgende:
    ```
    (load-file "~/Projects/mac-setup/emacsconfig.el")
    ```
    - Start emacs
    - Skriv `M-x`, så `package-refresh-contents` (`M-x` betyr `Escape`, så `x`)
    - Restart emacs for å sjekke at det fungerte

14. Setup git med:

    ```
    ./setupGit.sh
    ```
