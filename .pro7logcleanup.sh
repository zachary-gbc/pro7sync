#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)
echo "$logdatetime - Running Log Cleanup Now";

onemonthago=$(date -v-1m +%Y-%m)
machine=$(<~/Documents/Scripts/Pro7Sync/.machine.txt)

if [[ -f ~/Sync/ProPresenter_Shared_Content/Logs/${machine}_log.txt ]]
then
    sed -i "" "/$onemonthago/d" ~/Sync/ProPresenter_Shared_Content/Logs/${machine}_log.txt
    sed -i "" "/$onemonthago/d" ~/Sync/ProPresenter_Shared_Content/Logs/${machine}_errlog.txt
fi

rm -f ~/Sync/ProPresenter_Shared_Content/Logs/*CONFLICT*.txt
