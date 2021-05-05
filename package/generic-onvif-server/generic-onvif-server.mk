################################################################################
#
# generic-onvif-server
#
################################################################################

GENERIC_ONVIF_SERVER_VERSION = e2f3f35a28555357e35476927ec6a122870a4459
GENERIC_ONVIF_SERVER_SITE = $(call github,n1tsu,generic-onvif-server,v$(GENERIC_ONVIF_SERVER_VERSION))

define GENERIC_ONVIF_SERVER_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define GENERIC_ONVIF_SERVER_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/onvif-server $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
