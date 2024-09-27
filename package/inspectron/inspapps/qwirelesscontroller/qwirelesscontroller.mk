################################################################################
#
# qWirelessController
#
################################################################################
# branch fluke 
QWIRELESSCONTROLLER_VERSION = 7b84ec3d823dc327ee910869fbb6b568b71601c5
QWIRELESSCONTROLLER_SITE = git@github.com:Inspectron/qWirelessController.git
QWIRELESSCONTROLLER_SITE_METHOD = git
QWIRELESSCONTROLLER_DEPENDENCIES = qt5base libinspFileHandler qt5connectivity 

#define the project files that will be used in the qmake command
#based on the configured board
ifeq ($(BR2_PACKAGE_INSP_FLUKE_VAVE),y)
QWIRELESSCONTROLLER_PRO_FILE = trunk/qWirelessControllerFluke.pro
QWIRELESSCONTROLLER_SETTINGS_FILE = trunk/config/fluke/inspSettings.json
endif

ifeq ($(BR2_PACKAGE_INSP_WISCOPE_MURATA),y)
QWIRELESSCONTROLLER_PRO_FILE = trunk/qWirelessControllerWifiHandle.pro
QWIRELESSCONTROLLER_SETTINGS_FILE = trunk/config/wifihandle/inspSettings.json
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
