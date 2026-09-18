#!/usr/bin/env bash

set -euox pipefail

dnf install -y --setopt=install_weak_deps=False python3-cython

wget --tries=5 https://github.com/45Drives/python3-libzfs/archive/refs/tags/v2.4.1-4.tar.gz

tar -z -x --no-same-owner --no-same-permissions -f "v2.4.1-4.tar.gz"

cd python3-libzfs-2.4.1-4

./configure && make install --prefix=/usr

dnf remove -y python3-cython
