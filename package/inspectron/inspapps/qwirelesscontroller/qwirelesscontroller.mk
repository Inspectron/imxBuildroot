################################################################################
#
# qWirelessController
#
################################################################################
# branch bk7-v25b.02.22
QWIRELESSCONTROLLER_VERSION = 919eca35cda9783754dc3186b26b8ff432e99c98
QWIRELESSCONTROLLER_SITE = git@github.com:Inspectron/qWirelessController.git
QWIRELESSCONTROLLER_SITE_METHOD = git
QWIRELESSCONTROLLER_DEPENDENCIES = qt5base libqmqtt libqzxing libinspFileHandler qt5connectivity 

#define the project files that will be used in the qmake command
#based on the configured board
ifeq ($(BR2_PACKAGE_INSP_TINKERBOARD),y)
QWIRELESSCONTROLLER_PRO_FILE = trunk/qWirelessControllerWiTorch.pro
QWIRELESSCONTROLLER_SETTINGS_FILE = trunk/config/witorch/inspSettings.json
endif

ifeq ($(BR2_PACKAGE_INSP_WITORCH),y)
QWIRELESSCONTROLLER_PRO_FILE = trunk/qWirelessControllerWiTorch.pro
QWIRELESSCONTROLLER_SETTINGS_FILE = trunk/config/witorch/inspSettings.json
endif

ifeq ($(BR2_PACKAGE_INSP_ROTH_I3000),y)
QWIRELESSCONTROLLER_PRO_FILE = trunk/qWirelessControllerRoth.pro
QWIRELESSCONTROLLER_SETTINGS_FILE = trunk/config/roth/inspSettings.json
endif

ifeq ($(BR2_PACKAGE_INSP_ROCKCHIP_EVB),y)
QWIRELESSCONTROLLER_PRO_FILE = trunk/qWirelessControllerWiTorch.pro
QWIRELESSCONTROLLER_SETTINGS_FILE = trunk/config/witorch/inspSettings.json
endif

ifeq ($(BR2_PACKAGE_INSP_BK7XXX),y)
QWIRELESSCONTROLLER_PRO_FILE = trunk/qWirelessControllerBK7XXX.pro
QWIRELESSCONTROLLER_SETTINGS_FILE = trunk/config/bk7xxx/inspSettings.json
endif

define QWIRELESSCONTROLLER_CONFIGURE_CMDS
	$(info making qwirelesscontroller with pro file: [$(QWIRELESSCONTROLLER_PRO_FILE)])
	cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) $(QWIRELESSCONTROLLER_PRO_FILE)
endef

define QWIRELESSCONTROLLER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

# install command executed after build
# install the binaries/files to the target file system
define QWIRELESSCONTROLLER_INSTALL_TARGET_CMDS

	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/bin

    # install the bin to the partition
	$(INSTALL) -D -m 0755 $(@D)/qWirelessController $(BASE_DIR)/application/bin/qWirelessController

	# install the settings file to the partition
	$(INSTALL) -D -m 0644 $(@D)/$(QWIRELESSCONTROLLER_SETTINGS_FILE) $(BASE_DIR)/application/bin/

	# install the dbus-config to the dbus dir
	$(INSTALL) -D -m 0644 $(@D)/trunk/com.inspectron.qWirelessController.conf $(TARGET_DIR)/etc/dbus-1/system.d/
endef

$(eval $(generic-package))
