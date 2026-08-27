#!/usr/bin/env bash

set -euo pipefail

echo "::group:: ===$(basename "$0")==="

KERNEL_VERSION="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

depmod -a "${KERNEL_VERSION}"
export DRACUT_NO_XATTR=1

mkdir -p /var/tmp
/usr/bin/dracut \
  --kver "${KERNEL_VERSION}" \
  --no-hostonly \
  --reproducible \
  --zstd -v \
  --add ostree \
  -f "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

chmod 0600 "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

echo "::endgroup::"
