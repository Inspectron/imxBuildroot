#!/bin/sh
# this script will take in the first arg (as a device tree blob)
# decompile it to a device tree structure
# it assumes the device tree compiler is located in $(HOST_DIR)/bin/dtc
# the output file name generated will be the same as the dts, but with dtb extension

DTC_PATH=../output/build/linux-5.18.15/scripts/dtc/dtc
DTB_FILE=$1

## function to print the script usage
print_usage() {
	echo ""
	echo "usage: $0 <myfile.dtb>"
	echo ""
}

##### first check if dtc exists #####
if [ -f $DTC_PATH ]; then 

	##### check if the DTB file was provided  #####
	if [ -z "$DTB_FILE" ]; then
	    echo "DTS file not supplied"
	    print_usage
	else
		##### check if the DTB file extension is correct  #####
		CHK_EXT=$(echo $DTB_FILE | grep -o "\.dtb$")
		if [ -z "$CHK_EXT" ]; then
			echo "dtb file extension is wrong"
			print_usage
		else
			##### check if the file exists  #####
			if [ -f $DTB_FILE ]; then
				# create dtb file name
				#DTS_FILE="$(echo $DTB_FILE | grep -o '^.*\.')dts"
				DTS_FILE=output.dts

				# decompile the blob
				$DTC_PATH -I dtb -O dts -o $DTS_FILE $DTB_FILE

				echo "blob decompiled to $DTS_FILE"
			else
				echo "$DTB_FILE file doesnt exist"
				print_usage
			fi
		fi
	fi

else
	echo "dtc doesnt exist in ${DTC_PATH}. Please rebuild buildroot"
fi


#$(HOST_DIR)/dtc --help
