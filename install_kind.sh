#!/bin/sh

CURRENT=$(kind version --quiet 2>/dev/null)
VERSION=$(curl --silent --location https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq --raw-output .tag_name | sed 's/^v//')
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest kind ${CURRENT}"
	exit
fi
echo "Installing kind ${VERSION} over ${CURRENT:-None}"
curl --silent --location https://kind.sigs.k8s.io/dl/v${VERSION}/kind-linux-amd64 > /usr/local/bin/kind \
	&& chmod +x /usr/local/bin/kind
kind completion bash > /etc/bash_completion.d/kind
