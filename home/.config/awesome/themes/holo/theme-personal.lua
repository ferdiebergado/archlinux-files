--[[

     Holo Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local disktemp_widget = require("mywidgets.disktemp")
local inetaccess_widget = require("mywidgets.inet_access")
-- local net_widgets = require("net_widgets")

-- local wifi_widget = require("mywidgets.wifi")
local string, os = string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local cyan = "#00ffff"
-- local cyan2 = "#009689"
local theme                                     = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
--theme.wallpaper                                 = os.getenv("HOME") .. "/Downloads/images/vehicle-6201.jpg"
theme.wallpaper                                 = os.getenv("HOME") .. "/Downloads/images/general-2964.jpg"
theme.font                                      = "Misc Ohsnap.Icons 8"
theme.taglist_font                              = "Roboto Condensed Regular 8"
theme.tasklist_font                             = "Ace Futurism Regular 12"
theme.fg_normal                                 = "#E0E0E0"
theme.fg_focus                                  = "#0099CC"
theme.bg_focus                                  = "#303030"
--theme.bg_normal                                  = "#5c4827"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#006B8E"
theme.border_width                              = dpi(3)
theme.border_normal                             = theme.fg_normal
-- theme.border_focus                              = "#0099CC"
theme.border_focus                              = "#b0b0b0"
theme.taglist_fg_focus                          = "#FFFFFF"
theme.tasklist_bg_normal                        = "#222222"
theme.tasklist_fg_focus                         = "#4CB7DB"
-- theme.tasklist_fg_focus                         = cyan
--theme.menu_height                               = dpi(20)
--theme.menu_width                                = dpi(160)
--theme.menu_icon_size                            = dpi(32)
theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/awesome_icon.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"
theme.bar                                       = theme.icon_dir .. "/bar.png"
theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"
--theme.mpdl                                      = theme.icon_dir .. "/mpd.png"
--theme.mpd_on                                    = theme.icon_dir .. "/mpd_on.png"
--theme.prev                                      = theme.icon_dir .. "/prev.png"
--theme.nex                                       = theme.icon_dir .. "/next.png"
--theme.stop                                      = theme.icon_dir .. "/stop.png"
--theme.pause                                     = theme.icon_dir .. "/pause.png"
--theme.play                                      = theme.icon_dir .. "/play.png"
--theme.clock                                     = theme.icon_dir .. "/clock.png"
--theme.calendar                                  = theme.icon_dir .. "/cal.png"
--theme.cpu                                       = theme.icon_dir .. "/cpu.png"
--theme.net_up                                    = theme.icon_dir .. "/net_up.png"
--theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"
theme.layout_cascade                            = theme.icon_dir .. "/cascade2.png"
theme.layout_cascadetile                        = theme.icon_dir .. "/cascadetilew.png"
theme.layout_termfair                           = theme.icon_dir .. "/termfair2.png"
theme.layout_cornernw                           = theme.icon_dir .. "/cornernw.png"
--theme.layout_centerwork                         = theme.icon_dir .. "/centerworkw.png"
--theme.tasklist_plain_task_name                  = true
-- theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(6)
theme.titlebar_close_button_normal              = theme.default_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.default_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.default_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.default_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.default_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.default_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.default_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.default_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.default_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.default_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.default_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.default_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.default_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.default_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.default_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.default_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.default_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.default_dir.."/titlebar/maximized_focus_active.png"

--theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

local markup = lain.util.markup
-- local blue   = "#80CCE6"
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup("#00FFFF", space3 .. "%H:%M " .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font
-- local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(mytextclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(5), dpi(5))

-- Calendar
local mytextcalendar = wibox.widget.textclock(
    markup.fontfg(
        theme.font, 
        theme.fg_normal, 
        space3 .. "É %a %d %b " .. markup.font("Roboto 5", " ")
    )
)
-- local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(mytextcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, dpi(0), dpi(0), dpi(5), dpi(5))
theme.cal = lain.widget.cal({
    attach_to = { mytextclock, mytextcalendar },
    followtag = true,
    notification_preset = {
        fg = theme.fg_normal,
        bg = theme.bg_normal,
        position = "top_right",
        font = "TamzenForPowerline 12"
    }
})

-- Mail IMAP check
--[[ commented because it needs to be set before use
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        mail_notification_preset.fg = "#FFFFFF"
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(blue, mail) .. markup("#FFFFFF", count)))
    end
})
--]]

-- MPD
--[[
local mpd_icon = awful.widget.launcher({ image = theme.mpdl, command = theme.musicplr })
local prev_icon = wibox.widget.imagebox(theme.prev)
local next_icon = wibox.widget.imagebox(theme.nex)
local stop_icon = wibox.widget.imagebox(theme.stop)
local pause_icon = wibox.widget.imagebox(theme.pause)
local play_pause_icon = wibox.widget.imagebox(theme.play)
theme.mpd = lain.widget.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            widget:set_markup(markup.font("Roboto 4", " ")
                              .. markup.font(theme.taglist_font,
                              " " .. mpd_now.artist
                              .. " - " ..
                              mpd_now.title .. "  ") .. markup.font("Roboto 5", " "))
            play_pause_icon:set_image(theme.pause)
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font("Roboto 4", " ") ..
                              markup.font(theme.taglist_font, " MPD PAUSED  ") ..
                              markup.font("Roboto 5", " "))
            play_pause_icon:set_image(theme.play)
        -- else
        --     widget:set_markup("")
        --     play_pause_icon:set_image(theme.play)
        end
    end
})
local musicbg = wibox.container.background(theme.mpd.widget, theme.bg_focus, gears.shape.rectangle)
local musicwidget = wibox.container.margin(musicbg, dpi(0), dpi(0), dpi(5), dpi(5))

musicwidget:buttons(my_table.join(awful.button({ }, 1,
function () awful.spawn(theme.musicplr) end)))
prev_icon:buttons(my_table.join(awful.button({}, 1,
function ()
    os.execute("mpc prev")
    theme.mpd.update()
end)))
next_icon:buttons(my_table.join(awful.button({}, 1,
function ()
    os.execute("mpc next")
    theme.mpd.update()
end)))
stop_icon:buttons(my_table.join(awful.button({}, 1,
function ()
    play_pause_icon:set_image(theme.play)
    os.execute("mpc stop")
    theme.mpd.update()
end)))
play_pause_icon:buttons(my_table.join(awful.button({}, 1,
function ()
    os.execute("mpc toggle")
    theme.mpd.update()
end)))
]]

-- Battery
local bat = lain.widget.bat({
    timeout = 13,
    settings = function()
        local bat_p      = bat_now.perc .. "% " .. bat_now.time .. " "
        local fg = "orange"
        if bat_now.ac_status == 1 then
            if bat_now.status == "Charging" then
                bat_p = "µ " .. bat_p
            else
                bat_p = "¡"
                fg = "#a4e22e"
            end
        else
            --if bat_now.status == "Discharging" then
                if bat_now.perc < 20 then
                    fg = "red"
                end
                bat_p = "÷ " .. bat_p
            --end
        end
        widget:set_markup(markup.fontfg(theme.font, fg, bat_p))
    end
})

local batbg = wibox.container.background(bat.widget, theme.bg_focus, gears.shape.rectangle)
local batwidget = wibox.container.margin(batbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- / fs
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { bg = theme.bg_normal, font = "Monospace 9" },
})
--]]

-- ALSA volume bar
--[[
theme.volume = lain.widget.alsabar({
    notification_preset = { font = "Monospace 9"},
    --togglechannel = "IEC958,3",
    width = dpi(80), height = dpi(10), border_width = dpi(0),
    ticks = true,
    ticks_size = 4,
    colors = {
        background = "#383838",
        unmute     = "#80CCE6",
        mute       = "#FF9F9F"
    },
})
theme.volume.bar.paddings = dpi(1)
theme.volume.bar.margins = dpi(5)
local volumewidget = wibox.container.background(theme.volume.bar, theme.bg_focus, gears.shape.rectangle)
volumewidget = wibox.container.margin(volumewidget, dpi(0), dpi(0), dpi(5), dpi(5))
]]

-- CPU
--local cpu_icon = wibox.widget.imagebox(theme.cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(space3 .. markup.font(theme.font, " Ñ " .. string.format("%3d", cpu_now.usage)
                          .. "% ") .. markup.font("Roboto 5", " "))
    end
})
local cpubg = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Net
--local netdown_icon = wibox.widget.imagebox(theme.net_down)
--local netup_icon = wibox.widget.imagebox(theme.net_up)
local net = lain.widget.net({
    iface = "wls1",
    settings = function()
        local m = markup.fontfg(theme.font, "gray", " × not connected ")
        if net_now.carrier == "1" then
            m = markup.font("Roboto 1", " ") .. markup.font(
                theme.font, 
                " ß " .. net_now.received .. " Ü " .. net_now.sent) .. markup.font("Roboto 2", " ")
        end
        widget:set_markup(m)
    end
})
local netbg = wibox.container.background(net.widget, theme.bg_focus, gears.shape.rectangle)
local networkwidget = wibox.container.margin(netbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Weather
--[[
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = "Monospace 9", position = "bottom_right" },
})
]]

-- Launcher
--local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher })
--mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

-- Temperature Widget
local temp = lain.widget.temp {
    timeout = 8,
    settings = function()
        local fg_color = theme.fg_normal
        local temp_icon = "±"
        if coretemp_now >= 60 then
            fg_color = "red"
            --temp_icon = ""
        end

        widget:set_markup(markup.fontfg(theme.font, fg_color, temp_icon .. " " .. coretemp_now .. "°C "))
    end
}
local tempbg = wibox.container.background(temp.widget, theme.bg_focus, gears.shape.rectangle)
local tempwidget = wibox.container.margin(tempbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Filesystem Widget
local fs = lain.widget.fs {
    timeout = 10,
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    },    
    settings = function()
        widget:set_markup(
            markup.font(
                theme.font, 
                string.format(
                    "¹ %.2f", 
                    fs_now["/"].free) .. " " .. fs_now["/"].units .. " " .. string.format(
                        "© %.2f", 
                        fs_now["/home"].free) .. " " .. fs_now["/home"].units .. " "
                )
        )
    end
}
local fsbg = wibox.container.background(fs.widget, theme.bg_focus, gears.shape.rectangle)
local fswidget = wibox.container.margin(fsbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Memory Widget
local mem = lain.widget.mem {
    timeout = 5,
    settings = function()
        widget:set_markup(markup.font(theme.font, "Î " .. string.format("%4d", mem_now.used) .. " MB "))
    end
}
local membg = wibox.container.background(mem.widget, theme.bg_focus, gears.shape.rectangle)
local memwidget = wibox.container.margin(membg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Disktemp Widget
local disktemp = disktemp_widget {
    timeout = 30,
    settings = function()
        local fg = theme.fg_normal
        if tonumber(disktemp_now) >= 50 then
            fg = "red"
        end
        widget:set_markup(markup.fontfg(theme.font, fg, string.format("ª %2d", disktemp_now) .. "°C "))
    end
}
local disktempbg = wibox.container.background(disktemp.widget, theme.bg_focus, gears.shape.rectangle)
local disktempwidget = wibox.container.margin(disktempbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- Systray Widget
local systray = wibox.widget.systray()
systray:set_base_size(32)
local systraywidget = wibox.container.margin(systray, 0, 0, 6, 6)

-- internet access
local inetaccess = inetaccess_widget {
    timeout = 5,
    settings = function ()
            local icon = "¯"
            local fg = "gray"
            if inet_access_now == 1 then
                fg = "#a4e22e"
            end
            widget:set_markup(markup.fontfg(theme.font, fg, icon .. " "))
        end
}
local inetaccessbg = wibox.container.background(inetaccess.widget, theme.bg_focus, gears.shape.rectangle)
local inet_access_widget = wibox.container.margin(inetaccessbg, dpi(0), dpi(0), dpi(5), dpi(5))

-- net_wireless = net_widgets.wireless({
--     interface="wls1",
--     font = theme.font
-- })

-- Now Playing Widget
--[[
nowplaying = wibox.widget.textbox()
nowplaying:set_markup(markup.fontfg(theme.font, "yellow", " à "))
local nowplayingbg = wibox.container.background(nowplaying, theme.bg_focus, gears.shape.rectangle)
local nowplaying_icon = wibox.container.margin(nowplayingbg, dpi(0), dpi(0), dpi(5), dpi(5))
]]

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
-- local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
-- local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
-- local spr_left = wibox.widget.imagebox(theme.spr_left)
-- local bar = wibox.widget.imagebox(theme.bar)
local bottom_bar = wibox.widget.imagebox(theme.bottom_bar)

local barcolor  = gears.color({
    type  = "linear",
    from  = { dpi(32), 0 },
    to    = { dpi(32), dpi(32) },
    stops = { {0, theme.bg_focus}, {0.25, "#505050"}, {1, theme.bg_focus} }
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({
        app = awful.util.terminal,
        extra = " -e /home/d0np0br3/.config/scripts/awesome_quake_tmux",
        height = 0.36,
        settings = function(c)
            c.sticky = true
        end
    })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { bg_focus = barcolor })

    mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rectangle)
    s.mytag = wibox.container.margin(mytaglistcont, dpi(0), dpi(0), dpi(5), dpi(5))

    -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, awful.util.tasklist_buttons, { bg_focus = theme.bg_focus, shape = gears.shape.rectangle, shape_border_width = 5, shape_border_color = theme.tasklist_bg_normal, align = "center" }
-- {
--         spacing = 10,
--         spacing_widget = {
--             {
--                 forced_width = 5,
--                 shape        = gears.shape.circle,
--                 widget       = wibox.widget.separator
--             },
--             valign = 'center',
--             halign = 'center',
--             widget = wibox.container.place,
--         },
--         layout  = wibox.layout.flex.horizontal
--     },
--     -- Notice that there is *NO* wibox.wibox prefix, it is a template,
--     -- not a widget instance.
--     {
--         {
--             {
--                 {
--                     {
--                         id     = 'icon_role',
--                         widget = wibox.widget.imagebox,
--                     },
--                     margins = 2,
--                     widget  = wibox.container.margin,
--                 },
--                 {
--                     id     = 'text_role',
--                     widget = wibox.widget.textbox,
--                 },
--                 layout = wibox.layout.fixed.horizontal,
--             },
--             left  = 10,
--             right = 10,
--             widget = wibox.container.margin
--         },
--         id     = 'background_role',
--         widget = wibox.container.background,
--     }    
    -- )
s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.focused,
    buttons  = tasklist_buttons,
    style    = {
        shape_border_width = 5,
        shape_border_color = theme.bg_normal,
        shape  = gears.shape.rectangle,
    },
    -- layout   = {
    --     spacing = 10,
    --     spacing_widget = {
    --         {
    --             forced_width = 5,
    --             shape        = gears.shape.circle,
    --             widget       = wibox.widget.separator
    --         },
    --         valign = 'center',
    --         halign = 'center',
    --         widget = wibox.container.place,
    --     },
    --     layout  = wibox.layout.flex.horizontal
    -- },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 6,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 10,
            right = 10,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },
}
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(32) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            first,
            spr_right,
            s.mytag,
            spr_small,
            s.mylayoutbox,
            spr_small,
            first,
            first,
            s.mypromptbox,
        },
        nil, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --theme.mail.widget,
            --bat.widget,
            spr_right,
            --cpu_icon,
            cpuwidget,
            bottom_bar,
            tempwidget,
            bottom_bar,
            memwidget,
            bottom_bar,
            fswidget,
            disktempwidget,
            bottom_bar,
            --netdown_icon,
            -- net_wireless,
            inet_access_widget,
            networkwidget,
            --netup_icon,
            bottom_bar,
            batwidget,
            bottom_bar,
            --calendar_icon,
            --spr_small,
            calendarwidget,
            --bottom_bar,
            --clock_icon,
            clockwidget,
            first,
        },
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = dpi(0), height = dpi(32) })
    --s.borderwibox = awful.wibar({ position = "bottom", screen = s, height = dpi(1), bg = theme.fg_focus, x = dpi(0), y = dpi(33)})

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --mylauncher,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --wibox.container.margin(wibox.widget.systray(), 0, 0, 5, 5),
            --wibox.widget.systray(),
            --spr_right,
            --nowplaying_icon,
            --spr_left,
            systraywidget,
            --spr_bottom_right,
            --musicwidget,
            --bar,
            --prev_icon,
            --next_icon,
            --stop_icon,
            --play_pause_icon,
            --bar,
            --mpd_icon,
            --bar,
            --spr_very_small,
            --volumewidget,
            --spr_left,
        },
    }
end

return theme