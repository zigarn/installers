#!/bin/sh

CURRENT=v$(kind version --quiet)
VERSION=$(curl --silent --location https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq --raw-output .tag_name)
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest kind ${CURRENT}"
	exit
fi
echo "Installing kind ${VERSION} over ${CURRENT:-None}"
curl --silent --location --output /usr/local/bin/kind https://kind.sigs.k8s.io/dl/${VERSION}/kind-linux-amd64
chmod +x /usr/local/bin/kind
kind completion bash > /etc/bash_completion.d/kind
