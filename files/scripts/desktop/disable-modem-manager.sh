#!/usr/bin/env bash

set -euo pipefail

echo "disabling ModemManager..."

systemctl disable ModemManager.service
systemctl mask ModemManager.service
