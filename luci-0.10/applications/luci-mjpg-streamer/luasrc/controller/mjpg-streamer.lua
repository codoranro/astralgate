--[[

LuCI UVC Streamer
(c) 2008 Yanira <forum-2008@email.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: mjpg-streamer.lua 5448 2009-10-31 15:54:11Z jow $

]]--

module("luci.controller.mjpg-streamer", package.seeall)

function index()
       require("luci.i18n")
       luci.i18n.loadc("mjpg-streamer")
       if not nixio.fs.access("/etc/config/mjpg-streamer") then
               return
       end

       local page = entry({"admin", "services", "mjpg-streamer"}, cbi("mjpg-streamer"), luci.i18n.translate("mjpg-streamer - WebCam"), 60)
       page.i18n = "mjpg-streamer"
       page.dependent = true
end
