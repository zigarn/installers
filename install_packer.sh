#!/bin/sh

CURRENT=$(packer --version 2>/dev/null)
VERSION=$(curl --silent --location https://api.github.com/repos/hashicorp/packer/tags | jq --raw-output '.[0].name | sub("^v"; "")')
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest packer ${CURRENT}"
	exit
fi
echo "Installing packer ${VERSION} over ${CURRENT:-None}"
ARCHIVE=$(mktemp)
curl --silent --location -o ${ARCHIVE} https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_$(uname --kernel-name | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip \
	&& unzip -oqq ${ARCHIVE} -d /usr/local/bin/
rm --force ${ARCHIVE}
curl --silent --location https://raw.githubusercontent.com/Bash-it/bash-it/master/completion/available/packer.completion.bash > /etc/bash_completion.d/packer
