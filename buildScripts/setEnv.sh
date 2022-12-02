#!/bin/bash

# Pipeline parameters
export MY_AZ_ACR_URL="azdevopssttacr.azurecr.io"
export AZ_BASE_IMAGE_REPO="webmethods-microservicesruntime"
export AZ_BASE_IMAGE_FIXES_TAG="10.15.0.0.1"
export AZ_BASE_IMAGE_TAG="${MY_AZ_ACR_URL}/${AZ_BASE_IMAGE_REPO}:${AZ_BASE_IMAGE_FIXES_TAG}"

export AZ_ACR_REPO_NAME="msr-customer-management"
export OUR_SERVICE_TAG_BASE="${MY_AZ_ACR_URL}/${AZ_ACR_REPO_NAME}"
export OUR_SERVICE_MAJOR_VERSION="0"
export OUR_SERVICE_MINOR_VERSION="0"

