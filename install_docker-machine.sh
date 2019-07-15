#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/docker/machine/releases/latest | jq --raw-output .tag_name)
echo "Installing docker-machine ${VERSION}"
curl --silent --location https://github.com/docker/machine/releases/download/${VERSION}/docker-machine-$(uname --kernel-name)-$(uname --machine) > /usr/local/bin/docker-machine \
	&& chmod +x /usr/local/bin/docker-machine
curl --silent --location https://raw.githubusercontent.com/docker/machine/${VERSION}/contrib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker-machine-wrapper
curl --silent --location https://raw.githubusercontent.com/docker/machine/${VERSION}/contrib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-machine-prompt
curl --silent --location https://raw.githubusercontent.com/docker/machine/${VERSION}/contrib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine
