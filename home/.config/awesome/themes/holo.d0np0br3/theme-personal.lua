--[[

Holo Awesome WM theme 3.0
github.com/lcpz

--]]
local gears = require("gears")
lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local net_widgets = require("net_widgets")
local string = string
local os = {getenv = os.getenv}
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}
theme.default_dir = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/Downloads/images/archgray.jpeg"
theme.font = "Misc Ohsnap 8"
theme.calendar_font = "Termsyn 10"
theme.taglist_font = theme.font
theme.fg_normal = "#FFFFFF"
theme.fg_focus = "#0099CC"
theme.bg_focus = "#303030"
theme.bg_normal = "#242424"
theme.fg_urgent = "#CC9393"
theme.bg_urgent = "#006B8E"
theme.border_width = 1
--theme.border_normal = "#232223"
theme.border_normal = "#31363b"
theme.border_focus = "#0099CC"
theme.taglist_fg_focus = "#FFFFFF"
theme.tasklist_bg_normal = "#222222"
theme.tasklist_fg_focus = "#4CB7DB"
theme.menu_height = 20
theme.menu_width = 160
theme.menu_icon_size = 32
theme.awesome_icon = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher = theme.icon_dir .. "/awesome_icon.png"
theme.taglist_squares_sel = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel = theme.icon_dir .. "/square_unsel.png"
theme.spr_small = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left = theme.icon_dir .. "/spr_left.png"
theme.bar = theme.icon_dir .. "/bar.png"
theme.bottom_bar = theme.icon_dir .. "/bottom_bar.png"
theme.mpdl = theme.icon_dir .. "/mpd.png"
theme.mpd_on = theme.icon_dir .. "/mpd_on.png"
theme.prev = theme.icon_dir .. "/prev.png"
theme.nex = theme.icon_dir .. "/next.png"
theme.stop = theme.icon_dir .. "/stop.png"
theme.pause = theme.icon_dir .. "/pause.png"
theme.play = theme.icon_dir .. "/play.png"
theme.clock = theme.icon_dir .. "/clock.png"
theme.calendar = theme.icon_dir .. "/cal.png"
theme.cpu = theme.icon_dir .. "/cpu.png"
theme.mem = theme.icon_dir .. "/mem.png"
theme.temp = theme.icon_dir .. "/temp.png"
theme.fs = theme.icon_dir .. "/fs.png"
theme.net_up = theme.icon_dir .. "/net_up.png"
theme.net_down = theme.icon_dir .. "/net_down.png"
theme.vol = theme.icon_dir .. "/vol.png"
theme.vol_low = theme.icon_dir .. "/vol_low.png"
theme.vol_no = theme.icon_dir .. "/vol_no.png"
theme.vol_mute = theme.icon_dir .. "/vol_mute.png"
theme.layout_tile = theme.icon_dir .. "/tile.png"
theme.layout_tileleft = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv = theme.icon_dir .. "/fairv.png"
theme.layout_fairh = theme.icon_dir .. "/fairh.png"
theme.layout_spiral = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle = theme.icon_dir .. "/dwindle.png"
theme.layout_max = theme.icon_dir .. "/max.png"
theme.layout_fullscreen = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier = theme.icon_dir .. "/magnifier.png"
theme.layout_floating = theme.icon_dir .. "/floating.png"
theme.layout_centerworkh = theme.icon_dir .. "/centerworkh2.png"
theme.layout_cornernw = theme.icon_dir .. "/cornernw.png"
theme.layout_cascade = theme.icon_dir .. "/cascade2.png"
theme.layout_termfair = theme.icon_dir .. "/termfair2.png"
theme.tasklist_plain_task_name = false
theme.tasklist_disable_icon = true
theme.useless_gap = 4
theme.titlebar_close_button_normal = theme.default_dir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus = theme.default_dir .. "/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal = theme.default_dir .. "/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = theme.default_dir .. "/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive = theme.default_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = theme.default_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.default_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = theme.default_dir .. "/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = theme.default_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = theme.default_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.default_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = theme.default_dir .. "/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = theme.default_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = theme.default_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.default_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = theme.default_dir .. "/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = theme.default_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.default_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = theme.default_dir .. "/titlebar/maximized_focus_active.png"
theme.widget_main_color = "#74aeab"
theme.widget_red = "#e53935"
theme.widget_yellow = "#c0ca33"
theme.widget_green = "#43a047"
theme.widget_black = "#000000"
theme.widget_transparent = "#00000000"
theme.bg_systray = "#303030"
theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)
theme.mixer = string.format("%s -e alsamixer", awful.util.terminal)

local markup = lain.util.markup
local blue = "#80CCE6"
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup("#00FFFF", space3 .. "%I:%M %p "))
mytextclock.font = theme.font
local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(mytextclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, 0, 3, 5, 5)

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%a %b %d %Y"))
local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(mytextcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, 0, 0, 5, 5)
lain.widget.calendar(
    {
        attach_to = {mytextclock, mytextcalendar},
        notification_preset = {
            fg = theme.fg_normal,
            bg = theme.bg_normal,
            position = "top_right",
            font = theme.calendar_font
        }
    }
)

--[[ Mail IMAP check
-- commented because it needs to be set before use
local mail = lain.widget.imap({
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
local mpd_icon = awful.widget.launcher({image = theme.mpdl, command = theme.musicplr})
local prev_icon = wibox.widget.imagebox(theme.prev)
local next_icon = wibox.widget.imagebox(theme.nex)
local stop_icon = wibox.widget.imagebox(theme.stop)
local pause_icon = wibox.widget.imagebox(theme.pause)
local play_pause_icon = wibox.widget.imagebox(theme.play)
mpd =
    lain.widget.mpd(
    {
        default_art = os.getenv("HOME") .. "/Music/cover.png",
        cover_size = 86,
        settings = function()
            if mpd_now.state == "play" then
                mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
                mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
                widget:set_markup(
                    markup.font("Misc Ohsnap 8", " ") ..
                        markup.font(theme.taglist_font, " " .. mpd_now.artist .. " - " .. mpd_now.title .. "  ") ..
                            markup.font("Misc Ohsnap 8", " ")
                )
                play_pause_icon:set_image(theme.pause)
            elseif mpd_now.state == "pause" then
                widget:set_markup(
                    markup.font("Roboto 4", " ") ..
                        markup.font(theme.taglist_font, " MPD PAUSED  ") .. markup.font("Misc Ohsnap 8", " ")
                )
                play_pause_icon:set_image(theme.play)
            -- else
            --     widget:set_markup("")
            --     play_pause_icon:set_image(theme.play)
            end
        end
    }
)
local musicbg = wibox.container.background(mpd.widget, theme.bg_focus, gears.shape.rectangle)
local musicwidget = wibox.container.margin(musicbg, 0, 0, 5, 5)

musicwidget:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                awful.spawn(theme.musicplr)
            end
        )
    )
)
prev_icon:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                awful.spawn.with_shell(" [[ -n $(pgrep mpd) ]] && mpc prev; [[ -n $(pgrep cmus) ]] && cmus-remote -r")
                mpd.update()
            end
        )
    )
)
next_icon:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                awful.spawn.with_shell("[[ -n $(pgrep mpd) ]] && mpc next; [[ -n $(pgrep cmus) ]] && cmus-remote -n")
                mpd.update()
            end
        )
    )
)
stop_icon:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                play_pause_icon:set_image(theme.play)
                awful.spawn.with_shell("[[ -n $(pgrep mpd) ]] && mpc stop; [[ -n $(pgrep cmus) ]] && cmus-remote -s")
                mpd.update()
            end
        )
    )
)
play_pause_icon:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                awful.spawn.with_shell("[[ -n $(pgrep mpd) ]] && mpc toggle; [[ -n $(pgrep cmus) ]] && cmus-remote -p")
                mpd.update()
            end
        )
    )
)

-- Battery
--
local bat =
    lain.widget.bat(
    {
        settings = function()
            bat_header = " BAT "
            bat_p = bat_now.perc .. "% "
            if bat_now.ac_status == 1 then
                bat_p = bat_p .. "Plugged "
            end
            widget:set_markup(markup.font(theme.font, markup("magenta", bat_header) .. bat_p))
        end
    }
)
--]]
local batbg = wibox.container.background(bat.widget, theme.bg_focus, gears.shape.rectangle)
local batwidget = wibox.container.margin(batbg, 0, 0, 5, 5)
--[[
    --  fs
    theme.fs = lain.widget.fs({
        notification_preset = { bg = theme.bg_normal, font = "Monospace 9" },
    })
    --]]
-- / fs
local fsicon = wibox.widget.imagebox(theme.fs, false)
local fs =
    lain.widget.fs(
    {
        -- options = "--exclude-type=tmpfs",
        notification_preset = {font = "Liberation Mono 9", fg = theme.fg_normal},
        timeout = 10,
        settings = function()
            local function math_round(n, d)
                local mul = 10 ^ d
                local half = 0.5
                return math.floor(n * mul + half) / mul
            end
            widget:set_markup(
                markup.fontfg(
                    theme.font,
                    "#80d9d8",
                    "/: " ..
                        math_round(fs_now["/"].free, 2) ..
                            " " ..
                                fs_now["/"].units ..
                                    " | home: " ..
                                        math_round(fs_now["/home"].free, 2) .. " " .. fs_now["/home"].units .. " "
                )
            )
        end
    }
)
local fsbg = wibox.container.background(fs.widget, theme.bg_focus, gears.shape.rectangle)
local fswidget = wibox.container.margin(fsbg, 0, 0, 5, 5)
local fsiconbg = wibox.container.background(fsicon, theme.bg_focus, gears.shape.rectangle)
local fsiconwidget = wibox.container.margin(fsiconbg, 0, 0, 5, 5)

fs_temp = lain.widget.fs_temp({
    font = "Misc Ohsnap 8",
    timeout = 10
})
-- ALSA volume bar
local volicon = wibox.widget.imagebox(theme.vol, false)
theme.volume =
    lain.widget.alsabar(
    {
        notification_preset = {font = theme.font},
        --togglechannel = "IEC958,3",
        width = 64,
        border_width = 0,
        ticks = true,
        ticks_size = 4,
        height = 6,
        colors = {
            background = "#383838",
            unmute = "#80CCE6",
            mute = "#FF9F9F"
        },
        settings = function()
            if volume_now.status == "off" then
                volicon:set_image(theme.vol_mute, false)
            elseif volume_now.level == 0 then
                volicon:set_image(theme.vol_no, false)
            elseif volume_now.level <= 50 then
                volicon:set_image(theme.vol_low, false)
            else
                volicon:set_image(theme.vol, false)
            end
        end
    }
)
theme.volume.bar.paddings = 1
theme.volume.bar.margins = 5
local volumewidget = wibox.container.background(theme.volume.bar, theme.bg_focus, gears.shape.rectangle)
volumewidget = wibox.container.margin(volumewidget, 0, 0, 5, 5)

volumewidget:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                awful.spawn(theme.mixer)
            end
        )
    )
)
volicon:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                awful.spawn(theme.mixer)
            end
        )
    )
)
-- CPU
local cpu_icon = wibox.widget.imagebox(theme.cpu, false)
local cpu =
    lain.widget.cpu(
    {
        settings = function()
            widget:set_markup(
                space3 .. markup.font(theme.font, " CPU " .. cpu_now.usage .. "% ") .. markup.font("Roboto 5", " ")
            )
        end
    }
)
local cpubg = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, 0, 0, 5, 5)

-- MEM
local memicon = wibox.widget.imagebox(theme.mem, false)
local memory =
    lain.widget.mem(
    {
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. " MB "))
        end
    }
)
local membg = wibox.container.background(memory.widget, theme.bg_focus, gears.shape.rectangle)
local memwidget = wibox.container.margin(membg, 0, 0, 5, 5)
local memiconbg = wibox.container.background(memicon, theme.bg_focus, gears.shape.rectangle)
local memiconwidget = wibox.container.margin(memiconbg, 0, 0, 5, 5)
-- Coretemp
local tempicon = wibox.widget.imagebox(theme.temp, false)
local temp =
    lain.widget.temp(
    {
        settings = function()
            widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
        end
    }
)
local tempbg = wibox.container.background(temp.widget, theme.bg_focus, gears.shape.rectangle)
local tempiconbg = wibox.container.background(tempicon, theme.bg_focus, gears.shape.rectangle)
local tempwidget = wibox.container.margin(tempbg, 0, 0, 5, 5)
local tempiconwidget = wibox.container.margin(tempiconbg, 0, 0, 5, 5)
-- Net
local netdown_icon = wibox.widget.imagebox(theme.net_down)
local netup_icon = wibox.widget.imagebox(theme.net_up)
local net =
    lain.widget.net(
    {
        settings = function()
            widget:set_markup(
                markup.font("Roboto 1", " ") ..
                    markup.font(theme.font, net_now.received .. " - " .. net_now.sent) .. markup.font("Roboto 2", " ")
            )
        end
    }
)
local netbg = wibox.container.background(net.widget, theme.bg_focus, gears.shape.rectangle)
local networkwidget = wibox.container.margin(netbg, 0, 0, 5, 5)
local wifi = os.getenv("IFACE")

-- Net from github
net_wireless = net_widgets.wireless({interface = wifi, font = "monospace"})
-- net_wired = net_widgets.indicator({
--     interfaces  = {"ens5f5"},
--     timeout     = 5,
--     font        = "monospace"
-- })
--net_internet = net_widgets.internet({indent = 0, timeout = 5, showconnected = false})
--local netinternetbg = wibox.container.background(net_internet.widget, theme.bg_focus, gears.shape.rectangle)
--local netinternetwidget = wibox.container.margin(netinternetbg, 0, 0, 3, 3)
--[[
        -- Weather
        theme.weather = lain.widget.weather({
            city_id = 2643743, -- placeholder (London)
            notification_preset = { font = "Monospace 9", position = "bottom_right" },
        })
        --]]
--]]

local vpn = lain.widget.vpnstat({
    settings = function()

        local v = " V "
        local icolor = "#FF0000"
        if vpnstatus_now.status == "up" then
            icolor = "#00FF00"
         end

        widget:set_markup(markup.fontfg(theme.font, icolor, v))
    end
    })
local vpnbg = wibox.container.background(vpn.widget, theme.bg_focus, gears.shape.rectangle)
local vpnwidget = wibox.container.margin(vpnbg, 0, 0, 5, 5)


-- Launcher
local mylauncher = awful.widget.button({image = theme.awesome_icon_launcher})
mylauncher:connect_signal(
    "button::press",
    function()
        awful.util.mymainmenu:toggle()
    end
)

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
local spr_left = wibox.widget.imagebox(theme.spr_left)
local bar = wibox.widget.imagebox(theme.bar)
local bottom_bar = wibox.widget.imagebox(theme.bottom_bar)

local barcolor =
    gears.color(
    {
        type = "linear",
        from = {32, 0},
        to = {32, 32},
        stops = {{0, theme.bg_focus}, {0.25, "#505050"}, {1, theme.bg_focus}}
    }
)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake =
        lain.util.quake(
        {
            app = awful.util.terminal,
            extra = "-fn -misc-tamzenforpowerline-medium-r-normal--12-87-100-100-c-60-iso8859-1 -e zsh -c 'exec ~/.config/scripts/awesome_quake_tmux'",
            height = 0.3
        }
    )

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
    s.mylayoutbox:buttons(
        my_table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    -- Create a taglist widget
    s.mytaglist =
        awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, {bg_focus = barcolor})

    mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_focus, gears.shape.rectangle)
    s.mytag = wibox.container.margin(mytaglistcont, 0, 0, 5, 5)

    -- Create a tasklist widget
    s.mytasklist =
        awful.widget.tasklist(
        s,
        awful.widget.tasklist.filter.currenttags,
        awful.util.tasklist_buttons,
        {
            bg_focus = theme.bg_focus,
            shape = gears.shape.rectangle,
            shape_border_width = 5,
            shape_border_color = theme.tasklist_bg_normal,
            align = "center"
        }
    )

    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s, height = 32})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            spr_right,
            s.mylayoutbox,
            spr_small,
            s.mytag,
            spr_small,
            s.mypromptbox
        },
        nil, -- Middle widget
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --mail.widget,
            -- spr_right,
            bar,
            cpuwidget,
            bar,
            tempiconwidget,
            tempwidget,
            bar,
            memiconwidget,
            memwidget,
            bar,
            fsiconwidget,
            fswidget,
            -- ssdtemp_widget,
            fs_temp,
            bar,
            net_wireless,
            netdown_icon,
            networkwidget,
            netup_icon,
            vpnwidget,
            bar,
            -- spr_left,
            wibox.container.margin(wibox.widget.systray(), 0, 0, 5, 5),
            bar,
            -- wibox.widget.systray(),
            -- bat.widget,
            --bar,
            batwidget,
            bar,
            calendar_icon,
            calendarwidget,
            bottom_bar,
            clock_icon,
            clockwidget
        }
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({position = "bottom", screen = s, border_width = 0, height = 32})
    -- s.borderwibox = awful.wibar({position = "bottom", screen = s, height = 1, bg = theme.fg_focus, x = 0, y = 33})
    s.borderwibox = awful.wibar({position = "bottom", screen = s, height = 1, x = 0, y = 33})

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal
            --mylauncher,
        },
        s.mytasklist, -- Middle widget
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- spr_small,
            bar,
            mpd_icon,
            bar,
            musicwidget,
            bar,
            prev_icon,
            next_icon,
            stop_icon,
            play_pause_icon,
            bar,
            spr_very_small,
            volicon,
            volumewidget,
            spr_left
        }
    }
end
return theme
