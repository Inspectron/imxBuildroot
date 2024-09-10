################################################################################
#
# image capturer
#
################################################################################

IMAGECAPTURER_VERSION = 03043d97c33b7a0ff784bd4a5e76012a234c8c40
IMAGECAPTURER_SITE = git@github.com:Inspectron/qImageCapturer-digital.git
IMAGECAPTURER_SITE_METHOD = git
IMAGECAPTURER_DEPENDENCIES = qt5base qt-gstreamer qt5declarative imx-gpu-g2d

IMGCAP_PRO_FILE = ImgCapturer.pro

define IMAGECAPTURER_CONFIGURE_CMDS
	$(info making image capturer with pro file: [$(IMGCAP_PRO_FILE)])
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake trunk/$(IMGCAP_PRO_FILE)
endef

define IMAGECAPTURER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

# install command executed after build
# install the binaries/files to the target file system
define IMAGECAPTURER_INSTALL_TARGET_CMDS
	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/bin
    # install the bin to the partition
	$(INSTALL) -D -m 0755 $(@D)/ImgCapturer $(BASE_DIR)/application/bin/ImgCapturer
	$(INSTALL) -D -m 0755 $(@D)/trunk/com.inspectron.ImgCapturer.conf $(TARGET_DIR)/etc/dbus-1/system.d/
endef

$(eval $(generic-package))
