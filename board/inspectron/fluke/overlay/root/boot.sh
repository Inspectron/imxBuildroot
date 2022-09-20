#!/bin/sh
# start a video pipeline for emc testing


FILES="/dev/video*"
CAMERA=""

# enable the USB power supply (GPIO3_IO30)
echo 94 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio94/direction
echo 1 > /sys/class/gpio/gpio94/value


# loop until the device is found
while [ -z "$CAMERA" ]; do
  for f in $FILES
  do
    echo "Checking camera $f "
    HAS_MJPEG=$( v4l2-ctl --list-formats --device=${f} | grep "Motion-JPEG")

    sleep 0.1

    if [ ! -z "$HAS_MJPEG" ]; then
        echo ">>>> HAS MJPEG"
        CAMERA=$f
        break;
    fi
  done

  echo "------------------"

  sleep 0.5;
done

echo "device=$CAMERA"

dmesg -n 1

# launch gstreamer pipeline
gst-launch-1.0 v4l2src device=${CAMERA} ! \
image/jpeg,width=640,height=480,framerate=15/1 ! \
jpegparse ! \
v4l2jpegdec ! \
kmssink sync=false &

