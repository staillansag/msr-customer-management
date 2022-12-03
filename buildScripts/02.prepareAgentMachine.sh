echo "Docker install"i
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "kubectl install"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" > /dev/null

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl || exit 1

kubectl version --client || exit 1

mkdir ~/.kube
cp "${KUBECTLCONFIG_SECUREFILEPATH}" ~/.kube/config

kubectl get nodes || exit 1

echo "Creating K8S secret to connect to the SAG Docker registry"
kubectl create secret docker-registry sagregcred --docker-server=sagcr.azurecr.io --docker-username="${SAG_ACR_SP_ID}" --docker-password="${SAG_ACR_SP_SECRET}" --docker-email="${MY_EMAIL_ADDRESS}"

echo "Creating K8S secret to connect to the stt Docker registry"
kubectl create secret docker-registry sttregcred --docker-server="${MY_AZ_ACR_URL}" --docker-username="${AZ_ACR_SP_ID}" --docker-password="${AZ_ACR_SP_SECRET}" --docker-email="${MY_EMAIL_ADDRES}"

kubectl apply -f "${KUBERNETESSECRETS_SECUREFILEPATH}"