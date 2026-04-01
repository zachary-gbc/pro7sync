#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)

echo "$logdatetime - Running Deletes Now";

declare -a areas=("Libraries" "Themes" "Fonts")

for area in "${areas[@]}"
do
  while read line; do
    if [[ $line != "" ]]
    then
      if [[ ${line:0:1} != "#" ]]
      then
        exists="no"
        local_item="${HOME}/Documents/ProPresenter/$area/$line"
        sync_item="${HOME}/Sync/ProPresenter_Shared_Content/$area/$line"
        mv_path="${HOME}/Sync/ProPresenter_Shared_Content/Deletes/$area/$line"

        if [[ -d "$local_item" ]] || [[ -f "$local_item" ]]; then exists="yes"; fi
        if [[ $exists == "yes" ]]
        then
          directory=${mv_path%/*}
          mkdir -p "$directory"
          mv -f "$local_item" "$mv_path"
          rm -rf "$local_item"
          rm -rf "$sync_item"
          echo "$logdatetime - Removed: $line"
        fi

        if [[ "$line" == *"*"* ]]
        then
          rm -rf $local_item
          rm -rf $sync_item
          echo "$logdatetime - Removed: $line"
        fi
      fi
    fi
  done <~/Sync/ProPresenter_Shared_Content/Deletes/$area.txt
done

cd ~/Documents/ProPresenter/Libraries
find . -name "*-CONFLICT-*" -delete
cd ~/Documents/ProPresenter/Themes
find . -name "*-CONFLICT-*" -delete
cd ~/Sync/ProPresenter_Shared_Content/Libraries
find . -name "*-CONFLICT-*" -delete
cd ~/Sync/ProPresenter_Shared_Content/Themes
find . -name "*-CONFLICT-*" -delete

echo "$logdatetime - Deletes Complete"
