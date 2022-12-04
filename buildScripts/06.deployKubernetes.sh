 #!/bin/bash
. ./buildScripts/setEnv.sh

crtTag="${OUR_SERVICE_TAG_BASE}:${OUR_SERVICE_MAJOR_VERSION}.${OUR_SERVICE_MINOR_VERSION}.${BUILD_BUILDID}"

echo "Deploying new microservice image"
sed 's/customer\-management\:latest/customer\-management\:${crtTag}/g' ./deployment/kubernetes/01_msr-customer-management_deployment.yaml | kubectl apply -f - || exit 6

echo "Deploying service (in case it does not already exist)"
kubectl apply -f ./deployment/kubernetes/02_msr-customer-management_service.yaml || exit 6

echo "Waiting for deployment to complete"
kubectl rollout status deployment customer-management --timeout=300s && echo "Deployment complete" || exit 6

echo "Checking service (by making a call to the microgateway metrics endpoint)"
externalIP=$(kubectl get service/customer-management -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
curl -s -o /dev/null --location --request GET "http://${externalIP}/metrics" && echo "Service is up" || exit 6