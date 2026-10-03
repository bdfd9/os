#!/usr/bin/env bash

set -euox pipefail

dnf install -y --setopt=install_weak_deps=False moreutils yarnpkg

tmp_dir=$(mktemp -d)

function cleanup() {
    rm -rf "${tmp_dir}"
    dnf remove -y moreutils yarn nodejs* yarnpkg
    exit
}

trap cleanup ERR EXIT

cd "${tmp_dir}"

git clone --branch v4.6.3 --recurse-submodules https://github.com/45Drives/cockpit-file-sharing.git
cd cockpit-file-sharing

make
make install

cd -
