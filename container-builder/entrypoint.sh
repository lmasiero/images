#!/bin/bash
set -xe

SOURCE_TYPE=$1
BUILD_TYPE=$2

if [[ $IMAGE_TAG =~ "gcr\.io/.*" ]]; then
  gcloud docker -a
fi

if [ "$SOURCE_TYPE" = 'git-repo' ]; then
    git clone $GIT_REPO repo
elif [ "$SOURCE_TYPE" = 'cloud-soure-repo' ]; then
    gcloud source repos clone $REPO_NAME repo
else
    echo "Unknown source type: $SOURCE_TYPE"
    exit 1
fi

pushd repo
  if [ "$BUILD_TYPE" = 'container-builder' ]; then
      gcloud container builds submit --tag $IMAGE_TAG .
  elif [ "$BUILD_TYPE" = 'local-docker' ]; then
      docker build -t $IMAGE_TAG .
      docker push $IMAGE_TAG
  else
      echo "Unknown build type: $BUILD_TYPE"
      exit 1
  fi
popd
