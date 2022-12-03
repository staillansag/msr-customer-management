#!/bin/bash
. ./buildScripts/setEnv.sh

echo "Getting service principal credentials..."
if [ ! -f "${ACRSPCREDENTIALS_SECUREFILEPATH}" ]; then
  echo "Secure file path not present: ${ACRSPCREDENTIALS_SECUREFILEPATH}"
  exit 1
fi

chmod u+x "${ACRSPCREDENTIALS_SECUREFILEPATH}"
. "${ACRSPCREDENTIALS_SECUREFILEPATH}"

echo "Docker install"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "kubectl install"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" > /dev/null

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl || exit 1

kubectl version --client || exit 1

echo "Getting kubectl config..."
if [ ! -f "${KUBECTLCONFIG_SECUREFILEPATH}" ]; then
  echo "Secure file path not present: ${KUBECTLCONFIG_SECUREFILEPATH}"
  exit 1
fi

mkdir ~/.kube
cp "${KUBECTLCONFIG_SECUREFILEPATH}" ~/.kube/config

kubectl get nodes || exit 1

echo "Creating K8S secret to connect to the SAG Docker registry"
kubectl create secret docker-registry sagregcred --docker-server=sagcr.azurecr.io --docker-username="${SAG_ACR_SP_ID}" --docker-password="${SAG_ACR_SP_SECRET}" --docker-email="${MY_EMAIL_ADDRESS}"

echo "Creating K8S secret to connect to the stt Docker registry"
kubectl create secret docker-registry sttregcred --docker-server="${MY_AZ_ACR_URL}" --docker-username="${AZ_ACR_SP_ID}" --docker-password="${AZ_ACR_SP_SECRET}" --docker-email="${MY_EMAIL_ADDRES}"

echo "Getting kubernetes secrets..."
if [ ! -f "${KUBERNETESSECRETS_SECUREFILEPATH}" ]; then
  echo "Secure file path not present: ${KUBERNETESSECRETS_SECUREFILEPATH}"
  exit 1
fi

kubectl apply -f "${KUBERNETESSECRETS_SECUREFILEPATH}"