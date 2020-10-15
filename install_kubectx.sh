#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq --raw-output .tag_name)
echo "Installing kubectx ${VERSION}"
curl --silent --location https://github.com/ahmetb/kubectx/releases/download/${VERSION}/kubectx_${VERSION}_linux_x86_64.tar.gz | tar xzf - --directory /usr/local/bin/ kubectx
ln -sf kubectx /usr/local/bin/kubectl-ctx
curl --silent --location https://github.com/ahmetb/kubectx/releases/download/${VERSION}/kubens_${VERSION}_linux_x86_64.tar.gz | tar xzf - --directory  /usr/local/bin/ kubens
ln -sf kubens /usr/local/bin/kubectl-ns
curl --silent --location https://raw.githubusercontent.com/ahmetb/kubectx/${VERSION}/completion/kubectx.bash > /etc/bash_completion.d/kubectx
curl --silent --location https://raw.githubusercontent.com/ahmetb/kubectx/${VERSION}/completion/kubens.bash > /etc/bash_completion.d/kubens
