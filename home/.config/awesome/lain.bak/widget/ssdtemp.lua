
--[[

Licensed under GNU General Public License v2 
* (c) 2013, Luke Bonham                     

--]]

local helpers  = require("lain.helpers")
local shell    = require("awful.util").shell
local focused  = require("awful.screen").focused
local wibox    = require("wibox")
local naughty  = require("naughty")
local string   = string
local tonumber = tonumber
local easy_async = require("awful.spawn").easy_async

-- File system disk space usage
-- lain.widget.fs

local function factory(args)
    -- local fs = { unit  = { ["mb"] = 1024, ["gb"] = 1024^2 }, widget = wibox.widget.textbox() }
    
    function ssdtemp.hide()
        if not ssdtemp.notification then return end
        naughty.destroy(ssdtemp.notification)
        ssdtemp.notification = nil
    end
    
    function ssdtemp.show(seconds, scr)
        ssdtemp.update()
        ssdtemp.hide()
        
        if ssdtemp.followtag then
            ssdtemp.notification_preset.screen = focused()
        else
            ssdtemp.notification_preset.screen = scr or 1
        end
        
        ssdtemp.notification = naughty.notify({
            preset  = ssdtemp.notification_preset,
            timeout = seconds or 5
        })
    end
    
    local args             = args or {}
    local timeout          = args.timeout or 600
    local partition        = args.partition or "/"
    local showpopup        = args.showpopup or "on"
    local notify           = args.notify or "on"
    local settings         = args.settings or function() end
    --local tempcmd = [[ bash -c "nc 127.0.0.1 7634 | awk -F '|' '{print $4}'" ]]
    
    ssdtemp.options             = args.options
    ssdtemp.followtag           = args.followtag or false
    ssdtemp.notification_preset = args.notification_preset
    
    if not ssdtemp.notification_preset then
        ssdtemp.notification_preset = {
            font = "Monospace 10",
            fg   = "#FFFFFF",
            bg   = "#000000"
        }
    end
    
    helpers.set_map(partition, false)
    
    function ssdtemp.update()
        
        hddtemp_info  = {}        
        helpers.async({shell, "-c", "/usr/bin/nc 127.0.0.1 7634 | awk -F '|' '{print $4}'"}, function(s)
            hddtemp_info.temp = s:gsub("\n","")
        end)        
        notification_preset = ssdtemp.notification_preset
        widget = ssdtemp.widget
        settings()        
        if notify == "on" and tonumber(hddtemp_info.temp) >= 50 and not helpers.get_map(partition) then
            naughty.notify({
                preset = naughty.config.presets.critical,
                title  = "Warning",
                text   = "SSD Temperature is high.",
            })
            helpers.set_map(partition, true)
        else
            helpers.set_map(partition, false)
        end
    
    local notifycmd = (ssdtemp.options and string.format("dfs %s", ssdtemp.options)) or "dfs"
    helpers.async(helpers.scripts_dir .. notifycmd, function(ws)
        ssdtemp.notification_preset.text = ws:gsub("\n*$", "")
    end)
end

if showpopup == "on" then
    ssdtemp.widget:connect_signal('mouse::enter', function () ssdtemp.show(0) end)
    ssdtemp.widget:connect_signal('mouse::leave', function () ssdtemp.hide() end)
end

helpers.newtimer(partition, timeout, ssdtemp.update)

return fs
end

return factory
