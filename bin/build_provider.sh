#!/usr/bin/env bash

PLUGIN_DIR="~/.terraform.d/plugins/local.providers/local.terratowns/1.0.0"
PLUGIN_NAME="terraform-provider-terratowns_v1.0.0"

cd ${PROJECT_ROOT}/terraform-provider-terratowns
cp ${PROJECT_ROOT}/terraformrc /home/gitpod/.terraformrc

rm -rf ~/.terraform.d/plugins
rm -rf ${PROJECT_ROOT}/.terraform.lock.hcl
go build -o $PLUGIN_NAME

mkdir -p ${PLUGIN_DIR}/x86_64
mkdir -p ${PLUGIN_DIR}/linux_amd

cp $PLUGIN_NAME ${PLUGIN_DIR}/x86_64
cp $PLUGIN_NAME ${PLUGIN_DIR}/linux_amd