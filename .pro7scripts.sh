#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)
machine=$(<~/Documents/Scripts/Pro7Sync/.machine)
echo "$logdatetime - Pro7 Scripts Started"

processnumber=$(ps aux | grep -v grep | grep -ci "ProPresenter.app")
currentdate=$(date +%F)
manual=$1 # options: manual, manualbackup, manualsync
syncdirection="none" # options: up, down, both
runbackup="no"
runsync="no"
manualbackup="auto"
manualsync="auto"
backupfolder="none"
backupalreadyrun="no"
lastbackupday="never"
prorunning="yes"
machinebackup="no"
machineset="no"
idletime=120
ready="no"

if [[ $manual == "manual" ]] || [[ $manual == "manualsync" ]] || [[ $manual == "manualbackup" ]]
then
    ready="yes"
    x=20
else
    x=0
fi

while read line; do
  IFS=' || ' read -ra items <<< "$line"
  if [[ ${items[0]} == $machine ]]
  then
    backupfolder=${items[2]}
    machinebackup=${items[4]}
    syncdirection=${items[6]}
    machineset="yes"
  fi
done <~/Sync/ProPresenter_Shared_Content/machines.txt

if [[ $machineset == "no" ]]
then
  echo "Machine ($machine) Not Setup in File"
  exit 1
fi

if [[ $processnumber == 0 ]]
then
    prorunning="no"
fi

if [[ $machinebackup == "yes" ]]
then
  lastbackupdate=$(<~/Sync/ProPresenter_Backups/$backupfolder/lastbackupday.txt)
  if [[ $lastbackupdate == $currentdate ]]; then backupalreadyrun="yes"; fi

  if [[ $manual == "manual" ]] || [[ $manual == "manualbackup" ]]
  then
    runbackup="yes"
    manualbackup="manual"
  elif [[ $prorunning == "no" ]] && [[ $backupalreadyrun == "no" ]]
  then
    runbackup="yes"
  fi
fi

if [[ $manual == "manual" ]] || [[ $manual == "manualsync" ]]
then
  runsync="yes"
  manualsync="manual"
elif [[ $prorunning == "no" ]] && [[ $currentday != "Sunday" ]]
then
  runsync="yes"
fi

while x <= 10
do
    ((x++))
    recentchanges=$(find "$HOME/Sync" -type f -newermt "-${idletime} seconds" 2>/dev/null)
    if [[ ! -n "$recentchanges" ]]
    then
        ready="yes"
        break
    fi
    sleep 30
done

if [[ $ready == "no" ]]
then
    echo "$logdatetime - Sync App Still Syncing, Skipping Script";
    exit 1
fi

if [[ $runbackup == "yes" ]]
then
  bash ~/Documents/Scripts/Pro7Sync/.pro7backup.sh $manualbackup $backupfolder
fi

if [[ $runsync == "yes" ]]
then
  bash ~/Documents/Scripts/Pro7Sync/.pro7sync.sh $manualsync $syncdirection
  bash ~/Documents/Scripts/Pro7Sync/.pro7deletes.sh
fi

bash ~/Documents/Scripts/Pro7Sync/.pro7logcleanup.sh
