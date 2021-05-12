################################################################################
#
# generic-onvif-server
#
################################################################################

GENERIC_ONVIF_SERVER_VERSION = b0512c0e7509a6cf58cd57dcadae4286631410a2
GENERIC_ONVIF_SERVER_SITE = $(call github,n1tsu,generic-onvif-server,$(GENERIC_ONVIF_SERVER_VERSION))
GENERIC_ONVIF_SERVER_DEPENDENCIES = gstreamer1 gst1-rtsp-server libopenssl
GENERIC_ONVIF_SERVER_INSTALL_TARGET = YES

define GENERIC_ONVIF_SERVER_BUILD_CMDS
	$(TARGET_MAKE_ENV) CC=$(TARGET_CC) CXX=$(TARGET_CXX) $(MAKE) -C $(@D)
endef

define GENERIC_ONVIF_SERVER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/generic-onvif-server
	cp -r $(@D)/configs $(TARGET_DIR)/etc/generic-onvif-server
	cp -r $(@D)/camera/lib $(TARGET_DIR)/usr/lib/generic-onvif-server
	$(INSTALL) -D -m 0755 $(@D)/onvif-server $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
