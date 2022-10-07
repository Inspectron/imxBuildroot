################################################################################
#
# inspfonts
#
################################################################################

INSPFONTS_VERSION = 1.0
INSPFONTS_SITE = $(TOPDIR)/package/inspectron/inspfonts
INSPFONTS_SITE_METHOD = local

INSPFONTS_FONTS_INSTALL =

ifeq ($(BR2_PACKAGE_INSPFONTS_ROBOTO_BOLD), y)
        INSPFONTS_FONTS_INSTALL += Roboto-Bold.ttf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_ROBOTO_LIGHT), y)
        INSPFONTS_FONTS_INSTALL += Roboto-Light.ttf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_JP_BOLD), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKjp-Bold.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_JP_LIGHT), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKjp-Light.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_KR_BOLD), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKkr-Bold.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_KR_LIGHT), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKkr-Light.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_SC_BOLD), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKsc-Bold.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_SC_LIGHT), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKsc-Light.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_TC_BOLD), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKtc-Bold.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_TC_LIGHT), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKtc-Light.otf
endif

# install the scripts to the application partition
define INSPFONTS_INSTALL_TARGET_CMDS
        mkdir -p $(TARGET_DIR)/usr/share/fonts/
        for i in $(INSPFONTS_FONTS_INSTALL) ; do \
                $(INSTALL) -m 0644 $(@D)/$$i $(TARGET_DIR)/usr/share/fonts/ || exit 1 ; \
        done
endef

$(eval $(generic-package))



