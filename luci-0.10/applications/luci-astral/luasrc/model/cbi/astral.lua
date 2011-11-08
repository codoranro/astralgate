--[[

LuCI astral
(c) 2008 Yanira <forum-2008@email.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: astral.lua 7740 2011-10-16 14:17:11Z soma $

]]--

local uci = luci.model.uci.cursor_state()

m = Map("astral", translate("Astral - VPN/VDS"),
        translatef("This is astral configuration page."))

s = m:section(TypedSection, "gate", translate("Gate"))
s.addremove = false
s.anonymous = true

s:option(Flag, "enabled", translate("enable")).rmempty = false
s:option(Value, "secret", translate("Secret")).rmempty = false
s:option(Value, "hostname", translate("Hostname")).rmempty = false
s:option(Value, "keeper", translate("Keeper")).rmempty = false
mode = s:option(ListValue, "mode",translate("Mode"))
mode:value("switch", translate("switch"))
mode:value("router", translate("router"))

s = m:section(TypedSection, "keeper", translate("Keeper"))
s.addremove = false
s.anonymous = true

s:option(Flag, "enabled", translate("enable")).rmempty = false
s:option(Value, "secret", translate("Secret")).rmempty = false
s:option(Value, "storage", translate("Storage")).rmempty = false

return m
