#!/usr/bin/env bash

set -euo pipefail

coprs=(
    secureblue/packages

    zeno/scrcpy
    kylegospo/obs-vkcapture

    che/nerd-fonts
)

for copr in "${coprs[@]}"; do
    echo "Enabling copr: $copr"
    dnf5 -y copr enable "$copr"
done
