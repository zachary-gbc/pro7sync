#!/bin/bash

pathtoremove="/Users/$USER/"
numbertoremove=${#pathtoremove}

while true
do
  itemadded="no"

  read -p "Please add file or folder to be deleted: " item

  if [[ ${item:$numbertoremove:14} == "Library/Fonts/" ]]
  then
    echo ${item:$numbertoremove+14} >> ~/Sync/ProPresenter_Shared_Content/Deletes/Fonts.txt
    echo "Added Font: ${item:$numbertoremove+14}"
    itemadded="yes"
  fi

  if [[ ${item:$numbertoremove:30} == "Documents/ProPresenter/Themes/" ]]
  then
    echo ${item:$numbertoremove+30} >> ~/Sync/ProPresenter_Shared_Content/Deletes/Themes.txt
    echo "Added Theme Item: ${item:$numbertoremove+30}"
    itemadded="yes"
  fi

  if [[ ${item:$numbertoremove:33} == "Documents/ProPresenter/Libraries/" ]]
  then
    echo ${item:$numbertoremove+33} >> ~/Sync/ProPresenter_Shared_Content/Deletes/Libraries.txt
    echo "Added Library Item: ${item:$numbertoremove+33}"
    itemadded="yes"
  fi

  if [[ $itemadded == "no" ]]
  then
    echo "Nothing Added"
    echo "No Fonts, Library Items, or Theme Items Found"
    echo "Please Try Again"
  fi
done
