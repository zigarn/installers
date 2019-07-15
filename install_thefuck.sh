#!/bin/sh

# https://github.com/nvbn/thefuck

apt install python3-psutil python3-colorama python3-pyte python3-decorator
pip3 install thefuck --upgrade --upgrade-strategy only-if-needed
thefuck --alias > /etc/bash_completion.d/thefuck
