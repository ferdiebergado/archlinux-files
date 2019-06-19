--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ

--]]

local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local open     = io.open
local tonumber = tonumber
local awful     = require("awful")

-- fstemp
-- lain.widget.fstemp

local function factory(args)
    local fstemp     = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 2
    local settings = args.settings or function() end

    function fstemp.update()
        local temp_cmd = [[ /usr/bin/nc 127.0.0.1 7634 | awk -F '|' '{print $4}' ]]
        awful.spawn.easy_async_with_shell(
        temp_cmd,
        function(stdout, stderr, reason, exit_code)
            -- temp = string.format("%s°C ", stdout:gsub("\n", ""))
            temp = stdout:gsub("\n", "")
        end
    )
    if temp == nil then
        fstemp_now = "n/a"
    else
        if tonumber(temp) > 50 then
            ssdtemp_id = naughty.notify({
                title = "Warning:",
                text = "SSD Temp High!",
                icon = "/home/d0np0br3/Downloads/images/temperature-icon.png",
                replaces_id = ssdtemp_id
            }).id
        end
        fstemp_now = string.format("%sC", temp)
    end
        widget = fstemp.widget
        settings()
    end

    helpers.newtimer("fstemp", timeout, fstemp.update)

    return fstemp
end

return factory
