#!/bin/bash

echo "Multichannel Service Runner"

if [[ "$1" == --pull ]]
then
    cd multichannel_service
    git fetch
    git pull
fi

echo "[INFO] Running server"
bash /opt/rh/jboss-eap-6.4/bin/standalone.sh

echo "[INFO] Good Job!"