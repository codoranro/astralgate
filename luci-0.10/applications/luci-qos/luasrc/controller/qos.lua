--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id: qos.lua 7810 2011-10-28 15:15:27Z jow $
]]--

module("luci.controller.qos", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/qos") then
		return
	end
	
	local page

	page = entry({"admin", "network", "qos"}, cbi("qos/qos"), _("QoS"))
	page.i18n = "qos"
	page.dependent = true

	page = entry({"mini", "network", "qos"}, cbi("qos/qosmini", {autoapply=true}), _("QoS"))
	page.i18n = "qos"
	page.dependent = true
end
