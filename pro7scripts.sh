#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)
host=$(hostname -s)
echo "$logdatetime - Pro7 Scripts Started"

processnumber=$(ps aux | grep -v grep | grep -ci "ProPresenter")
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

while read line; do
  IFS=' || ' read -ra items <<< "$line"
  if [[ ${items[0]} == $host ]]
  then
    backupfolder=${items[2]}
    machinebackup=${items[4]}
    syncdirection=${items[6]}
    machineset="yes"
  fi
done <~/Sync/ProPresenter_Shared_Content/machines.txt

if [[ $machineset == "no" ]]
then
  echo "Machine ($host) Not Setup in File"
  exit 1
fi
if [[ $processnumber == 0 ]]; then prorunning="no"; fi

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

if [[ $runbackup == "yes" ]]
then
  bash ~/Documents/Scripts/pro7backup.sh $manualbackup $backupfolder
fi

if [[ $runsync == "yes" ]]
then
  bash ~/Documents/Scripts/pro7sync.sh $manualsync $syncdirection
  bash ~/Documents/Scripts/pro7deletes.sh
fi
