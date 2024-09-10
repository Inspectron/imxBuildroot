################################################################################
#
# libqmqtt
#
################################################################################

LIBQMQTT_SITE = git@github.com:Inspectron/libqmqtt.git
LIBQMQTT_SITE_METHOD = git
LIBQMQTT_VERSION = 71f09648d134440aed6646a1b5b89948e6dc4a1a
LIBQMQTT_INSTALL_STAGING = YES
LIBQMQTT_DEPENDENCIES = qt5base

# license information
LIBQMQTT_LICENSE_FILES = LICENSE

# local vars
LIBQMQTT_DIR_NAME=libqmqtt

define LIBQMQTT_CONFIGURE_CMDS
	# cd to the working directory & run qmake
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake trunk/libqmqtt.pro
endef

define LIBQMQTT_BUILD_CMDS
	# build the lib
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBQMQTT_INSTALL_STAGING_CMDS
	# install the resources to the staging directory

	$(info ------------------ staging ------------------------------ )
	mkdir -p $(STAGING_DIR)/usr/lib/$(LIBQMQTT_DIR_NAME)/
    $(INSTALL) -D -m 0755 $(@D)/libqmqtt.so* $(STAGING_DIR)/usr/lib
    
    mkdir -p $(STAGING_DIR)/usr/include/$(LIBQMQTT_DIR_NAME)/
    $(INSTALL) -D -m 0644 $(@D)/*.h $(STAGING_DIR)/usr/include
endef


define LIBQMQTT_INSTALL_TARGET_CMDS
    $(info ------------------ remove older versions ------------------------------ )
    $(RM) -f $(BASE_DIR)/application/lib/libqmqtt.so*

	$(info ------------------ install ------------------------------ )
	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/lib
    mkdir -p $(BASE_DIR)/application/include/$(LIBQMQTT_DIR_NAME)/
    # install to the partition
	$(INSTALL) -D -m 0755 $(@D)/libqmqtt.so.*.*.* $(BASE_DIR)/application/lib/
	$(INSTALL) -D -m 0644 $(@D)/*.h $(BASE_DIR)/application/include/$(LIBQMQTT_DIR_NAME)/

	# make the symlinks 
	cd $(BASE_DIR)/application/lib/; ln -sf libqmqtt.so.*.*.* libqmqtt.so
	cd $(BASE_DIR)/application/lib/; ln -sf libqmqtt.so.*.*.* libqmqtt.so.1
	cd $(BASE_DIR)/application/lib/; ln -sf libqmqtt.so.*.*.* libqmqtt.so.1.0
endef

$(eval $(generic-package))



