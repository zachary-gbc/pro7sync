#! /bin/bash

rm -rf ~/Documents/Scripts/pro7sync
git clone --depth=1 https://github.com/zachary-gbc/pro7sync ~/Documents/Scripts/pro7sync
mv -f ~/Documents/Scripts/pro7sync/* ~/Documents/Scripts
rm -f ~/Documents/Scripts/readme.md
rm -rf ~/Documents/Scripts/pro7sync
chmod +x ~/Documents/Scripts/*.sh
chmod +x ~/Documents/Scripts/install.command
chmod +x ~/Documents/Scripts/pro7adddelete.command
chmod +x ~/Documents/Scripts/pro7scriptsmanual.command

echo "Scripts Installed"
