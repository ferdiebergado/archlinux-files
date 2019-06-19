--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luca CPZ
      * (c) 2010, Adrian C. <anrxc@sysphere.org>

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local naughty = require("naughty")

-- VPN status
-- lain.widget.vpnstat

local function factory(args)
    local vpnstat     = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end
    local cmd = [[bash -c 'ip addr show | grep -i tun']]

    function vpnstat.update()
        helpers.async(cmd, function(s)
            local state = "up"
            if s == '' then
                state = "down"
            end

            vpnstatus_now = { status = state }
            widget = vpnstat.widget
            settings()
        end)
    end

    helpers.newtimer("vpnstat", timeout, vpnstat.update)

    return vpnstat
end

return factory
