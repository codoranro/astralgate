--[[

LuCI UVC Streamer
(c) 2008 Yanira <forum-2008@email.de>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id: mjpg-streamer.lua 7740 2011-10-16 14:17:11Z soma $

]]--

local uci = luci.model.uci.cursor_state()

m = Map("mjpg-streamer", translate("mjpg-streamer - WebCam"),
        translatef("First you have to install the packages to get support for UVC usb cams (kmod-video-uvc). For optimal performance, please use cams with hardware jpeg compression!"))

s = m:section(TypedSection, "mjpg-streamer", translate("Settings"))
s.addremove = true
s.anonymous = true

s:option(Flag, "enabled", translate("enable"))

s:option(Value, "device", translate("Device")).rmempty = true

s:option(Value, "port", translate("Port")).rmempty = true

s:option(Value, "resolution", translate("Resolution")).rmempty = true

s:option(Value, "fps", translate("FPS")).rmempty = true


return m
