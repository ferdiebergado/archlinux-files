-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local vicious = require("vicious")
local cascade = require("lain.layout.cascade")
local switcher = require("awesome-switcher")
switcher.settings.preview_box_title_font = {"Ace Futurism","italic","normal"} -- the font for cairo

-- require("collision") {
-- 	--        Normal    Xephyr       Vim      G510
-- 	up    = { "Up"    , "&"        , "k"   , "F15" },
-- 	down  = { "Down"  , "KP_Enter" , "j"   , "F14" },
-- 	left  = { "Left"  , "#"        , "h"   , "F13" },
-- 	right = { "Right" , "\""       , "l"   , "F17" },
-- }

-- Naughty presets
naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = 8
naughty.config.defaults.gap = 1
naughty.config.defaults.ontop = true
naughty.config.defaults.font = "Misc Ohsnap 8"
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = 64
naughty.config.defaults.fg = beautiful.fg
naughty.config.defaults.bg = beautiful.bg
naughty.config.defaults.border_color = beautiful.border_tooltip
naughty.config.defaults.border_width = 1
naughty.config.defaults.hover_timeout = nil

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s &)", cmd, cmd))
    end
end

run_once({
    "killall -q dunst",
    "killall -q xsidle.sh"
    -- "lxsession",
    -- "wmname LG3D",
    -- "urxvtd -q -o -f",
    -- "[[ -z $(systemctl --user status clipmenud | grep -ow active) ]] && systemctl --user start clipmenud",
    -- "unclutter --exclude-root",
    -- "xflux -l 14.5 -g 120.9"
})

local notify_cmd = [[
    sh -c 'awesome -v | head -n1; systemctl --failed | head -n2; systemd-analyze'
]]

awful.spawn.easy_async(notify_cmd, function(out)
    naughty.notify({
        text = out,
        icon = os.getenv("HOME") .. "/Downloads/images/awesome-logo.png",
        icon_size = 64,
        timeout = 10
    })
end)

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
theme_dir = gears.filesystem.get_configuration_dir() .. "themes/"
theme = "default"
beautiful.init(theme_dir .. theme ..  "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = terminal .. " -e " .. os.getenv("EDITOR") or "nano"

local browser      = "firefox"
local guieditor    = "vscodium"
--local scrlocker    = "slock"
local launcher = "dmenu-launch"
local fm_cli = terminal .. " -e ranger"
local fm_gui = "spacefm"
local mixer = terminal .. " -e alsamixer"
local pkgman = terminal .. " -e pacui"
local taskswitcher = "dswitcher"
local clipboardmgr = "clipmenu -i -fn 'Misc Ohsnap-12' -p 'Clipboard:' -sb 'orange' -sf 'black' -h 32"
local scriptdir = "/home/d0np0br3/.config/scripts/"
local unmounter = scriptdir .. "dmenumount.sh"
local logoutmgr = scriptdir .. "dmenulogout.sh"
local cli_browser = "xlinks -g -async-dns 0 -anonymous https://search.privacytools.io"
local sysmon = terminal .. " -e " .. scriptdir .. "awesome_tmux"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    cascade,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
-- myawesomemenu = {
--    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--    { "manual", terminal .. " -e man awesome" },
--    { "edit config", editor_cmd .. " " .. awesome.conffile },
--    { "restart", awesome.restart },
--    { "quit", function() awesome.quit() end },
-- }

-- mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                     { "open terminal", terminal }
--                                   }
--                         })

-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                      menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("<span color=\"cyan\"> É %a %d %b %H:%M</span> ")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local iface = "wls1"
local fg = beautiful.fg_normal
local gray = "gray"
local red = "red"
local green = "#a4e22e"

function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

-- CPU
local cpu_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.cpu)
vicious.register(
    cpu_widget, 
    vicious.widgets.cpu,
    function(widget, args) 
        local c = fg
        local b = "normal"
        if args[1] >= 90 then
            c = red
            b = "bold"
        end
        return string.format("  Ñ<span color=%q weight=%q>%3d%%</span> ", c, b, args[1])
    end, 
    2
)

-- Battery
local bat_widget = wibox.widget.textbox()
vicious.register(
    bat_widget, 
    vicious.widgets.bat, 
    function(w, a)
        if (a[2] < 20) then
            naughty.notify({
                preset = "critical",
                text = "Please plug the charger."
            })
        end
        return (" %s %d %s "):format(a[1], a[2], a[3])
        end,
    63, 
    "BAT0"
)

-- thermal
local thermal_cmd = string.format("sh -c %q", "cat /sys/class/thermal/thermal_zone0/temp")
local thermal_widget = awful.widget.watch(thermal_cmd, 12, function(w, s)
        local t = round(tonumber(s:gsub("\n", "") / 1000), 0)
        local c = fg
        local b = "normal"
        if t >= 60 then
            c = red
            b = "bold"
        end
        w:set_markup(string.format(" Ò <span color=%q weight=%q>%2d°C </span> ", c, b, t))
        return
    end)

-- mem
local mem_cmd = string.format("sh -c %q", "free | awk 'NR==2 {print $3}'")
local mem_widget = awful.widget.watch(mem_cmd, 10, function(w, s)
        local mem = round(s:gsub("\n", "") / 1024, 0)
        w:set_text(" Î " .. mem .. " MB ")
        return
    end)

-- hddtemp
local hddtemp_cmd = string.format("sh -c %q", "nc 127.0.0.1 7634 | cut -d '|' -f4")
local hddtemp_widget = awful.widget.watch(hddtemp_cmd, 61, function(w, s)
        local c = fg
        local b = "normal"
        if tonumber(s) >= 50 then
            c = red
            b = "bold"
        end
        w:set_markup(string.format(" ± <span color=%q weight=%q>%2d°C</span> ", c, b, s:gsub("\n", "")))
        return
    end)

-- filesystem
local fs_cmd = string.format("sh -c %q", "df -h --output='avail' /home / | awk 'NR > 1'")
local fs_widget = awful.widget.watch(fs_cmd, 15, function(w ,s)
        local l = " ¨ "
        for line in s:gmatch("[^\r\n]+") do
            l = l .. line:gsub(" ", "") .. " "
        end
        w:set_text(l)
        return
    end)

-- wireless
local wireless_cmd = string.format("sh -c %q", "awk '/" .. iface .. "/{print $3}' /proc/net/wireless")
local wireless_widget = awful.widget.watch(wireless_cmd, 13, function(w, s)
        local link = string.format("<span color=%q> %s </span> ", "gray", "× not connected")
        if s ~= "" then
            link = " ® " .. round((s:gsub("\n", "") / 70) * 100, 0) .. "% "
        end
        w:set_markup(link)
        return
    end)

-- ip
local ip_cmd = string.format("sh -c %q", "ip addr show | grep " .. iface .. " | awk '/inet/{print $2}'")
local ip_widget = awful.widget.watch(ip_cmd, 11, function(w, s)
        local c = gray
        if s ~= "" then
            c = fg
        end
        w:set_markup(string.format("<span color=%q>IP</span> ", c))
        return
    end)

-- dns
local dns_cmd = string.format("sh -c %q", "systemctl status dnscrypt-proxy | tail -n1 | grep 'ready\\|lowest'")
local dns_widget = awful.widget.watch(dns_cmd, 9, function(w, s)
        local c = gray 
        if s ~= "" then
            c = fg
        end
        w:set_markup(string.format("<span color=%q>SDNS</span> ", c))
        return
    end)

-- ping
local server = "1.1.1.1"
local ping_cmd = string.format("sh -c %q", "ping -c 1 " .. server .. " | grep icmp | cut -d'=' -f4")
local ping_widget = awful.widget.watch(ping_cmd, 7, function(w, s)
        local net = "NONET"
        local c = gray
        if s ~= "" then
            net = s:gsub("\n", "")
            c = fg
        end
        w:set_markup(string.format("<span color=%q>%s</span> ", c, net))
        return
    end)

-- vpn
local vpn_cmd = string.format("sh -c %q", "ip addr show | grep tun | awk '/inet/{print $2}'")
local vpn_widget = awful.widget.watch(vpn_cmd, 5, function(w, s)
        local now = { ip = "SEC", c = gray, b = "normal" }
        if s ~= "" then
            now.c = green
            now.b = "bold"
			-- cmd = "awk -F ',' '{print $5}' /tmp/vpngate.txt"
			-- awful.spawn.easy_async_with_shell(cmd, function(o)
			-- 	now.ip = o / 1024 / 1024 .. " MBPS"
			-- 	-- naughty.notify({ text = ip})
			-- end)
        end
        w:set_markup(string.format("<span color=%q weight=%q>%s</span>", now.c, now.b, now.ip))
        return
    end)

-- net
local net_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.net)
vicious.register(net_widget, vicious.widgets.net, function(w, a)
    local net = ""
    if a["{wls1 down_kb}"] ~= nil then
        net = string.format(" ß %s Ü %s kb/s ", a["{wls1 down_kb}"], a["{wls1 up_kb}"])
    end
    return net
    end, 3)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, window = "Wibar" })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        -- nil,
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            cpu_widget,
            thermal_widget,
            mem_widget,
            fs_widget,
            hddtemp_widget,
            wireless_widget,
            ip_widget,
            dns_widget,
            ping_widget,
            vpn_widget,
            -- wifi_widget,
            -- mykeyboardlayout,
            net_widget,
            bat_widget,
            mytextclock,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --           {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    awful.key({ "Mod1",           }, "Tab",
      function ()
          switcher.switch( 1, "Mod1", "Alt_L", "Shift", "Tab")
      end),
    
    awful.key({ "Mod1", "Shift"   }, "Tab",
      function ()
          switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
      end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "d", function() awful.spawn(launcher) end,
              {description = "open launcher", group = "launcher"}),
    awful.key({ modkey,           }, "q", function() awful.spawn(browser) end,
              {description = "open browser", group = "launcher"}),
    awful.key({ modkey, "Control"   }, "f", function() awful.spawn(fm_cli) end,
              {description = "open console file manager", group = "launcher"}),
    awful.key({ modkey, "Control"   }, "s", function() awful.spawn(fm_gui) end,
              {description = "open gui file manager", group = "launcher"}),
    awful.key({ modkey, "Control"   }, "v", function() awful.spawn(mixer) end,
              {description = "open volume mixer", group = "launcher"}),
    awful.key({ modkey, "Control"   }, "p", function() awful.spawn(pkgman) end,
              {description = "open package manager", group = "launcher"}),
    awful.key({ modkey, "Control"   }, "e", function() awful.spawn(editor) end,
              {description = "launch text editor", group = "launcher"}),
    awful.key({ modkey,           }, "b", function() awful.spawn(cli_browser) end,
              {description = "open command line browser", group = "launcher"}),
    awful.key({ "Control", modkey }, "x", function () awful.spawn(sysmon) end,
            {description = "Show system dashboard", group = "launcher"}),

    awful.key({ "Control", modkey }, "i", function () awful.spawn(clipboardmgr) end,
            {description = "select clipboard content", group = "launcher"}),
    awful.key({ "Control", modkey }, "u", function () awful.spawn(unmounter) end,
            {description = "unmount devices", group = "launcher"}),
    --awful.key({ modkey }, "0", function () awful.spawn("oblogout_blur") end,
    awful.key({ modkey }, "0", function () awful.spawn.with_shell(logoutmgr) end,
            {description = "run logout menu", group = "launcher"}),
    -- awful.key({ altkey }, "Tab", function () awful.spawn(taskswitcher) end,
    --         {description = "run window switcher", group = "launcher"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    -- ALSA volume control
    awful.key({  }, "XF86AudioRaiseVolume",
        function ()
            awful.util.spawn("amixer -q set Master 5%+")
        end,
        {description = "volume up", group = "hotkeys"}),
    awful.key({  }, "XF86AudioLowerVolume",
        function ()
            awful.util.spawn("amixer -q set Master 5%-")
        end,
        {description = "volume down", group = "hotkeys"}),
    awful.key({  }, "XF86AudioMute",
        function ()
            awful.util.spawn("amixer -q set Master toggle")
        end,
        {description = "toggle mute", group = "hotkeys"}),

    -- Screenshot
    awful.key({ }, "Print",
        function()
            local ext = ".png"
            local tmpdir = "/tmp/"
            local filename = os.date("%Y-%m-%d-%H%M%S")
            local filepath = tmpdir .. filename .. ext
            local file = filename .. ext
            local dir = "~/Pictures/screenshots/"
            local screenshot = ("scrot -t 10 %q && mv %q %s"):format(filepath, filepath, dir)
            os.execute(screenshot)
            naughty.notify({
                icon =  tmpdir .. filename .. "-thumb" .. ext,
                title = "SCREENSHOT",
                icon_size = 128,
                text = ("Saved to %s%s"):format(dir, file)
            })
        end,
        {description = "take a screenshot", group = "hotkeys"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Firefox",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = true})
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
