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

