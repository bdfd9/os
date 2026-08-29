#!/usr/bin/env bash

set -euo pipefail

dnf -y --enable-repo="rpmfusion-nonfree" install intel-media-driver
