--[[

     Dremora Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local os = { getenv = os.getenv }
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/dremora"
--theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.wallpaper                                 = os.getenv("HOME") .. "/Downloads/images/79182.jpg"
theme.font                                      = "Misc Tamsyn 10.5"
theme.taglist_font                              = "Icons 10"
theme.fg_normal                                 = "#747474"
theme.fg_focus                                  = "#DDDCFF"
theme.bg_normal                                 = "#121212"
theme.bg_focus                                  = "#121212"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"
theme.border_width                              = 1
theme.border_normal                             = "#121212"
--theme.border_focus                              = "#292929"
theme.border_focus                              = "#0099cc"
theme.titlebar_bg_focus                         = "#292929"
theme.taglist_fg_focus                          = "#dddcff"
theme.taglist_bg_focus                          = "#121212"
theme.menu_height                               = 16
theme.menu_width                                = 130
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = false
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 10
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

awful.util.tagnames   = { "ƀ", "Ƅ", "Ɗ", "ƈ", "ƙ" }

local markup     = lain.util.markup
local separators = lain.util.separators
local white      = theme.fg_focus
local gray       = "#858585"

---============================================================
-- rounds a number to the nearest decimal places
--
function round(val, decimal)
  if (decimal) then
    return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
  else
    return math.floor(val+0.5)
  end
end

-- CPU
theme.cpu = lain.widget.cpu({
    timeout = 1,
    settings = function()
        cpu_header = "CPU "
        cpu_p      = cpu_now.usage .. "% "
        widget:set_markup(markup.font(theme.font, markup(gray, cpu_header) .. markup(white, cpu_p)))
    end
})

-- Core Temp
theme.temp = lain.widget.temp({
    timeout = 3,
    settings = function()
        temp_header = "Temp "
        temp_p      = coretemp_now .. "C "
        widget:set_markup(markup.font(theme.font, markup(gray, temp_header) .. markup(white, temp_p)))
    end
})

-- RAM
theme.mem = lain.widget.mem({
    timeout = 5,
    settings = function()
        mem_header = "RAM "
        mem_p      = round((mem_now.used / 1024), 2) .. "GB "
        widget:set_markup(markup.font(theme.font, markup(gray, mem_header) .. markup(white, mem_p)))
    end
})

-- Textclock
local mytextclock = wibox.widget.textclock(markup(gray, " %a")
.. markup(white, " %d ") .. markup(gray, "%b ") ..  markup(white, "%I:%M %p"))
mytextclock.font = theme.font

-- Calendar
lain.widget.calendar({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Misc Tamsyn 11",
        fg   = white,
        bg   = theme.bg_normal
}})

--[[ Mail IMAP check
-- commented because it needs to be set before use
local mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    notification_preset = { fg = white }
    settings = function()
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(gray, mail) .. markup(white, count)))
    end
})
--]]

-- MPD
-- theme.mpd = lain.widget.mpd({
--     settings = function()
--         mpd_notification_preset.fg = white
--         artist = mpd_now.artist .. " "
--         title  = mpd_now.title  .. " "

--         if mpd_now.state == "pause" then
--             artist = "mpd "
--             title  = "paused "
--         elseif mpd_now.state == "stop" then
--             artist = ""
--             title  = ""
--         end

--         widget:set_markup(markup.font(theme.font, markup(gray, artist) .. markup(white, title)))
--     end
-- })

-- fs
theme.fs = lain.widget.fs({
    notification_preset = { fg = white, bg = theme.bg_normal, font = "Misc Tamsyn 10.5" },
    settings  = function()
        fs_header = "/ "
        fs_root      = round(fs_now["/"].free, 2) .. fs_now["/"].units
        fs_header_home = " H "
        fs_home      = round(fs_now["/home"].free, 2) .. fs_now["/home"].units

        widget:set_markup(markup.font(theme.font, markup(gray, fs_header) .. markup(white, fs_root) .. markup(gray, fs_header_home) .. markup(white, fs_home)))
    end
})

-- fs temp
theme.fs_temp = lain.widget.fstemp({
    timeout = 30,
    settings = function()
        fstemp_header = " "
        fstemp_p      = fstemp_now
        widget:set_markup(markup.font(theme.font, markup(gray, fstemp_header) .. markup(white, fstemp_p)))
    end
})

-- Net
theme.net = lain.widget.net({
    iface = "wls1",
    --wifi_state = "on",
    settings = function()
        net_header = " Net "
        net_p      = net_now.devices["wls1"].received .. "/" .. net_now.devices["wls1"].sent .. "kb " .. net_now.devices["wls1"].state
        widget:set_markup(markup.font(theme.font, markup(gray, net_header) .. markup(white, net_p)))
    end
})

-- Battery
local bat = lain.widget.bat({
    settings = function()
        bat_p = bat_now.perc .. "% "
        if bat_now.ac_status == 1 then
            bat_p = bat_p .. "AC"
        elseif bat_now.status ~= "Unknown" then
            bat_p = bat_p .. bat_now.status .. bat_now.time
        end
        bat_header = " Bat "
        widget:set_markup(markup.font(theme.font, markup(gray, bat_header) .. markup(white, bat_p)))
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    --togglechannel = "IEC958,3",
    settings = function()
        header = " Vol "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M"
        else
            vlevel = vlevel
        end

        widget:set_markup(markup.font(theme.font, markup(gray, header) .. markup(white, vlevel)))
    end
})

-- Weather
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { fg = white }
})

-- Separators
local first     = wibox.widget.textbox('<span font="Misc Tamsyn 4"> </span>')
local arrl_pre  = separators.arrow_right("alpha", "#1A1A1A")
local arrl_post = separators.arrow_right("#1A1A1A", "alpha")

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ 
        app = awful.util.terminal,
        extra = "-fn -misc-tamzenforpowerline-medium-r-normal--12-87-100-100-c-60-iso8859-1 -e zsh -c 'exec ~/.config/scripts/awesome_quake_tmux'",
        height = 0.3
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
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mytaglist,
            arrl_pre,
            s.mylayoutbox,
            arrl_post,
            s.mypromptbox,
            first,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            first,
            theme.cpu.widget,
            theme.temp.widget,
            theme.mem.widget,
            --theme.mpd.widget,
            --mail.widget,
            theme.fs.widget,
            theme.fs_temp.widget,
            theme.net.widget,
            bat.widget,
            theme.volume.widget,
            mytextclock,
        },
    }
end

return theme
