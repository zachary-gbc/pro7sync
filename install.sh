#! /bin/bash

rm -rf ~/Documents/Scripts/pro7sync
git clone --depth=1 https://github.com/zachary-gbc/pro7sync ~/Documents/Scripts/pro7sync
mv -f ~/Documents/Scripts/pro7sync/* ~/Documents/Scripts
rm -f ~/Documents/Scripts/readme.md
rm -rf ~/Documents/Scripts/pro7sync
chmod +x ~/Documents/Scripts/*.sh

echo "Scripts Installed"
