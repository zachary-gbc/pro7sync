#!/bin/bash

logdatetime=$(date +%F_%H:%M:%S)
echo "$logdatetime - Script Installer Started"

bash ~/Documents/Scripts/Pro7Sync/.pro7syncinstall.sh
