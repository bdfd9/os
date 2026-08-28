#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright 2025-2026 The Secureblue Authors

set -euo pipefail

echo "enabling faillock in PAM authentication profile..."

authselect enable-feature with-faillock 1> /dev/null
