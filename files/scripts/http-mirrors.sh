#!/usr/bin/env bash
# Use https mirrors

set -euo pipefail

for repo in /etc/yum.repos.d/*.repo; do
    sed -i 's/metalink?/metalink?protocol=https\&/g' "${repo}"
done
