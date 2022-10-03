#!/bin/sh
# script to enable the USB MASS STORAGE

# the legacy driver is:
#  modprobe g_mass_storage file=/dev/mmcblk1p5 iSerialNumber=1234 removable=1

echo "---------- set the usb gpios ------------"

if [ ! -d /sys/class/gpio/gpio204 ]; then
	echo 204 > /sys/class/gpio/export 	
fi
echo out > /sys/class/gpio/gpio204/direction
echo 1 > /sys/class/gpio/gpio204/value

if [ ! -d /sys/class/gpio/gpio1 ]; then
	echo 1 > /sys/class/gpio/export
fi
echo out > /sys/class/gpio/gpio1/direction
echo 1 > /sys/class/gpio/gpio1/value


echo "-------- setup the configfs and create the gadget ----------"
CONFIGFS_HOME=/sys/kernel/config
mount -t configfs none $CONFIGFS_HOME 
mkdir $CONFIGFS_HOME/usb_gadget/inspectron

echo "-------- setup the gadget ----------"
cd $CONFIGFS_HOME/usb_gadget/inspectron
echo 0x1b67 > idVendor
echo 0x0000 > idProduct
# English language strings...
mkdir strings/0x409
echo "12345" > strings/0x409/serialnumber
echo "Inspectron" > strings/0x409/manufacturer
echo "DS70X" > strings/0x409/product

echo "-------- create the configuration ----------"
mkdir configs/c.1
mkdir configs/c.1/strings/0x409
echo 500 > configs/c.1/MaxPower
echo "ums" > configs/c.1/strings/0x409/configuration

echo "-------- create the functions ----------"
mkdir functions/mass_storage.0
echo /dev/mmcblk1p5 > functions/mass_storage.0/lun.0/file
ln -s functions/mass_storage.0 configs/c.1/mass_storage.0

echo "-------- enable usb device ----------"
UDC=`ls /sys/class/udc/| awk '{print $1}'`
echo $UDC > UDC
cd - 

# disable USB device with 
# echo "" > UDC

