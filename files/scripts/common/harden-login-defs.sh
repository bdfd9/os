#!/usr/bin/env bash

set -euo pipefail

PATCH_ARGS=("--forward" "--strip=1" "--no-backup-if-mismatch")

patch /etc/login.defs "${PATCH_ARGS[@]}" < common/harden-login-defs.patch
