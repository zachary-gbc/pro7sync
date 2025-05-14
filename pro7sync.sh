#!/bin/bash

# 1 = manual
# 2 = direction (up, down, both)

logdatetime=$(date +%F_%H:%M:%S)
direction=$2

echo "$logdatetime - Running Sync Now";

if [[ $direction == "both" ]] || [[ $direction == "up" ]]
then
  rsync -qrtu --exclude="LibraryData" ~/Documents/ProPresenter/Libraries/ ~/Sync/ProPresenter_Shared_Content/Libraries/
  rsync -qrtu ~/Documents/ProPresenter/Themes/ ~/Sync/ProPresenter_Shared_Content/Themes/
  rsync -qrtu ~/Library/Fonts/ ~/Sync/ProPresenter_Shared_Content/Fonts/
fi

if [[ $direction == "both" ]] || [[ $direction == "down" ]]
then
  rsync -qrtu --exclude="LibraryData" ~/Sync/ProPresenter_Shared_Content/Libraries/ ~/Documents/ProPresenter/Libraries/
  rsync -qrtu ~/Sync/ProPresenter_Shared_Content/Themes/ ~/Documents/ProPresenter/Themes/
  rsync -qrtu ~/Sync/ProPresenter_Shared_Content/Fonts/ ~/Library/Fonts/
fi

echo "$logdatetime - Sync Complete"
