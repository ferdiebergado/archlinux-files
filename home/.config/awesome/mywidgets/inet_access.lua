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
    local inet_access     = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 10
    -- local host  = args.host or "108.61.161.119"
    local host  = args.host or "1.1.1.1"
    local settings = args.settings or function() end

    function inet_access.update()
        local command = "ping -c 1 " .. host

        awful.spawn.easy_async_with_shell(command, function(out)
            inet_access_now = 0
            if string.match(out, '1 received') ~= nil then
                inet_access_now = 1
            end
        end)        
        widget = inet_access.widget
        settings()
    end

    helpers.newtimer("inet_access", timeout, inet_access.update)

    return inet_access
end

return factory
