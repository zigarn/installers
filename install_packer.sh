#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/hashicorp/packer/tags | jq --raw-output '.[0].name | sub("^v"; "")')
echo "Installing packer ${VERSION}"
ARCHIVE=$(mktemp)
curl --silent --location -o ${ARCHIVE} https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_$(uname --kernel-name | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip \
	&& unzip -oqq ${ARCHIVE} -d /usr/local/bin/
rm --force ${ARCHIVE}
curl --silent --location https://raw.githubusercontent.com/Bash-it/bash-it/master/completion/available/packer.completion.bash > /etc/bash_completion.d/packer
