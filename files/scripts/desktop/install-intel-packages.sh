#!/usr/bin/env bash

set -euo pipefail

dnf -y --enable-repo="rpmfusion-nonfree" install libva-intel-driver
