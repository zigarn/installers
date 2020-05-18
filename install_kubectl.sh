#!/bin/sh

CURRENT=$(kubectl version --client --short --output=json 2>/dev/null | jq --raw-output .clientVersion.gitVersion)
VERSION=$(curl --silent https://storage.googleapis.com/kubernetes-release/release/stable.txt)
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest kubectl ${CURRENT}"
	exit
fi
echo "Installing kubectl ${VERSION} over ${CURRENT:-None}"
curl --silent --location http://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/$(uname --kernel-name | tr '[:upper:]' '[:lower:]')/$(dpkg --print-architecture)/kubectl > /usr/local/bin/kubectl \
	&& chmod +x /usr/local/bin/kubectl
kubectl completion bash > /etc/bash_completion.d/kubectl
