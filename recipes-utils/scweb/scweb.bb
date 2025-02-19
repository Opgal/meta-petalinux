#
# This file is the scweb recipe.
#

SUMMARY = "Landing Page"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"


SRC_URI = "git://github.com/Xilinx/system-controller-web.git;branch=master;protocol=https \
                  "
SRCREV = "a941c54eff60a4873d1b7905dbfad03c081cc95f"

inherit update-rc.d

INITSCRIPT_NAME = "scwebrun.sh"
INITSCRIPT_PARAMS = "start 97 5 ."

S = "${WORKDIR}/git"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_vck-sc = "${MACHINE}"
COMPATIBLE_MACHINE_vpk-sc = "${MACHINE}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_configure[noexec]="1"
do_compile[noexec]="1"

SCWEB_DIR = "${datadir}/${PN}"

RDEPENDS_${PN} += "bash \
        python3 \
        python3-flask \
        python3-flask-restful \
        system-controller-app \        
        lmsensors-sensors \
        "

do_install() {
        install -d ${D}/${SCWEB_DIR}
        install -d ${D}${sysconfdir}/init.d/

        cp -r ${S}/src/* ${D}/${SCWEB_DIR}
        install -m 0755 ${S}/scwebrun.sh ${D}${sysconfdir}/init.d/
}
FILES_${PN} += "${SCWEB_DIR}"


