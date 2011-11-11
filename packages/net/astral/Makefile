#
# Copyright (C) 2006-2009 OpenWrt.org
# Copyright 2010 Vertical Communications
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=astral
PKG_VERSION:=2.0.0
PKG_RELEASE:=6

include $(INCLUDE_DIR)/package.mk

define Package/astral
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=Astral VDS communication gateway
  DEPENDS:=+tinc +rsync 
endef

define Package/astral/description
  This package provides configuratoin and scripts for Astral VDS gateway routers
endef


define Build/Compile
endef

define Package/astral/conffiles
/etc/config/astral
endef

define Package/astral/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib/astral
	$(INSTALL_DIR) $(1)/etc/tinc/astral/hosts
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/lib/gate-utils.sh $(1)/usr/lib/astral/
	$(INSTALL_BIN) ./files/lib/syncer.lua $(1)/usr/lib/astral/
	$(INSTALL_BIN) ./files/init.d/astral $(1)/etc/init.d/astral
	$(INSTALL_DATA) ./files/config/astral $(1)/etc/config/astral
	$(INSTALL_BIN) ./files/lib/keeper-utils.sh $(1)/usr/lib/astral/
	ln -sf /tmp/astral-tinc.conf $(1)/etc/tinc/astral/tinc.conf
endef

$(eval $(call BuildPackage,astral))

