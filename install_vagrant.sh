#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/hashicorp/vagrant/tags | jq --raw-output '.[0].name | sub("^v"; "")')
echo "Installing vagrant ${VERSION}"
ARCHIVE=$(mktemp)
curl --silent --location -o ${ARCHIVE} https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_$(uname --kernel-name | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip \
	&& unzip -oqq ${ARCHIVE} -d /usr/local/bin/
rm --force ${ARCHIVE}
curl --silent --location https://raw.githubusercontent.com/hashicorp/vagrant/master/contrib/bash/completion.sh > /etc/bash_completion.d/vagrant
