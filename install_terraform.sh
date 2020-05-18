#!/bin/sh

CURRENT=$(terraform version 2>/dev/null | head -1 | sed 's/Terraform v\([0-9.]\+\)/\1/')
VERSION=$(curl --silent --location https://api.github.com/repos/hashicorp/terraform/releases/latest | jq --raw-output '.tag_name | sub("v"; "")')
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest terraform ${CURRENT}"
	exit
fi
echo "Installing terraform ${VERSION} over ${CURRENT:-None}"
ARCHIVE=$(mktemp)
curl --silent --location -o ${ARCHIVE} https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_$(uname --kernel-name | tr '[:upper:]' '[:lower:]')_$(dpkg --print-architecture).zip \
	&& unzip -oqq ${ARCHIVE} -d /usr/local/bin/
rm --force ${ARCHIVE}
curl --silent --location https://raw.githubusercontent.com/Bash-it/bash-it/master/completion/available/terraform.completion.bash > /etc/bash_completion.d/terraform
