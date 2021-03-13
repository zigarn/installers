#!/bin/sh

CURRENT=$(codium --user-data-dir /dev/null --version 2>/dev/null | head -1)
VERSION=$(curl --silent --location https://api.github.com/repos/VSCodium/vscodium/releases/latest | jq --raw-output .tag_name)
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest VSCodium ${CURRENT}"
	exit
fi
echo "Installing VSCodium ${VERSION} over ${CURRENT:-None}"
PACKAGE=$(mktemp --dry-run).deb
DOWNLOAD_URL=$(curl --silent --location https://api.github.com/repos/VSCodium/vscodium/releases/latest | jq --raw-output '(.assets[] | select(.name | test(".*_amd64.deb$"))).browser_download_url')
curl --silent --location -o ${PACKAGE} ${DOWNLOAD_URL}
apt install ${PACKAGE}
rm --force ${PACKAGE}
