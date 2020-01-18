#!/bin/bash
echo "Multichannel Service Composer"

echo "[INFO] Writing standalone file"
cp -r ./standalone.xml /opt/rh/jboss-eap-6.4/standalone/configuration/standalone.xml

echo "[INFO] Cloning multichannel_service"
git clone http://bitbucket.intranet.ifis.local/scm/mc_sr/multichannel_service.git
cd multichannel_service
git fetch
git checkout -b feature/ITCM-26053-portale-next remotes/origin/feature/ITCM-26053-portale-next

echo "[INFO] Compiling package"
mvn clean package -DskipTests

echo "[INFO] Installing packages"
cp -r ./it.ifis.multichannel/multichannel.atomicservice/multichannel.atomicservice.pratica/multichannel.atomicservice.pratica.deploy/target/multichannel.atomicservice.pratica.ear /opt/rh/jboss-eap-6.4/standalone/deployments
cp -r ./it.ifis.multichannel/multichannel.compositeservice/multichannel.compositeservice.pratica/multichannel.compositeservice.pratica.deploy/target/multichannel.compositeservice.pratica.ear /opt/rh/jboss-eap-6.4/standalone/deployments

echo "[INFO] Good Job!"
