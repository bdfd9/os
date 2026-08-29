#!/usr/bin/env bash

set -euo pipefail

sed -i "s/UseFirmwareBackground=true/UseFirmwareBackground=false/g" /usr/share/plymouth/themes/bgrt/bgrt.plymouth
