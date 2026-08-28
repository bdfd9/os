#!/usr/bin/env bash

set -euo pipefail

systemctl disable flatpak-add-fedora-repos.service
rm -f /usr/lib/systemd/system/flatpak-add-fedora-repos.service
