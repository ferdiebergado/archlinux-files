local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
-- local naughty = require("naughty")
local gears = require("gears")
-- local module_path = (...):match("(.+/)[^/]+$") or ""

local lain = require("lain")
local markup = lain.util.markup
local naughty = require("naughty")

local fs_temp = {}
local function worker(args)
    local args = args or {}
    
    widgets_table = {}
    
    -- Settings
    local timeout = args.timeout or 5
    local font = args.font or beautiful.font
    local widget = args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent = args.indent or 3
    
    local na = " N/A "
    local function temp_update()
        local temp_cmd = [[ /usr/bin/nc 127.0.0.1 7634 | awk -F '|' '{print $4}' ]]
        awful.spawn.easy_async_with_shell(
        temp_cmd,
        function(stdout, stderr, reason, exit_code)
            -- temp = string.format("%s°C ", stdout:gsub("\n", ""))
            temp = stdout:gsub("\n", "")
        end
    )
    if temp == nil then
        fs_temp.now = na
    else
        if tonumber(temp) <= 50 then
            color = "#80d9d8"
        else
            color = "red"
            ssdtemp_id = naughty.notify({
                title = "Warning:",
                text = "SSD Temp High!",
                icon = "/home/d0np0br3/Downloads/images/temperature-icon.png",
                replaces_id = ssdtemp_id
            }).id
        end
        fs_temp.now = string.format("%s°C", temp)
    end
    return fs_temp
end

temp_update()
local timer =
gears.timer.start_new(
timeout,
function()
    temp_update()
    return true
end
)

widgets_table["textbox"] = fstemptextwidget
if widget then       
    -- Hide the text when we want to popup the signal instead
    if not popup_signal then
        widget:add(fstemptextwidget)
    end
    -- wireless:attach(widget,{onclick = onclick})
end
return widget or widgets_table
end

return setmetatable(
fs_temp,
{
    __call = function(_, ...)
        return worker(...)
    end
}
)
