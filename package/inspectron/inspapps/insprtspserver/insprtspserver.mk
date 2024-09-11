################################################################################
#
# rtsp server
#
################################################################################

INSPRTSPSERVER_VERSION = 98a368dc69d4b62ae16bb26e37667be358e73829
INSPRTSPSERVER_SITE = git@github.com:Inspectron/inspRTSPserver.git
INSPRTSPSERVER_SITE_METHOD = git
INSPRTSPSERVER_DEPENDENCIES = qt5base gst1-rtsp-server

RTSP_PRO_FILE = inspRTSPserver.pro
#define the project files that will be used in the qmake command
#based on the configured board
ifeq ($(BR2_PACKAGE_INSP_WISCOPE_MURATA),y)
RTSP_PRO_FILE = inspRTSPserverWiScope.pro
endif

define INSPRTSPSERVER_CONFIGURE_CMDS
	$(info making insp rtsp server with pro file: [$(RTSP_PRO_FILE)])
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake trunk/$(RTSP_PRO_FILE)
endef

define INSPRTSPSERVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

# install command executed after build
# install the binaries/files to the target file system
define INSPRTSPSERVER_INSTALL_TARGET_CMDS
	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/bin
    # install the bin to the partition
	$(INSTALL) -D -m 0755 $(@D)/inspRTSPserver $(BASE_DIR)/application/bin/inspRTSPserver
	$(INSTALL) -D -m 0755 $(@D)/trunk/com.inspectron.inspRTSPServer.conf $(TARGET_DIR)/etc/dbus-1/system.d/
endef

$(eval $(generic-package))
