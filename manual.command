#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)
echo "$logdatetime - Manual Backup & Sync Script Started"

bash ~/Documents/Scripts/Pro7Sync/.pro7scripts.sh manual
