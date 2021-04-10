# Set up Mac

1. Set up iCloud 
2. Installer Brew med:

    ```
    ./installBrew.sh
    ```

3. Installer ting gjennom Brew:

    ```
    ./brewInstallConfig.sh
    ```

3. Launch 1Password
4. Last ned Magnet fra App Store
5. Launch IntelliJ
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
6. Setup zsh med:
   
    ```
    ./setupZsh.sh
    ```

7. Fiks shortcuts for Mac
8. Setup Emacs ved å endre ~/.emacs til følgende:

    ```
    (load-file "~/Projects/mac-setup/emacsconfig")
    ```
9. Setup git med:

    ```
    ./setupGit.sh
    ```
