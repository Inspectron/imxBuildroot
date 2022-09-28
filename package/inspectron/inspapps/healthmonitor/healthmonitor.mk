################################################################################
#
# healthmonitor
#
################################################################################
HEALTHMONITOR_VERSION = a590ac749f4d99d00b6aecbbedc843fafd010d7e
HEALTHMONITOR_SITE = git@github.com:Inspectron/healthmonitor.git
HEALTHMONITOR_SITE_METHOD = git
HEALTHMONITOR_DEPENDENCIES = qt5base
HEALTHMONITOR_PRO_FILE = trunk/healthmonitor.pro

define HEALTHMONITOR_CONFIGURE_CMDS
	$(info making healthmonitor with pro file: [$(HEALTHMONITOR_PRO_FILE)])
	cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) $(HEALTHMONITOR_PRO_FILE)
endef

define HEALTHMONITOR_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

# install command executed after build
# install the binaries/files to the target file system
define HEALTHMONITOR_INSTALL_TARGET_CMDS

	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/bin

    # install the bin to the partition
	$(INSTALL) -D -m 0755 $(@D)/healthmonitor $(BASE_DIR)/application/bin/healthmonitor

endef

$(eval $(generic-package))
