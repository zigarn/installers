#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/docker/compose/releases/latest | jq --raw-output .tag_name)
echo "Installing docker-compose ${VERSION}"
curl --silent --location https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname --kernel-name)-$(uname --machine) > /usr/local/bin/docker-compose \
	&& chmod +x /usr/local/bin/docker-compose
curl --silent --location https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
