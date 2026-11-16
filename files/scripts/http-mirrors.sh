#!/usr/bin/env bash
# Use https mirrors

set -euo pipefail
shopt -s nullglob

sed -i -e 's/metalink?/metalink?protocol=https\&/g' \
    /usr/share/dnf5/repos.d/*.repo \
    /etc/yum.repos.d/*.repo
