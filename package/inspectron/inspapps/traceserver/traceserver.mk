################################################################################
#
# traceserver
#
################################################################################

TRACESERVER_VERSION = 28656cc7f7ae820c6ab6077bfb345df62864b887
TRACESERVER_SITE = git@github.com:Inspectron/TraceServer.git
TRACESERVER_SITE_METHOD = git
TRACESERVER_DEPENDENCIES = qt5base libqmqtt

#define the project files that will be used in the qmake command
TRACESERVER_PRO_FILE = TraceServer.pro

# configure
define TRACESERVER_CONFIGURE_CMDS
	$(info making TraceServer with pro file: [$(TRACESERVER_PRO_FILE)])
	cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake trunk/$(TRACESERVER_PRO_FILE)
endef

# build
define TRACESERVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

# install 
define TRACESERVER_INSTALL_TARGET_CMDS

	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/bin

    # install the bin to the partition
	$(INSTALL) -D -m 0755 $(@D)/TraceServer $(BASE_DIR)/application/bin/
endef

$(eval $(generic-package))
