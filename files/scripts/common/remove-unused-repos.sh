#!/usr/bin/env bash

set -euo pipefail

rm -f /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo
rm -f /etc/yum.repos.d/rpmfusion-nonfree-steam.repo
rm -f /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo.rpmsave
rm -f /etc/yum.repos.d/rpmfusion-nonfree-steam.repo.rpmsave

rm -f /etc/yum.repos.d/google-chrome.repo
rm -f /etc/yum.repos.d/fedora-cisco-openh264.repo
