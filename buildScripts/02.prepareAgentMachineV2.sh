#!/bin/bash
. ./buildScripts/setEnv.sh

echo "Getting service principal credentials..."
if [ ! -f "${ACRSPCREDENTIALS_SECUREFILEPATH}" ]; then
  echo "Secure file path not present: ${ACRSPCREDENTIALS_SECUREFILEPATH}"
  exit 1
fi

chmod u+x "${ACRSPCREDENTIALS_SECUREFILEPATH}"
. "${ACRSPCREDENTIALS_SECUREFILEPATH}"

echo "Getting kubectl config..."
if [ ! -f "${KUBECTLCONFIG_SECUREFILEPATH}" ]; then
  echo "Secure file path not present: ${KUBECTLCONFIG_SECUREFILEPATH}"
  exit 1
fi

mkdir ~/.kube
cp "${KUBECTLCONFIG_SECUREFILEPATH}" ~/.kube/config

kubectl get nodes || exit 1
