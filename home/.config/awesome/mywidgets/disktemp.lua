--[[

     Licensed under GNU General Public License v2
      * (c) 2019, Ferdinand Saporas Bergado

--]]

local helpers  = require("lain.helpers")
local wibox    = require("wibox")

-- disktemp
-- mywidgets.disktemp
-- connects to hddtemp daemon to fetch disk temperature
-- be sure to have hddtemp installed and running

local function factory(args)
    local disktemp     = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 10
    local host  = args.host or "127.0.0.1"
    local port = args.port or 7634
    local settings = args.settings or function() end

    function disktemp.update()
        local socket = require("socket")
        local tcp = assert(socket.tcp())
        s = tcp:connect(host, port)
        if s == 1 then
            local s, status, partial = tcp:receive()
            disktemp_now = partial:match("%d+|"):gsub("|", "")
        else
            disktemp_now = "N/A"
        end
        --tcp.close()
        widget = disktemp.widget
        settings()
    end

    helpers.newtimer("disktemp", timeout, disktemp.update)

    return disktemp
end

return factory
