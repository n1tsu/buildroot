################################################################################
#
# generic-onvif-server
#
################################################################################

GENERIC_ONVIF_SERVER_VERSION = e2f3f35a28555357e35476927ec6a122870a4459
GENERIC_ONVIF_SERVER_SITE = $(call github,n1tsu,generic-onvif-server,$(GENERIC_ONVIF_SERVER_VERSION))
GENERIC_ONVIF_SERVER_DEPENDENCIES = gstreamer1 gst1-rtsp-server libopenssl
GENERIC_ONVIF_SERVER_INSTALL_TARGET = YES

define GENERIC_ONVIF_SERVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) CC=$(TARGET_CC) CXX=$(TARGET_CXX) $(MAKE) -C $(@D)
endef

define GENERIC_ONVIF_SERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/onvif-server $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
