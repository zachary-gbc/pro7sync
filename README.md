# ProPresenter Sync

## Setup Sync for Syncronization
1. In Sync root, create folder "ProPresenter_Shared_Content"
1. In Sync root, create folder "ProPresenter_Backups"
1. In Sync ProPresenter_Shared_Content folder, create following folders:
    - Deletes
    - Fonts
    - Libraries
    - Logs
    - Themes
1. In Sync ProPresenter_Shared_Content folder, create file "machines"
1. In machines file, add a line for each machine (each must be unique and no spaces) in the format:
    - Machine Name (no spaces) || Backup Folder (no spaces) || Backup (yes or no) || Sync Direction (up, down, or both)
    - Example: Main-Media || Sanctuary-Media || yes || both
    - Example: Secondary-Media || No_backup || no || down

## Setup Backup and Sync Scripts
1. Ensure Sync is running on computer, root folder is ~/Sync, and correct folders are being syncronized locally
1. Create ~/Documents/Scripts folder
1. Open System Settings, go to Privacy & Security, Full Disk Access
1. Click plus sign at the bottom and add in /bin/bash
1. Open terminal (use command+space and type terminal) and type: chmod +x ~/Documents/Scripts
1. To ensure git is installed, type: git --help (if it is not installed it should ask you to install)
1. In terminal type: git clone --depth=1 https://github.com/zachary-gbc/pro7sync ~/Documents/Scripts/pro7sync-gh
1. In terminal type: bash ~/Documents/Scripts/pro7sync-gh/pro7syncinstall.sh
1. Follow prompts on screen
1. Quit terminal
1. Reboot Computer

## Updating Sync Scripts or Changing Machine Name
1. Open Finder and go to ~Documents/Scripts/Pro7Sync
1. Double click on install.command
1. Follow prompts if any
