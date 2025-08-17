#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)

echo "$logdatetime - Running Log Cleanup Now";

onemonthago=$(date -v-1m +%Y-%m)
twomonthsago=$(date -v-2m +%Y-%m)
fileslist=$(ls ~/Sync/ProPresenter_Shared_Content/Logs/)

declare -a files=($fileslist)
for file in "${files[@]}"
do
  sed -i "" "/$onemonthago/d" ~/Sync/ProPresenter_Shared_Content/Logs/$file
  sed -i "" "/$twomonthsago/d" ~/Sync/ProPresenter_Shared_Content/Logs/$file
done

rm -f ~/Sync/ProPresenter_Shared_Content/Logs/*CONFLICT*.txt
