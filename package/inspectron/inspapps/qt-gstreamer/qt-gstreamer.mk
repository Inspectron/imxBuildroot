################################################################################
#
# qt-gstreamer
#
################################################################################

QT_GSTREAMER_VERSION = 1.2.0
QT_GSTREAMER_SOURCE = qt-gstreamer-$(QT_GSTREAMER_VERSION).tar.xz
QT_GSTREAMER_SITE = http://gstreamer.freedesktop.org/src/qt-gstreamer
QT_GSTREAMER_LICENSE = GPLv2+
QT_GSTREAMER_LICENSE_FILES = COPYING
QT_GSTREAMER_DEPENDENCIES = qt5declarative gstreamer1 boost

QT_GSTREAMER_CONF_OPTS = \
	-DQT_VERSION=5 \
	-DQTGSTREAMER_STATIC=OFF \
	-DQTGSTREAMER_EXAMPLES=OFF \
	-DQTGSTREAMER_TESTS=OFF \
	-DQTGSTREAMER_CODEGEN=OFF

QT_GSTREAMER_PRE_CONFIGURE_HOOKS += QT_GSTREAMER_SET_OPENGL_VARS_HOOK

QT_GSTREAMER_OPENGL_PATHS_SUBSTITUTION=set(QTGSTREAMER_VERSION 1.2.0)\n\n\
set(OPENGL_GLX_INCLUDE_DIR $(HOST_DIR)/arm-buildroot-linux-gnueabihf/sysroot/usr/include/GLES2)\n\
set(OPENGL_INCLUDE_DIR $(HOST_DIR)/arm-buildroot-linux-gnueabihf/sysroot/usr/include/GLES2)\n\
set(OPENGL_egl_LIBRARY $(HOST_DIR)/arm-buildroot-linux-gnueabihf/sysroot/usr/lib/libEGL.so)\n\
set(OPENGL_gl_LIBRARY $(HOST_DIR)/arm-buildroot-linux-gnueabihf/sysroot/usr/lib/libGLESv2.so.2.0.0)\n\
set(OPENGL_opengl_LIBRARY $(HOST_DIR)/arm-buildroot-linux-gnueabihf/sysroot/usr/lib/libGLESv2.so.2.0.0)\n

define QT_GSTREAMER_SET_OPENGL_VARS_HOOK
    ### update the CMakeLists.txt for opengl
    sed -i -e "s@set(QTGSTREAMER_VERSION 1.2.0)@$(QT_GSTREAMER_OPENGL_PATHS_SUBSTITUTION)@" $(@D)/CMakeLists.txt
endef

define QT_GSTREAMER_INSTALL_TARGET_CMDS

        # install tgt libs
        $(INSTALL) -D -m 0644 $(@D)/elements/gstqtvideosink/libgstqt5videosink* $(TARGET_DIR)/usr/lib/gstreamer-1.0/
        $(INSTALL) -D -m 0644 $(@D)/src/QGlib/libQt5GLib* $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0644 $(@D)/src/QGst/libQt5GStreamer* $(TARGET_DIR)/usr/lib
        $(INSTALL) -D -m 0644 $(@D)/src/QGst/libQt5GStreamerUi* $(TARGET_DIR)/usr/lib
        $(INSTALL) -D -m 0644 $(@D)/src/QGst/libQt5GStreamerUtils* $(TARGET_DIR)/usr/lib

        # install tgt qml - might only be the qt lib TODO figure out
        #cp -a $(STAGING_DIR)/usr/qml/QtGStreamer $(TARGET_DIR)/usr/qml

        # install tgt quick - TODO doesnt exist
        #cp -a $(STAGING_DIR)/usr/imports/QtGStreamer $(TARGET_DIR)/usr/imports

endef

$(eval $(cmake-package))
