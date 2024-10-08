#!/bin/bash
cd /home/container
sleep 1
# Make internal Docker IP address available to processes.
export INTERNAL_IP=`hostname -I | awk '{print $1}'`

# Update Source Server
if [ ! -z ${SRCDS_APPID} ]; then
    /bin/box64/box64 ./steamcmd/steamcmd.sh +force_install_dir /home/container +login anonymous +app_update ${SRCDS_APPID} +quit
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server    
eval ${MODIFIED_STARTUP}