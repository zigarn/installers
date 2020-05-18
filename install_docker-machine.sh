#!/bin/sh

CURRENT=$(docker-machine version 2>/dev/null | sed 's/docker-machine version \([0-9.]\+\), build.*/\1/')
VERSION=$(curl --silent --location https://api.github.com/repos/docker/machine/releases/latest | jq --raw-output .tag_name)
if [ "v${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest docker-machine ${CURRENT}"
	exit
fi
echo "Installing docker-machine ${VERSION} over ${CURRENT:-None}"
curl --silent --location https://github.com/docker/machine/releases/download/${VERSION}/docker-machine-$(uname --kernel-name)-$(uname --machine) > /usr/local/bin/docker-machine \
	&& chmod +x /usr/local/bin/docker-machine
curl --silent --location https://raw.githubusercontent.com/docker/machine/${VERSION}/contrib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker-machine-wrapper
curl --silent --location https://raw.githubusercontent.com/docker/machine/${VERSION}/contrib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-machine-prompt
curl --silent --location https://raw.githubusercontent.com/docker/machine/${VERSION}/contrib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine
