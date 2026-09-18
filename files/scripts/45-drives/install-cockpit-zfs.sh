#!/usr/bin/env bash

set -euox pipefail

dnf install -y --setopt=install_weak_deps=False moreutils yarn

tmp_dir=$(mktemp -d)

function cleanup() {
    rm -rf "${tmp_dir}"
    dnf remove -y moreutils yarn
    exit
}

trap cleanup ERR EXIT

cd "${tmp_dir}"

git clone --branch v1.3.0 --recurse-submodules https://github.com/45Drives/cockpit-zfs.git
cd cockpit-zfs

make
make install

cd -
