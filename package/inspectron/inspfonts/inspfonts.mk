################################################################################
#
# inspfonts
#
################################################################################

INSPFONTS_VERSION = 1.0
INSPFONTS_SITE = $(TOPDIR)/package/inspectron/inspfonts
INSPFONTS_SITE_METHOD = local

INSPFONTS_FONTS_INSTALL =

ifeq ($(BR2_PACKAGE_INSPFONTS_ROBOTO), y)
        INSPFONTS_FONTS_INSTALL += Roboto-*.ttf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_JP), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKjp-*.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_KR), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKkr-*.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_SC), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKsc-*.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_NOTOSANS_CJK_TC), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKtc-*.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_AVENIRLT_STD), y)
        INSPFONTS_FONTS_INSTALL += NotoSansCJKtc-*.otf
endif

ifeq ($(BR2_PACKAGE_INSPFONTS_FONT_AWESOME), y)
        INSPFONTS_FONTS_INSTALL += fontawesome-webfont.ttf
endif

# install the scripts to the application partition
define INSPFONTS_INSTALL_TARGET_CMDS
        mkdir -p $(TARGET_DIR)/usr/share/fonts/
        for i in $(INSPFONTS_FONTS_INSTALL) ; do \
                $(INSTALL) -m 0644 $(@D)/$$i $(TARGET_DIR)/usr/share/fonts/ || exit 1 ; \
        done
endef

$(eval $(generic-package))



