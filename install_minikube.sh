#!/bin/sh

CURRENT=$(minikube version 2>/dev/null | head -1 | sed 's/minikube version: \([v0-9.]\+\)/\1/')
VERSION=$(curl --silent --location https://api.github.com/repos/kubernetes/minikube/releases/latest | jq --raw-output .tag_name)
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest minikube ${CURRENT}"
	exit
fi
echo "Installing minikube ${VERSION} over ${CURRENT:-None}"
curl --silent --location https://storage.googleapis.com/minikube/releases/${VERSION}/minikube-$(uname --kernel-name | tr '[:upper:]' '[:lower:]')-$(dpkg --print-architecture) > /usr/local/bin/minikube \
	&& chmod +x /usr/local/bin/minikube
minikube completion bash > /etc/bash_completion.d/minikube
