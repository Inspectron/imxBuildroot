################################################################################
#
# libqhttp
#
################################################################################

LIBQHTTP_SITE = git@github.com:Inspectron/libqhttp.git
LIBQHTTP_SITE_METHOD = git
LIBQHTTP_VERSION = 07d679a9cfe96eb5b6509becd7bb88f821928fb1
LIBQHTTP_INSTALL_STAGING = YES
LIBQHTTP_DEPENDENCIES = qt5base

define LIBQHTTP_CONFIGURE_CMDS
	# cd to the working directory & run qmake
	cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) trunk/libqhttp.pro
endef

define LIBQHTTP_BUILD_CMDS
	# build the lib
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBQHTTP_INSTALL_STAGING_CMDS
	# install the resources to the staging directory

	$(info ------------------ staging ------------------------------ )
	mkdir -p $(STAGING_DIR)/usr/lib/libqhttp/
    $(INSTALL) -D -m 0755 $(@D)/xbin/libqhttp.so* $(STAGING_DIR)/usr/lib
    
    mkdir -p $(STAGING_DIR)/usr/include/libqhttp/
    $(INSTALL) -D -m 0644 $(@D)/trunk/src/*.hpp $(STAGING_DIR)/usr/include
endef


define LIBQHTTP_INSTALL_TARGET_CMDS
    $(info ------------------ remove older versions ------------------------------ )
    $(RM) -f $(BASE_DIR)/application/lib/libqhttp.so*

	$(info ------------------ install ------------------------------ )
	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/lib
    # install to the partition
	$(INSTALL) -D -m 0755 $(@D)/xbin/libqhttp.so.*.*.* $(BASE_DIR)/application/lib/

	# make the symlinks 
	cd $(BASE_DIR)/application/lib/; ln -sf libqhttp.so.*.*.* libqhttp.so
	cd $(BASE_DIR)/application/lib/; ln -sf libqhttp.so.*.*.* libqhttp.so.1
	cd $(BASE_DIR)/application/lib/; ln -sf libqhttp.so.*.*.* libqhttp.so.1.0
endef

$(eval $(generic-package))



