################################################################################
#
# libinspCore
#
################################################################################

LIBINSPCORE_SITE = git@github.com:Inspectron/libinspCore.git
LIBINSPCORE_SITE_METHOD = git
LIBINSPCORE_VERSION = 3b0c27d74d9623e807b02038b9fa78c18c80f02b
LIBINSPCORE_INSTALL_STAGING = YES
LIBINSPCORE_DEPENDENCIES = qt5base qt5declarative

define LIBINSPCORE_CONFIGURE_CMDS
	# cd to the working directory & run qmake
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake
endef

define LIBINSPCORE_BUILD_CMDS
	# build the lib
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBINSPCORE_INSTALL_STAGING_CMDS
	# install the resources to the staging directory

	$(info ------------------ staging ------------------------------ )
	mkdir -p $(STAGING_DIR)/usr/lib/libinspCore/
    $(INSTALL) -D -m 0755 $(@D)/libinspCore.so* $(STAGING_DIR)/usr/lib
    
    mkdir -p $(STAGING_DIR)/usr/include/libinspCore/
    $(INSTALL) -D -m 0644 $(@D)/*.hpp $(STAGING_DIR)/usr/include
endef


define LIBINSPCORE_INSTALL_TARGET_CMDS
    $(info ------------------ remove older versions ------------------------------ )
    $(RM) -f $(BASE_DIR)/application/lib/libinspCore.so*

	$(info ------------------ install ------------------------------ )
	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/lib
    mkdir -p $(BASE_DIR)/application/include
    # install to the partition
	$(INSTALL) -D -m 0755 $(@D)/libinspCore.so.*.*.* $(BASE_DIR)/application/lib/
	$(INSTALL) -D -m 0644 $(@D)/*.hpp $(BASE_DIR)/application/include/

	# make the symlinks 
	cd $(BASE_DIR)/application/lib/; ln -sf libinspCore.so.*.*.* libinspCore.so
	cd $(BASE_DIR)/application/lib/; ln -sf libinspCore.so.*.*.* libinspCore.so.1
	cd $(BASE_DIR)/application/lib/; ln -sf libinspCore.so.*.*.* libinspCore.so.1.0
endef

$(eval $(generic-package))



