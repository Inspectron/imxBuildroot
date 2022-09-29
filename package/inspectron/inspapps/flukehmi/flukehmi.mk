################################################################################
#
# FlukeDemoHMI
#
################################################################################
# branch 
FLUKEHMI_VERSION = a22f7e5e7571071e9e7515c11fbae4633f20136a
FLUKEHMI_SITE = git@github.com:Inspectron/FlukeDemoHMI.git
FLUKEHMI_SITE_METHOD = git
FLUKEHMI_DEPENDENCIES = qt5base

define FLUKEHMI_CONFIGURE_CMDS
	$(info making FlukeDemoHMI with pro file: [$(FLUKEHMI_PRO_FILE)])
	cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) trunk/FlukeDemoHMI.pro
endef

define FLUKEHMI_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

# install command executed after build
# install the binaries/files to the target file system
define FLUKEHMI_INSTALL_TARGET_CMDS

	# create the application partition folder
    mkdir -p $(BASE_DIR)/application/bin

    # install the bin to the partition
	$(INSTALL) -D -m 0755 $(@D)/FlukeDemoHMI $(BASE_DIR)/application/bin/FlukeDemoHMI
endef

$(eval $(generic-package))
