#!/usr/bin/env bash

set -euo pipefail

echo "disabling cups..."

systemctl disable cups.socket
systemctl mask cups.socket

systemctl disable cups.service
systemctl mask cups.service

systemctl disable cups-browsed.service
systemctl mask cups-browsed.service
