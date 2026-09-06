#!/usr/bin/env bash

set -euox pipefail

KERNEL_VERSION="$(rpm -q "kernel" --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
dnf install -y --setopt=install_weak_deps=False "kernel-devel-matched-${KERNEL_VERSION}"

wget --tries=5 https://github.com/bdfd9/mchose-battery/archive/refs/tags/v1.0.3.tar.gz

tar -z -x --no-same-owner --no-same-permissions -f "v1.0.3.tar.gz"

cd mchose-battery-1.0.3

make install

cd .. && rm -rf mchose-battery-1.0.3

depmod -a -v "${KERNEL_VERSION}"
