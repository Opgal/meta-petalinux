FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://e2fs \
	file://searche2fs \
	"

PACKAGES += "initramfs-module-searche2fs"

do_install() {
    install -d ${D}/init.d

    # base
    install -m 0755 ${WORKDIR}/init ${D}/init
    install -m 0755 ${WORKDIR}/nfsrootfs ${D}/init.d/85-nfsrootfs
    install -m 0755 ${WORKDIR}/rootfs ${D}/init.d/90-rootfs
    install -m 0755 ${WORKDIR}/finish ${D}/init.d/99-finish

	# exec
    install -m 0755 ${WORKDIR}/exec ${D}/init.d/89-exec

    # mdev
    install -m 0755 ${WORKDIR}/mdev ${D}/init.d/01-mdev

    # udev
    install -m 0755 ${WORKDIR}/udev ${D}/init.d/01-udev

    # e2fs
    install -m 0755 ${WORKDIR}/e2fs ${D}/init.d/91-e2fs

    # getext4
    install -m 0755 ${WORKDIR}/searche2fs ${D}/init.d/92-searche2fs

    # debug
    install -m 0755 ${WORKDIR}/debug ${D}/init.d/00-debug

    # lvm
    install -m 0755 ${WORKDIR}/lvm ${D}/init.d/09-lvm

    # Create device nodes expected by some kernels in initramfs
    # before even executing /init.
    install -d ${D}/dev
    mknod -m 622 ${D}/dev/console c 5 1
}

FILES_initramfs-module-e2fs = "/init.d/91-e2fs"

SUMMARY_initramfs-module-searche2fs = "search for the ext partitions available and mounts it"
RDEPENDS_initramfs-module-searche2fs = "${PN}-base"
FILES_initramfs-module-searche2fs = "/init.d/92-searche2fs"
