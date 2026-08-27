#!/usr/bin/env bash

set -euo pipefail

echo "::group:: ===$(basename "$0")==="

KERNEL_VERSION="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
KERNEL_IMAGE="/usr/lib/modules/${KERNEL_VERSION}/vmlinuz"

PUBLIC_KEY_PATH=
PRIVATE_KEY_PATH=

sbsign \
    --key "${PRIVATE_KEY_PATH}" \
    --cert "${PUBLIC_KEY_PATH}" \
    --output "${KERNEL_IMAGE}" \
    "${KERNEL_IMAGE}"

sign_module() {
    local module_path="$1"

    /usr/src/kernels/"${KERNEL_VERSION}"/scripts/sign-file \
        sha512 "${PRIVATE_KEY_PATH}" "${PUBLIC_KEY_PATH}" "${module_path}"
}

find "/lib/modules/$KVER" -type f -name '*.ko.*' -print0 | while IFS= read -r -d '' module; do
    module_basename="${module%.*}"
    module_suffix=".${module##*.}"

    case "${module_suffix}" in
        .xz)
            xz --decompress "${module}"
            sign_module "${module_basename}"
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
