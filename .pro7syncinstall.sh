#! /bin/bash

new="0"

if [[ ! -f ~/Documents/Scripts/Pro7Sync/.machine.txt ]]
then
    new="1"
else
    machine=$(<~/Documents/Scripts/Pro7Sync/.machine.txt)
fi

rm -rf ~/Documents/Scripts/Pro7Sync
rm -rf ~/Documents/Scripts/pro7sync-gh
mkdir -p ~/Documents/Scripts/Pro7Sync
git clone --depth=1 https://github.com/zachary-gbc/pro7sync ~/Documents/Scripts/pro7sync-gh
mv -f ~/Documents/Scripts/pro7sync-gh/.pro7backup.sh ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/.pro7deletes.sh ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/.pro7logcleanup.sh ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/.pro7scripts.sh ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/.pro7sync.sh ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/.pro7syncinstall.sh ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/update.command ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/manual.command ~/Documents/Scripts/Pro7Sync
mv -f ~/Documents/Scripts/pro7sync-gh/newdelete.command ~/Documents/Scripts/Pro7Sync
chmod +x ~/Documents/Scripts/Pro7Sync/.pro7backup.sh
chmod +x ~/Documents/Scripts/Pro7Sync/.pro7deletes.sh
chmod +x ~/Documents/Scripts/Pro7Sync/.pro7logcleanup.sh
chmod +x ~/Documents/Scripts/Pro7Sync/.pro7scripts.sh
chmod +x ~/Documents/Scripts/Pro7Sync/.pro7sync.sh
chmod +x ~/Documents/Scripts/Pro7Sync/.pro7syncinstall.sh
chmod +x ~/Documents/Scripts/Pro7Sync/*.command

if [[ "$new" -eq "1" ]]
then
    read -p "Please Input Machine Name from File: " machine
else
    read -p "Current Machine Name is $machine. Press Enter to Keep Current Name or Input New Name: " machinenew
    if [[ ! -z "$machinenew" ]]
    then
        machine=$machinenew
    fi
fi

echo $machine > ~/Documents/Scripts/Pro7Sync/.machine.txt

echo "Should Automation Be Turned On? (Y on N)"
read plist

if [[ $plist == "Y" ]] || [[ $plist == "y" ]]
then
    sed -i '' "s/username/$USER/g" ~/Documents/Scripts/pro7sync-gh/pro7sync.plist
    sed -i '' "s/machinename/$machine/g" ~/Documents/Scripts/pro7sync-gh/pro7sync.plist
    mkdir ~/Library/LaunchAgents
    mv ~/Documents/Scripts/pro7sync-gh/pro7sync.plist ~/Library/LaunchAgents/pro7sync.plist
    touch /Users/$USER/Sync/ProPresenter_Shared_Content/Logs/${machine}_log.txt
    touch /Users/$USER/Sync/ProPresenter_Shared_Content/Logs/${machine}_errlog.txt
    echo "Please Reboot After Script Completes"
elif [[ $plist == "N" ]] || [[ $plist == "n" ]]
then
    if [[ -f "~/Library/LaunchAgents/pro7sync.plist" ]]
    then
        rm -f ~/Library/LaunchAgents/pro7sync.plist
    fi
fi

rm -f ~/Documents/Scripts/Pro7Sync/readme.md
rm -f ~/Documents/Scripts/Pro7Sync/pro7sync.plist
rm -f ~/Documents/Scripts/Pro7Sync/update.png
rm -f ~/Documents/Scripts/Pro7Sync/manual.png
rm -f ~/Documents/Scripts/Pro7Sync/delete.png
rm -rf ~/Documents/Scripts/pro7sync-gh

echo "Scripts Installed"
