#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright 2025 Universal Blue
# SPDX-FileCopyrightText: Copyright 2025-2026 The Secureblue Authors

set -euo pipefail

mkdir -p /var/tmp
chmod 1777 /var/tmp

NVIDIA_REPO="fedora-nvidia"

KERNEL_VERSION="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

export LD=ld.bfd

dnf install -y --setopt=install_weak_deps=False "kernel-devel-matched-${KERNEL_VERSION}"

dnf install -y --setopt=install_weak_deps=False akmods gcc-c++

# TODO remove this when fixed upstream
sed -i.backup -e '/if \[\[ -w \/var \]\] ; then/,/fi/d' /usr/sbin/akmodsbuild

dnf install -y --setopt=install_weak_deps=False \
    --enable-repo="${NVIDIA_REPO}" \
    --disable-repo='fedora-multimedia' \
    nvidia-kmod-common nvidia-modprobe akmod-nvidia

echo "Installing kmod..."
akmods --force --kernels "${KERNEL_VERSION}" --kmod "nvidia"

mv /usr/sbin/akmodsbuild.backup /usr/sbin/akmodsbuild

modinfo /usr/lib/modules/"${KERNEL_VERSION}"/extra/nvidia/nvidia{,-drm,-modeset,-peermem,-uvm}.ko.xz > /dev/null || \
    { cat /var/cache/akmods/nvidia/*.failed.log && exit 1; }

# View license information
modinfo -l /usr/lib/modules/"${KERNEL_VERSION}"/extra/nvidia/nvidia{,-drm,-modeset,-peermem,-uvm}.ko.xz

systemctl disable akmods-keygen@akmods-keygen.service
systemctl mask akmods-keygen@akmods-keygen.service
systemctl disable akmods-keygen.target
systemctl mask akmods-keygen.target
