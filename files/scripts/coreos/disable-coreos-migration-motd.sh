#!/usr/bin/env bash

set -euo pipefail

echo "disabling coreos-container-signing-migration-motd..."

systemctl disable coreos-container-signing-migration-motd.service 2>/dev/null || true
