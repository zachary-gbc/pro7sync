#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)
echo "$logdatetime - Manual Backup & Sync Script Started"

bash ~/Documents/Scripts/pro7scripts.sh manual
