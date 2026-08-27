#!/usr/bin/env bash

set -euo pipefail

echo "disabling iscsi..."

systemctl disable iscsid.service 2>/dev/null || true
systemctl mask iscsid.service 2>/dev/null || true

systemctl disable iscsid.socket 2>/dev/null || true
systemctl mask iscsid.socket 2>/dev/null || true

systemctl disable iscsiuio.service 2>/dev/null || true
systemctl mask iscsiuio.service 2>/dev/null || true

systemctl disable iscsiuio.socket 2>/dev/null || true
systemctl mask iscsiuio.socket 2>/dev/null || true
