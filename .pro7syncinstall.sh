#! /bin/bash

new="0"

if [[ -f ~/Documents/Scripts/Pro7Sync/.machine ]]
then
    new="1"
else
    machine=$(<~/Documents/Scripts/Pro7Sync/.machine)
fi

mkdir -p ~/Documents/Scripts/Pro7Sync
rm -rf ~/Documents/Scripts/Pro7Sync/*
git clone --depth=1 https://github.com/zachary-gbc/pro7sync ~/Documents/Scripts/pro7sync-gh
mv -f ~/Documents/Scripts/pro7sync-gh/* ~/Documents/Scripts/Pro7Sync
chmod +x ~/Documents/Scripts/Pro7Sync/*.sh
chmod +x ~/Documents/Scripts/Pro7Sync/*.command

if [[ "$new" -eq "1" ]]
then
    echo "Please Input Machine Name from File"
    read machine
fi

echo $machine > ~/Documents/Scripts/Pro7Sync/.machine

echo "Should Automation Be Turned On? (Y on N)"
read plist

if [[ $plist == "Y" ]] || [[ $plist == "y" ]]
then
    sed -i 's/username/$USER/g' ~/Documents/Scripts/pro7sync-gh/pro7sync.plist
    sed -i 's/machinename/$machine/g' ~/Documents/Scripts/pro7sync-gh/pro7sync.plist
    mv ~/Documents/Scripts/pro7sync-gh/pro7sync.plist ~/Library/LaunchAgents/pro7sync.plist
fi

rm -f ~/Documents/Scripts/Pro7Sync/readme.md
rm -f ~/Documents/Scripts/Pro7Sync/pro7sync.plist
rm -f ~/Documents/Scripts/Pro7Sync/install.png
rm -f ~/Documents/Scripts/Pro7Sync/manual.png
rm -f ~/Documents/Scripts/Pro7Sync/delete.png
rm -rf ~/Documents/Scripts/pro7sync-gh

echo "Scripts Installed"
