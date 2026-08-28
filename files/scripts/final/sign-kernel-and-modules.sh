#!/usr/bin/env bash

set -euo pipefail

echo "::group:: ===$(basename "$0")==="

KERNEL_VERSION="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
KERNEL_IMAGE="/usr/lib/modules/${KERNEL_VERSION}/vmlinuz"

PUBLIC_KEY_DER_PATH="/secureboot/MOK.der"
PUBLIC_KEY_CRT_PATH="/tmp/secureboot-mok.crt"
PRIVATE_KEY_PATH="/tmp/certs/private_key.priv"

openssl x509 -in "${PUBLIC_KEY_DER_PATH}" -out "${PUBLIC_KEY_CRT_PATH}"

sbsign \
    --key "${PRIVATE_KEY_PATH}" \
    --cert "${PUBLIC_KEY_CRT_PATH}" \
    --output "${KERNEL_IMAGE}" \
    "${KERNEL_IMAGE}"

sign_module() {
    local module_path="$1"

    /usr/src/kernels/"${KERNEL_VERSION}"/scripts/sign-file \
        sha512 "${PRIVATE_KEY_PATH}" "${PUBLIC_KEY_CRT_PATH}" "${module_path}"
}

find "/lib/modules/${KERNEL_VERSION}" -type f -name '*.ko.*' -print0 | while IFS= read -r -d '' module; do
    module_basename="${module%.*}"
    module_suffix=".${module##*.}"

    case "${module_suffix}" in
        .xz)
            xz -d --keep "${module}"
            sign_module "${module_basename}"
            rm -f "${module}"
            xz -z --check=crc32 --lzma2=dict=1MiB -f "${module_basename}"
            ;;
        .gz)
            gzip -d "${module}"
            sign_module "${module_basename}"
            gzip -9f "${module_basename}"
            ;;
        *)
            sign_module "${module}"
            ;;
    esac
done

echo "::endgroup::"
