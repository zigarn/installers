#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/hashicorp/terraform/releases/latest | jq --raw-output '.tag_name | sub("v"; "")')
echo "Installing terraform ${VERSION}"
ARCHIVE=$(mktemp)
curl --silent --location -o ${ARCHIVE} https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_$(uname --kernel-name | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip \
	&& unzip -oqq ${ARCHIVE} -d /usr/local/bin/
rm --force ${ARCHIVE}
curl --silent --location https://raw.githubusercontent.com/Bash-it/bash-it/master/completion/available/terraform.completion.bash > /etc/bash_completion.d/terraform
