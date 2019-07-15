#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/hashicorp/vagrant/tags | jq --raw-output '.[0].name | sub("^v"; "")')
echo "Installing vagrant ${VERSION}"
PACKAGE=$(mktemp)
curl --silent --location -o ${PACKAGE} https://releases.hashicorp.com/vagrant/${VERSION}/vagrant_${VERSION}_$(uname --machine).deb \
	&& dpkg --install ${PACKAGE}
rm --force ${PACKAGE}
curl --silent --location https://raw.githubusercontent.com/hashicorp/vagrant/master/contrib/bash/completion.sh > /etc/bash_completion.d/vagrant
