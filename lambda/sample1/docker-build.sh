#!/bin/bash
set -euo pipefail

REGION=ap-northeast-1
ECR_URI=081669467456.dkr.ecr.ap-northeast-1.amazonaws.com
IMAGE_NAME=lambda/sample-function
REPOS_URI=${ECR_URI}/${IMAGE_NAME}
REQUESTS_LAYER_REPOS_URI=${ECR_URI}/lambda/sample-layer
REQUESTS_LAYER_IMAGE_TAG=20221217211322
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Docker image build
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_URI}

docker buildx build --platform=linux/arm64 \
  --build-arg REQUESTS_LAYER_REPOS_URI=${REQUESTS_LAYER_REPOS_URI} \
  --build-arg REQUESTS_LAYER_IMAGE_TAG=${REQUESTS_LAYER_IMAGE_TAG} \
  -t ${IMAGE_NAME}:${TIMESTAMP} .

# docker tag ${IMAGE_NAME}:${TIMESTAMP} ${REPOS_URI}:${TIMESTAMP}

# docker push ${REPOS_URI}:${TIMESTAMP}