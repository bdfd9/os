#!/usr/bin/env bash

set -euo pipefail

echo "disabling homed..."

systemctl disable systemd-homed-activate.service
systemctl disable systemd-homed-firstboot.service
systemctl disable systemd-homed.service
