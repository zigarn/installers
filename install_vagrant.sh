#!/bin/sh

CURRENT=$(vagrant --version 2>/dev/null | sed 's/Vagrant \([0-9.]\+\)/\1/')
VERSION=$(curl --silent --location https://api.github.com/repos/hashicorp/vagrant/tags | jq --raw-output '.[0].name | sub("^v"; "")')
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest vagrant ${CURRENT}"
	exit
fi
echo "Installing vagrant ${VERSION} over ${CURRENT:-None}"
ARCHIVE=$(mktemp)
curl --silent --location -o ${ARCHIVE} https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_$(uname --kernel-name | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip \
	&& unzip -oqq ${ARCHIVE} -d /usr/local/bin/
rm --force ${ARCHIVE}
curl --silent --location https://raw.githubusercontent.com/hashicorp/vagrant/master/contrib/bash/completion.sh > /etc/bash_completion.d/vagrant
