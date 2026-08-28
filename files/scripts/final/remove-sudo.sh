#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright 2025-2026 The Secureblue Authors

set -euo pipefail

SUDO_PACKAGES_TO_REMOVE=()

if [[ "${IMAGE_NAME}" != *"kinoite"* ]]; then
    SUDO_PACKAGES_TO_REMOVE+=('sudo')
fi

if [[ "${IMAGE_NAME}" != *"coreos"* ]]; then
    SUDO_PACKAGES_TO_REMOVE+=('sudo-python-plugin')
fi

dnf remove -y --setopt=protected_packages=, "${SUDO_PACKAGES_TO_REMOVE[@]}"

rm -rf /usr/bin/sudo
