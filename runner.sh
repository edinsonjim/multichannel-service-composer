#!/bin/bash

echo "Multichannel Service Runner"

registries=(pratica documentmanager tabelledominio)

WORKDIR=$PWD
REPOSITORY_NAME="multichannel_service"

if [[ "$1" == --build ]]
then
    echo "[RUNNER] [INFO] Overwriting standalone"
    cp -r ./standalone.xml /opt/rh/jboss-eap-6.4/standalone/configuration/standalone.xml

    for registry in ${registries[@]}; do
        echo "[RUNNER] [INFO] Building ${registry}"
        cd "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.atomicservice/multichannel.atomicservice.$registry"
        mvn clean install -DskipTests

        cd "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.compositeservice/multichannel.compositeservice.$registry"
        mvn clean install -DskipTests

        echo "[RUNNER] [INFO] Deploying ${registry}"
        cp -r "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.atomicservice/multichannel.atomicservice.$registry/multichannel.atomicservice.$registry.deploy/target/multichannel.atomicservice.$registry.ear" /opt/rh/jboss-eap-6.4/standalone/deployments
        cp -r "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.compositeservice/multichannel.compositeservice.$registry/multichannel.compositeservice.$registry.deploy/target/multichannel.compositeservice.$registry.ear" /opt/rh/jboss-eap-6.4/standalone/deployments
    done
fi

echo "[RUNNER] [INFO] Running server"
bash /opt/rh/jboss-eap-6.4/bin/standalone.sh

echo "[RUNNER] [INFO] Good Job!"
