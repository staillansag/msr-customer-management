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
#buildah login -u "${AZ_ACR_SP_ID}" -p "${AZ_ACR_SP_SECRET}" "${MY_AZ_ACR_URL}"  || exit 3
sudo docker login -u "${AZ_ACR_SP_ID}" -p "${AZ_ACR_SP_SECRET}" "${MY_AZ_ACR_URL}"  || exit 3

echo "Building tag ${OUR_SERVICE_TAG_BASE}"
#buildah bud \
#  --build-arg __from_img=${AZ_BASE_IMAGE_TAG} \
#  --format docker \
#  -t "${OUR_SERVICE_TAG_BASE}" || exit 4

sudo docker build \
  --build-arg __from_img=${AZ_BASE_IMAGE_TAG} \
  -t "${OUR_SERVICE_TAG_BASE}" . || exit 4

echo "Checking env file"
pwd
ls -l
echo "Env file: ${DOCKERENV_SECUREFILEPATH}"

crtTag="${OUR_SERVICE_TAG_BASE}:${OUR_SERVICE_MAJOR_VERSION}.${OUR_SERVICE_MINOR_VERSION}.${BUILD_BUILDID}"

echo "Tagging ${OUR_SERVICE_TAG_BASE} to ${crtTag}"
sudo docker tag "${OUR_SERVICE_TAG_BASE}" "${crtTag}"

echo "==================> BUILD_REASON = ${BUILD_REASON}"

echo "Pushing tag ${crtTag}"
sudo docker push "${crtTag}"

if [[ "${BUILD_SOURCEBRANCHNAME}" == "main" ]]; then
  echo "Pushing tag ${OUR_SERVICE_TAG_BASE}"
  sudo docker  push "${OUR_SERVICE_TAG_BASE}"
fi

echo "Logging out"
#buildah logout "${MY_AZ_ACR_URL}"
sudo docker logout "${MY_AZ_ACR_URL}"

echo "Push completed"
