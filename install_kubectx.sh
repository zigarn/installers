#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq --raw-output .tag_name)
echo "Installing kubectx ${VERSION}"
curl --silent --location https://raw.githubusercontent.com/ahmetb/kubectx/${VERSION}/kubectx > /usr/local/bin/kubectx \
	&& chmod +x /usr/local/bin/kubectx
curl --silent --location https://raw.githubusercontent.com/ahmetb/kubectx/${VERSION}/kubens > /usr/local/bin/kubens \
	&& chmod +x /usr/local/bin/kubens
curl --silent --location https://raw.githubusercontent.com/ahmetb/kubectx/${VERSION}/completion/kubectx.bash > /etc/bash_completion.d/kubectx
curl --silent --location https://raw.githubusercontent.com/ahmetb/kubectx/${VERSION}/completion/kubens.bash > /etc/bash_completion.d/kubens
