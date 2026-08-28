#!/usr/bin/env bash

set -euo pipefail

echo "disabling avahi..."

systemctl disable avahi-daemon.socket
systemctl mask avahi-daemon.socket

systemctl disable avahi-daemon.service
systemctl mask avahi-daemon.service
