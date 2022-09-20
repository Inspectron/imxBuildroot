#!/usr/bin/env bash

#
# dtb_list extracts the list of DTB files from BR2_LINUX_KERNEL_INTREE_DTS_NAME
# in ${BR_CONFIG}, then prints the corresponding list of file names for the
# genimage configuration file
#
dtb_list()
{
	local DTB_LIST="$(sed -n 's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\([\/a-z0-9 \-]*\)"$/\1/p' ${BR2_CONFIG})"

	for dt in $DTB_LIST; do
		echo -n "\"`basename $dt`.dtb\", "
	done
}

#
# linux_image extracts the Linux image format from BR2_LINUX_KERNEL_UIMAGE in
# ${BR_CONFIG}, then prints the corresponding file name for the genimage
# configuration file
#
linux_image()
{
	if grep -Eq "^BR2_LINUX_KERNEL_UIMAGE=y$" ${BR2_CONFIG}; then
		echo "\"uImage\""
	elif grep -Eq "^BR2_LINUX_KERNEL_IMAGE=y$" ${BR2_CONFIG}; then
		echo "\"Image\""
	elif grep -Eq "^BR2_LINUX_KERNEL_IMAGEGZ=y$" ${BR2_CONFIG}; then
		echo "\"Image.gz\""
	else
		echo "\"zImage\""
	fi
}

genimage_type()
{
	if grep -Eq "^BR2_LINUX_KERNEL_INSTALL_TARGET=y$" ${BR2_CONFIG}; then
		echo "genimage.cfg.template_no_boot_part_spl"
	elif grep -Eq "^BR2_TARGET_UBOOT_SPL=y$" ${BR2_CONFIG}; then
		echo "genimage.cfg.template_spl"
	fi
}

imx_offset()
{
	echo "32K"
}

uboot_image()
{
	if grep -Eq "^BR2_TARGET_UBOOT_FORMAT_DTB_IMX=y$" ${BR2_CONFIG}; then
		echo "u-boot-dtb.imx"
	elif grep -Eq "^BR2_TARGET_UBOOT_FORMAT_IMX=y$" ${BR2_CONFIG}; then
		echo "u-boot.imx"
	elif grep -Eq "^BR2_TARGET_UBOOT_FORMAT_DTB_IMG=y$" ${BR2_CONFIG}; then
	    echo "u-boot-dtb.img"
	elif grep -Eq "^BR2_TARGET_UBOOT_FORMAT_IMG=y$" ${BR2_CONFIG}; then
	    echo "u-boot.img"
	fi
}

main()
{
	local FILES="$(dtb_list) $(linux_image)"
	local IMXOFFSET="$(imx_offset)"
	local UBOOTBIN="$(uboot_image)"
	local GENIMAGE_CFG="$(mktemp --suffix genimage.cfg)"
	local GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

	sed -e "s/%FILES%/${FILES}/" \
		-e "s/%IMXOFFSET%/${IMXOFFSET}/" \
		-e "s/%UBOOTBIN%/${UBOOTBIN}/" \
		support/scripts/imx6/$(genimage_type) > ${GENIMAGE_CFG}

	rm -rf "${GENIMAGE_TMP}"

	genimage \
		--rootpath "${TARGET_DIR}" \
		--tmppath "${GENIMAGE_TMP}" \
		--inputpath "${BINARIES_DIR}" \
		--outputpath "${BINARIES_DIR}" \
		--config "${GENIMAGE_CFG}"

	rm -f ${GENIMAGE_CFG}

	exit $?
}

main $@
