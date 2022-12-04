#!/bin/bash
. ./buildScripts/setEnv.sh

echo "Getting service principal credentials..."
if [ ! -f "${ACRSPCREDENTIALS_SECUREFILEPATH}" ]; then
  echo "Secure file path not present: ${ACRSPCREDENTIALS_SECUREFILEPATH}"
  exit 1
fi

chmod u+x "${ACRSPCREDENTIALS_SECUREFILEPATH}"
. "${ACRSPCREDENTIALS_SECUREFILEPATH}"

if [ -z ${AZ_ACR_SP_ID+x} ]; then
  echo "Secure information has not been sourced correctly"
  exit 2
fi

echo "Dumping environment for demo purposes"
env | sort

echo "Logging in to repository ${MY_AZ_ACR_URL}"
docker login -u "${AZ_ACR_SP_ID}" -p "${AZ_ACR_SP_SECRET}" "${MY_AZ_ACR_URL}"  || exit 3

echo "Building tag ${OUR_SERVICE_TAG_BASE}"
docker build \
  --build-arg __from_img=${AZ_BASE_IMAGE_TAG} \
  -t "${OUR_SERVICE_TAG_BASE}" . || exit 4

echo "Environment file for testing: ${DOCKERENV_SECUREFILEPATH}"
docker run --name msr-customer-management -dp 5555:5555 -d --env-file ${DOCKERENV_SECUREFILEPATH} "${OUR_SERVICE_TAG_BASE}"

max_retry=10
counter=1
until curl -s -o /dev/null http://localhost:5555
do
   sleep 10
   [[ counter -gt $max_retry ]] && echo "Docker container did not start" && exit 1
   echo "Trying again to access MSR admin URL. Try #$counter"
   ((counter++))
done

echo "Basic sanity check of the generated docker image"
curl -s -o /dev/null --location --request GET 'http://localhost:5555/customer-management/customers' \
--header 'Authorization: Basic QWRtaW5pc3RyYXRvcjptYW5hZ2U=a' && echo "Test passed" || exit 4 

crtTag="${OUR_SERVICE_TAG_BASE}:${OUR_SERVICE_MAJOR_VERSION}.${OUR_SERVICE_MINOR_VERSION}.${BUILD_BUILDID}"

echo "Tagging ${OUR_SERVICE_TAG_BASE} to ${crtTag}"
docker tag "${OUR_SERVICE_TAG_BASE}" "${crtTag}"

echo "==================> BUILD_REASON = ${BUILD_REASON}"

echo "Pushing tag ${crtTag}"
docker push "${crtTag}"

if [[ "${BUILD_SOURCEBRANCHNAME}" == "main" ]]; then
  echo "Pushing tag ${OUR_SERVICE_TAG_BASE}"
  docker push "${OUR_SERVICE_TAG_BASE}"
fi

echo "Logging out"
docker logout "${MY_AZ_ACR_URL}"

echo "Push completed"