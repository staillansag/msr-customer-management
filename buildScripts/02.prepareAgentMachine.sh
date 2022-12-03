echo "Docker install"i
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "kubectl install"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check || exit 1

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl || exit 1

kubectl version --client || exit 1

echo "Checking kubectl config file"
ls -l "${KUBECTLCONFIG_SECUREFILEPATH}"

echo "Display location of kubectl config"
sudo echo "${KUBECONFIG}"

