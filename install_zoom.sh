#!/bin/sh

CURRENT=$(dpkg-query --showformat='${Version}' --show zoom 2>/dev/null)
PACKAGE=$(mktemp)
curl --silent --location -o ${PACKAGE} https://us02web.zoom.us/client/latest/zoom_amd64.deb
VERSION=$(dpkg-deb --field ${PACKAGE} Version)
if [ "${CURRENT}" = "${VERSION}" ]; then
	echo "Already latest zoom ${CURRENT}"
	exit
fi
echo "Installing zoom ${VERSION} over ${CURRENT:-None}"
apt install ${PACKAGE}
rm --force ${PACKAGE}
