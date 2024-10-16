################################################################################
#
# libinspFileHandler
#
################################################################################

LIBINSPFILEHANDLER_SITE = git@github.com:Inspectron/libinspFileHandler.git
LIBINSPFILEHANDLER_SITE_METHOD = git
LIBINSPFILEHANDLER_VERSION = 07dc045995131a83fe04aba1e099f651e11d63e7
LIBINSPFILEHANDLER_INSTALL_STAGING = YES
LIBINSPFILEHANDLER_DEPENDENCIES = qt5base qt5multimedia 

define LIBINSPFILEHANDLER_CONFIGURE_CMDS
	# cd to the working directory & run qmake
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake
endef

define LIBINSPFILEHANDLER_BUILD_CMDS
	# build the lib
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBINSPFILEHANDLER_INSTALL_STAGING_CMDS
	# install the resources to the staging directory

	$(info ------------------ staging ------------------------------ )
	mkdir -p $(STAGING_DIR)/usr/lib/libinspFileHandler/
    $(INSTALL) -D -m 0755 $(@D)/libinspFileHandler.so* $(STAGING_DIR)/usr/lib/
    
    mkdir -p $(STAGING_DIR)/usr/include/libinspFileHandler/
    $(INSTALL) -D -m 0644 $(@D)/*.hpp $(STAGING_DIR)/usr/include/
endef


define LIBINSPFILEHANDLER_INSTALL_TARGET_CMDS
    $(info ------------------ remove older versions ------------------------------ )
    $(RM) -f $(BASE_DIR)/application/lib/libinspFileHandler.so*

	$(info ------------------ install ------------------------------ )
	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/lib
    mkdir -p $(BASE_DIR)/application/include
    # install to the partition
	$(INSTALL) -D -m 0755 $(@D)/libinspFileHandler.so.*.*.* $(BASE_DIR)/application/lib/
	$(INSTALL) -D -m 0644 $(@D)/*.hpp $(BASE_DIR)/application/include/
	
	# make the symlinks 
	cd $(BASE_DIR)/application/lib/; ln -sf libinspFileHandler.so.*.*.* libinspFileHandler.so
	cd $(BASE_DIR)/application/lib/; ln -sf libinspFileHandler.so.*.*.* libinspFileHandler.so.1
	cd $(BASE_DIR)/application/lib/; ln -sf libinspFileHandler.so.*.*.* libinspFileHandler.so.1.0
endef

$(eval $(generic-package))



