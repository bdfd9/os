#!/usr/bin/env bash

set -euo pipefail

echo "disabling alsa-state..."

systemctl disable alsa-state.service
systemctl mask alsa-state.service
