--[[

LuCI mmc_over_gpio
(c) 2008 Yanira <forum-2008@email.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: mmc_over_gpio.lua 7810 2011-10-28 15:15:27Z jow $

]]--

module("luci.controller.mmc_over_gpio", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/mmc_over_gpio") then
		return
	end

	local page

	page = entry({"admin", "system", "mmc_over_gpio"}, cbi("mmc_over_gpio"), _("MMC/SD driver configuration"), 60)
	page.i18n = "mmc_over_gpio"
	page.dependent = true
end
