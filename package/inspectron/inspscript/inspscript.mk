################################################################################
#
# inspscript
#
################################################################################
INSPSCRIPT_VERSION = 19d6a6f45f9cf4121c558bf68d0802232a8968fc
INSPSCRIPT_SITE = git@github.com:Inspectron/inspscript.git
INSPSCRIPT_SITE_METHOD = git

DEFAULT_BOOT_SCRIPT = boot.sh
BOOT_SCRIPT = $(DEFAULT_BOOT_SCRIPT)

DEFAULT_POWER_GPIO_SCRIPT = powerGPIO.sh
POWER_GPIO_SCRIPT = $(DEFAULT_POWER_GPIO_SCRIPT)

ifeq ($(BR2_PACKAGE_INSP_FLUKE_VAVE),y)
BOOT_SCRIPT = fluke_boot.sh
endif

ifeq ($(BR2_PACKAGE_INSP_TINKERBOARD),y)
BOOT_SCRIPT = witorch_boot.sh
endif

ifeq ($(BR2_PACKAGE_INSP_WISCOPE_MURATA),y)
BOOT_SCRIPT = wiscope_boot.sh
endif

ifeq ($(BR2_PACKAGE_INSP_ROCKCHIP_EVB),y)
BOOT_SCRIPT = witorch_boot.sh
endif

ifeq ($(BR2_PACKAGE_INSP_WITORCH), y)
BOOT_SCRIPT = witorch_boot.sh
POWER_GPIO_SCRIPT = witorch_powerGPIO.sh
endif

ifeq ($(BR2_PACKAGE_INSP_ROTH_I3000),y)
BOOT_SCRIPT = i3000_boot.sh
POWER_GPIO_SCRIPT = i3000_powerGPIO.sh
endif

ifeq ($(BR2_PACKAGE_INSP_REEL), y)
BOOT_SCRIPT = reel_boot.sh
#i3000 and roth share the same power gpio
POWER_GPIO_SCRIPT = i3000_powerGPIO.sh
endif

ifeq ($(BR2_PACKAGE_INSP_BK7XXX), y)
BOOT_SCRIPT = bk7xxx_boot.sh
POWER_GPIO_SCRIPT = bk7xxx_powerGPIO.sh
endif

# install the scripts to the application partition
ifeq ($(BR2_PACKAGE_INSP_FLUKE_VAVE),y)
define INSPSCRIPT_INSTALL_TARGET_CMDS
        # create the application partition folder
        mkdir -p $(BASE_DIR)/application/scripts

        $(info installing boot script: [$(BOOT_SCRIPT)])
        # add the boot script to the application/scripts folder
        $(INSTALL) -D -m 755 $(@D)/$(BOOT_SCRIPT) $(BASE_DIR)/application/scripts/$(DEFAULT_BOOT_SCRIPT)
        $(INSTALL) -D -m 755 $(@D)/startinfra.sh $(BASE_DIR)/appdata/startinfra.sh
        $(INSTALL) -D -m 755 $(@D)/starthostapd.sh $(BASE_DIR)/appdata/starthostapd.sh
        $(INSTALL) -D -m 755 $(@D)/stophostapd.sh $(BASE_DIR)/appdata/stophostapd.sh

        # add the init.d scripts to the init.d folder
        $(INSTALL) -D -m 755 $(@D)/S100InspectronBoot $(TARGET_DIR)/etc/init.d
        $(INSTALL) -D -m 755 $(@D)/S50usbdevice $(TARGET_DIR)/etc/init.d
        $(INSTALL) -D -m 755 $(@D)/.usb_config $(TARGET_DIR)/etc/init.d

        # ensure the scripts have the correct wlan interface
        sed -i -e 's@wlan.@wlan0@g' $(BASE_DIR)/appdata/startinfra.sh
        sed -i -e 's@wlan.@wlan0@g' $(BASE_DIR)/appdata/starthostapd.sh
        sed -i -e 's@wlan.@wlan0@g' $(BASE_DIR)/appdata/stophostapd.sh
endef
else ifeq ($(BR2_PACKAGE_INSP_WISCOPE_MURATA),y)
define INSPSCRIPT_INSTALL_TARGET_CMDS
        # create the application partition folder
        mkdir -p $(BASE_DIR)/application/scripts
        mkdir -p $(BASE_DIR)/appdata

        $(info installing boot script: [$(BOOT_SCRIPT)])
        # add the boot script to the application/scripts folder
        $(INSTALL) -D -m 755 $(@D)/$(BOOT_SCRIPT) $(BASE_DIR)/application/scripts/$(DEFAULT_BOOT_SCRIPT)

        # add the init.d scripts to the init.d folder
        $(INSTALL) -D -m 755 $(@D)/S100InspectronBoot $(TARGET_DIR)/etc/init.d
        $(INSTALL) -D -m 755 $(@D)/wiscope_startinfra.sh $(BASE_DIR)/appdata/startinfra.sh
        $(INSTALL) -D -m 755 $(@D)/wiscope_starthostapd.sh $(BASE_DIR)/appdata/starthostapd.sh
        $(INSTALL) -D -m 755 $(@D)/wiscope_stophostapd.sh $(BASE_DIR)/appdata/stophostapd.sh

endef
else
define INSPSCRIPT_INSTALL_TARGET_CMDS
        # create the application partition folder
        mkdir -p $(BASE_DIR)/application/scripts

        $(info installing boot script: [$(BOOT_SCRIPT)])
        # add the boot script to the application/scripts folder
        $(INSTALL) -D -m 755 $(@D)/$(BOOT_SCRIPT) $(BASE_DIR)/application/scripts/$(DEFAULT_BOOT_SCRIPT)
        $(INSTALL) -D -m 755 $(@D)/startinfra.sh $(BASE_DIR)/appdata/startinfra.sh
        $(INSTALL) -D -m 755 $(@D)/starthostapd.sh $(BASE_DIR)/appdata/starthostapd.sh
        $(INSTALL) -D -m 755 $(@D)/stophostapd.sh $(BASE_DIR)/appdata/stophostapd.sh

        # add the power GPIO script
        $(INSTALL) -D -m 755 $(@D)/$(POWER_GPIO_SCRIPT) $(BASE_DIR)/appdata/$(DEFAULT_POWER_GPIO_SCRIPT)

        # add the profile script to the profile folder
        $(INSTALL) -D -m 755 $(@D)/inspProfile.sh $(TARGET_DIR)/etc/profile.d

        # add the init.d scripts to the init.d folder
        $(INSTALL) -D -m 755 $(@D)/S100InspectronBoot $(TARGET_DIR)/etc/init.d
        $(INSTALL) -D -m 755 $(@D)/S20skylab $(TARGET_DIR)/etc/init.d

        #add hdmi connection scripts
        $(INSTALL) -D -m 755 $(@D)/hdmi_disc.sh $(BASE_DIR)/appdata/hdmi_disc.sh
        $(INSTALL) -D -m 755 $(@D)/hdmi_connect.sh $(BASE_DIR)/appdata/hdmi_connect.sh

       # add usb restart script
       $(INSTALL) -D -m 755 $(@D)/restartUSB.sh $(BASE_DIR)/appdata/restartUSB.sh

       #install the bluetooth script
       $(INSTALL) -D -m 755 $(@D)/initBluetooth.sh $(BASE_DIR)/appdata/initBluetooth.sh

       # install the gsthelper script
       $(INSTALL) -D -m 755 $(@D)/gsthelper.sh $(BASE_DIR)/application/scripts/gsthelper.sh
endef
endif

$(eval $(generic-package))



