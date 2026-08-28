#!/usr/bin/env bash

set -euo pipefail

echo "disabling sssd..."

systemctl disable sssd.service
systemctl mask sssd.service

systemctl disable sssd-kcm.service
systemctl mask sssd-kcm.service

systemctl disable sssd-kcm.socket
systemctl mask sssd-kcm.socket
