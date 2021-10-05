#!/bin/sh

CURRENT=$(docker compose version --short 2>/dev/null)
VERSION=$(curl --silent --location https://api.github.com/repos/docker/compose/releases/latest | jq --raw-output .tag_name)
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest docker-compose ${CURRENT}"
	exit
fi
echo "Installing docker-compose ${VERSION} over ${CURRENT:-None}"
mkdir --parent /usr/local/lib/docker/cli-plugins
curl --silent --location https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname --kernel-name)-$(uname --machine) > /usr/local/lib/docker/cli-plugins/docker-compose \
	&& chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
#curl --silent --location https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
