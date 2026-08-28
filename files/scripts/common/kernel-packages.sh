#!/usr/bin/env bash

set -euo pipefail

KERNEL_VERSION="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

dnf install -y --setopt=install_weak_deps=False "kernel-devel-matched-${KERNEL_VERSION}"
