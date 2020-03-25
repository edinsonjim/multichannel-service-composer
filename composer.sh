#!/bin/bash
echo "Multichannel Service Composer"

echo "[INFO] Writing standalone file"
cp -r ./standalone.xml /opt/rh/jboss-eap-6.4/standalone/configuration/standalone.xml

echo "[INFO] Cloning multichannel_service"
git clone http://bitbucket.intranet.ifis.local/scm/mc_sr/multichannel_service.git
cd multichannel_service
git fetch
git checkout -b develop origin/develop

echo "[INFO] Good Job!"
