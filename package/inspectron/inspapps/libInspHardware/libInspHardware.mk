################################################################################
#
# libInspHardware
#
################################################################################

LIBINSPHARDWARE_SITE = git@github.com:Inspectron/libInspHardware.git
LIBINSPHARDWARE_SITE_METHOD = git
LIBINSPHARDWARE_VERSION = 6cf2943afa84a9dabfb9783a25e50d75a7c0edbe
LIBINSPHARDWARE_INSTALL_STAGING = YES
LIBINSPHARDWARE_DEPENDENCIES = qt5base

define LIBINSPHARDWARE_CONFIGURE_CMDS
	# cd to the working directory & run qmake
	cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) trunk/libInspHardware.pro
endef

define LIBINSPHARDWARE_BUILD_CMDS
	# build the lib
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBINSPHARDWARE_INSTALL_STAGING_CMDS
	# install the resources to the staging directory

	$(info ------------------ staging ------------------------------ )
	mkdir -p $(STAGING_DIR)/usr/lib/
    $(INSTALL) -D -m 0755 $(@D)/libInspHardware.so* $(STAGING_DIR)/usr/lib/
    
    mkdir -p $(STAGING_DIR)/usr/include/
    $(INSTALL) -D -m 0644 $(@D)/trunk/*.hpp $(STAGING_DIR)/usr/include
endef


define LIBINSPHARDWARE_INSTALL_TARGET_CMDS
    $(info ------------------ remove older versions ------------------------------ )
    $(RM) -f $(BASE_DIR)/application/lib/libInspHardware.so*

	$(info ------------------ install ------------------------------ )
	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/lib
    # install to the partition
	$(INSTALL) -D -m 0755 $(@D)/libInspHardware.so.*.*.* $(BASE_DIR)/application/lib/

	# make the symlinks 
	cd $(BASE_DIR)/application/lib/; ln -sf libInspHardware.so.*.*.* libInspHardware.so
	cd $(BASE_DIR)/application/lib/; ln -sf libInspHardware.so.*.*.* libInspHardware.so.1
	cd $(BASE_DIR)/application/lib/; ln -sf libInspHardware.so.*.*.* libInspHardware.so.1.0
endef

$(eval $(generic-package))



