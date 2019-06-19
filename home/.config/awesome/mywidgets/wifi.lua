--[[

     Licensed under GNU General Public License v2
      * (c) 2019, Ferdinand Saporas Bergado

--]]

local helpers  = require("lain.helpers")
local wibox    = require("wibox")
local awful    = require("awful")

-- inet_access
-- checks for internet access
local function factory(args)
    local wifi_access     = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 10
    -- local host  = args.host or "108.61.161.119"
    local settings = args.settings or function() end

    function wifi_access.update()
        local command = "iwgetid -r"

        awful.spawn.easy_async_with_shell(command, function(out)
            wifi_now = 0
            if out ~= nil then
                wifi_now = 1
            end
        end)        
        widget = wifi_access.widget
        settings()
    end

    helpers.newtimer("wifi_access", timeout, wifi_access.update)

    return wifi_access
end

return factory
