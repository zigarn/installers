#!/bin/sh

VERSION=$(curl --silent https://storage.googleapis.com/kubernetes-release/release/stable.txt)
echo "Installing kubectl ${VERSION}"
curl --silent --location http://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/$(uname --kernel-name | tr '[:upper:]' '[:lower:]')/$(dpkg --print-architecture)/kubectl > /usr/local/bin/kubectl \
	&& chmod +x /usr/local/bin/kubectl
kubectl completion bash > /etc/bash_completion.d/kubectl
