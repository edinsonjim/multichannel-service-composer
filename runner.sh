#!/bin/bash

echo "Multichannel Service Runner"

registries = (pratica documentmanager tabelledominio)

WORKDIR=$PWD
REPOSITORY_NAME="multichannel_service"

if [[ "$2" == '--pull']]
then
    echo "[INFO] Pulling multichannel_service"
    git fetch
    git pull
fi

if [[ "$1" == "--build" ]]
then

    echo "[INFO] Overwriting standalone"
    cp -r ./standalone.xml /opt/rh/jboss-eap-6.4/standalone/configuration/standalone.xml

    for registry in ${registries[@]} do
    
        echo "[INFO] Building $registry"
        cd "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.atomicservice/multichannel.atomicservice.$registry"
        mvn clean install -DskipTests

        cd "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.compositeservice/multichannel.compositeservice.$registry"
        mvn clean install -DskipTests

        echo "[INFO] Deploying $registry"
        cp -r "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.atomicservice/multichannel.atomicservice.$registry/multichannel.atomicservice.$registry.deploy/target/multichannel.atomicservice.$registry.ear" /opt/rh/jboss-eap-6.4/standalone/deployments
        cp -r "$WORKDIR/$REPOSITORY_NAME/it.ifis.multichannel/multichannel.compositeservice/multichannel.compositeservice.$registry/multichannel.compositeservice.$registry.deploy/target/multichannel.compositeservice.$registry.ear" /opt/rh/jboss-eap-6.4/standalone/deployments
    done

    # cd multichannel_service
    

    # echo "[INFO] Compiling package"
    # mvn clean package -DskipTests
    # mvn clean install -DskipTests

    # echo "[INFO] Installing packages"
    # cp -r ./it.ifis.multichannel/multichannel.atomicservice/multichannel.atomicservice.pratica/multichannel.atomicservice.pratica.deploy/target/multichannel.atomicservice.pratica.ear /opt/rh/jboss-eap-6.4/standalone/deployments
    # cp -r ./it.ifis.multichannel/multichannel.compositeservice/multichannel.compositeservice.pratica/multichannel.compositeservice.pratica.deploy/target/multichannel.compositeservice.pratica.ear /opt/rh/jboss-eap-6.4/standalone/deployments

fi

echo "[INFO] Running server"
bash /opt/rh/jboss-eap-6.4/bin/standalone.sh

echo "[INFO] Good Job!"
