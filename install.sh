#! /bin/bash

rm -rf ~/Documents/Scripts/pro7sync
git clone --depth=1 https://github.com/zachary-gbc/pro7sync ~/Documents/Scripts
mv -f ~/Documents/Scripts/pro7sync ~/Documents/Scripts
rm -f ~/Documents/Scripts/readme.md
rm -rf ~/Documents/Scripts/pro7sync

echo "Scripts Installed"
