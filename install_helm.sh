#!/bin/sh

CURRENT=$(helm version --template '{{ .Version }}' 2>/dev/null)
VERSION=$(curl --silent --location https://api.github.com/repos/helm/helm/releases/latest | jq --raw-output .tag_name)
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest helm ${CURRENT}"
	exit
fi
echo "Installing helm ${VERSION} over ${CURRENT:-None}"
curl --silent --location https://get.helm.sh/helm-${VERSION}-linux-amd64.tar.gz | tar xzf - --directory /usr/local/bin/ --strip-components=1 linux-amd64/helm
helm completion bash > /etc/bash_completion.d/helm
