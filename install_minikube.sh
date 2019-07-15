#!/bin/sh

VERSION=$(curl --silent --location https://api.github.com/repos/kubernetes/minikube/releases/latest | jq --raw-output .tag_name)
echo "Installing minikube ${VERSION}"
curl --silent --location https://storage.googleapis.com/minikube/releases/${VERSION}/minikube-$(uname --kernel-name | tr '[:upper:]' '[:lower:]')-$(dpkg --print-architecture) > /usr/local/bin/minikube \
	&& chmod +x /usr/local/bin/minikube
minikube completion bash > /etc/bash_completion.d/minikube
