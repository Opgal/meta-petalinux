TOOLCHAIN_HOST_TASK += "\
	nativesdk-python3-sqlite3 \
	nativesdk-python3-pyyaml \
	nativesdk-qemu-xilinx \
	nativesdk-bootgen \
	nativesdk-lopper \
"

# Add petalinux host dependencies
TOOLCHAIN_HOST_TASK += "\
	nativesdk-dos2unix \
	nativesdk-gawk \
	nativesdk-socat \
	nativesdk-unzip \
	nativesdk-gzip \
	nativesdk-python3 \
	nativesdk-python3-links \
	nativesdk-tftp-hpa \
	nativesdk-diffstat \
	nativesdk-gnupg \
	nativesdk-bzip2 \
	nativesdk-xz \
	nativesdk-cpio \
	nativesdk-file \
	nativesdk-patch \
	nativesdk-kconfig-frontends \
	nativesdk-u-boot-tools \
"

create_sdk_files_append () {
	echo 'export PETALINUX_NATIVE_SYSROOT="${SDKPATHNATIVE}"' >> $script
}
