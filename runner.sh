#!/bin/bash

echo "Multichannel Service Runner"

if [[ "$1" == --build ]]
then
    cd multichannel_service
    echo "[INFO] Pulling multichannel_service"
    git fetch
    git pull

    echo "[INFO] Overwriting standalone"
    cp -r ./standalone.xml /opt/rh/jboss-eap-6.4/standalone/configuration/standalone.xml

    echo "[INFO] Compiling package"
    # mvn clean package -DskipTests
    mvn clean install -DskipTests

    echo "[INFO] Installing packages"
    cp -r ./it.ifis.multichannel/multichannel.atomicservice/multichannel.atomicservice.pratica/multichannel.atomicservice.pratica.deploy/target/multichannel.atomicservice.pratica.ear /opt/rh/jboss-eap-6.4/standalone/deployments
    cp -r ./it.ifis.multichannel/multichannel.compositeservice/multichannel.compositeservice.pratica/multichannel.compositeservice.pratica.deploy/target/multichannel.compositeservice.pratica.ear /opt/rh/jboss-eap-6.4/standalone/deployments

fi

echo "[INFO] Running server"
bash /opt/rh/jboss-eap-6.4/bin/standalone.sh

echo "[INFO] Good Job!"
