#!/bin/bash
som=`fru-print.py -b som -f product | awk -F- '{ print $2}' | tr '[:upper:]' '[:lower:]'`
cc=`fru-print.py -b cc -f product | awk -F- '{ print $2}' | tr '[:upper:]' '[:lower:]'`

#TODO Possibly check BOARD/BOARD_VARIANT values before changing arch file
#(but will only affect if the values match up to a repo arch value)
BOARD=${som}
BOARD_VARIANT=${som}_${cc}

#check if dnf configs already updated based off BOARD_VARIANT value
if ! grep "${BOARD_VARIANT}" /etc/dnf/vars/arch > /dev/null
then
    if grep "${BOARD}" /etc/dnf/vars/arch > /dev/null
    then
	#Add board_variant right after first level hiearchy which is MACHINE (Board is assumed to be present as SOM bsps are now built with BOARD defined)
        sed -i "s/:/:${BOARD_VARIANT}:/" /etc/dnf/vars/arch
        #Add board_variant arch to arch_compat (order doesnt matter here)
        sed -i "s/^arch_compat.*/& ${BOARD_VARIANT}/"  /etc/rpmrc

	PACKAGE_FEED_URIS="@@PACKAGE_FEED_URIS@@"
        for URI in ${PACKAGE_FEED_URIS}
        do
                FILE_NAME=$(echo ${URI} | awk -F"petalinux.xilinx.com/" '{print $2}' | sed 's./.-.g')
                echo -e "[remote-repo-${BOARD_VARIANT}]\nname=remote-repo-${BOARD_VARIANT}\nbaseurl=${URI}/${BOARD_VARIANT}\ngpgcheck=0\n" | tee -a /etc/yum.repos.d/*${FILE_NAME}.repo >/dev/null 2>&1
        done
    else
	echo "Not adding board variant to config as board is not present"
    fi
fi
