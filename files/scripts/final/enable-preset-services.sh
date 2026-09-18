#!/usr/bin/env bash

set -euo pipefail

systemctl preset-all
systemctl --global preset-all
