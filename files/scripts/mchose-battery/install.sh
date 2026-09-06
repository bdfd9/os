#!/usr/bin/env bash

set -euox pipefail

KERNEL_VERSION="$(rpm -q "kernel" --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

curl -fLsS --retry 5 https://github.com/bdfd9/mchose-battery/archive/refs/tags/v1.0.0.tar.gz

tar -z -x --no-same-owner --no-same-permissions -f "v1.0.0.tar.gz"

cd mchose-battery-1.0.0

make install

depmod -a -v "${KERNEL_VERSION}"
