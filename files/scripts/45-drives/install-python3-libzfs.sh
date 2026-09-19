#!/usr/bin/env bash

set -euox pipefail

tmp_dir=$(mktemp -d)

function cleanup() {
    rm -rf "${tmp_dir}"
    dnf remove -y python3-cython
    exit
}

trap cleanup ERR EXIT

cd "${tmp_dir}"

dnf install -y --setopt=install_weak_deps=False python3-cython

wget --tries=5 https://github.com/bdfd9/python3-libzfs/archive/refs/tags/v2.4.1-4-fork.tar.gz

tar -z -x --no-same-owner --no-same-permissions -f "v2.4.1-4-fork.tar.gz"

cd python3-libzfs-2.4.1-4-fork

./configure --prefix=/usr && PREFIX=/usr make install

cd -
