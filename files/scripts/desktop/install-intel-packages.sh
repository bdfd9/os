#!/usr/bin/env bash

set -euo pipefail

dnf -y install \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf -y --enable-repo="rpmfusion-nonfree" install intel-media-driver

dnf -y remove rpmfusion-nonfree-release-$(rpm -E %fedora).noarch
