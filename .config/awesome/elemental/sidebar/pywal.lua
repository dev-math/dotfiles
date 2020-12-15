local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local apps = require("apps")
local naughty = require("naughty")

local keys = require("keys")
local helpers = require("helpers")

-- Helper function that changes the appearance of progress bars and their icons
-- Create horizontal rounded bars
local function format_progress_bar(bar, icon, symbol)
    icon.font = "Font Awesome 5 Free 20"
    icon.markup = "<span foreground='" .. x.color3 .."'> " .. symbol .. "</span>"    
    bar.forced_width = dpi(215)
    bar.forced_height = dpi(40)
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rounded_bar

    -- bar.paddings = dpi(4)
    -- bar.border_width = dpi(2)
    -- bar.border_color = x.color8

    local w = wibox.widget{
        nil,
        {
            icon,
            bar,
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

local time = wibox.widget.textclock("<span foreground='" .. x.color3 .. "'>%H:%M</span>")
time.align = "center"
time.valign = "center"
time.font = "SF UI Display 55"

-- local date = wibox.widget.textclock("%B %d")
-- local date = wibox.widget.textclock("%A, %B %d")
local date = wibox.widget.textclock("<span foreground='" .. x.color3 .. "'></span> %A, %B %d, %Y")
date.align = "center"
date.valign = "center"
date.font = "SF UI Display medium 16"

-- Weather widget with text icons
local weather_widget = require("noodle.text_weather")
local weather_widget_icon = weather_widget:get_all_children()[1]
weather_widget_icon.font = "Font Awesome 5 Free 16"
weather_widget_icon.align = "center"
weather_widget_icon.valign = "center"
-- So that content does not get cropped
-- weather_widget_icon.forced_width = dpi(50)
local weather_widget_description = weather_widget:get_all_children()[2]
weather_widget_description.font = "SF UI Display medium 14"
local weather_widget_temperature = weather_widget:get_all_children()[3]
weather_widget_temperature.font = "SF UI Display medium 14"

local weather = wibox.widget{
    {
        nil,
        weather_widget_description,
        expand = "none",
        layout = wibox.layout.align.horizontal
    },
    {
        nil,
        {
            weather_widget_icon,
            weather_widget_temperature,
            spacing = dpi(5),
            layout = wibox.layout.fixed.horizontal
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    },
    spacing = dpi(5),
    layout = wibox.layout.fixed.vertical
    -- nil,
    -- weather_widget,
    -- layout = wibox.layout.align.horizontal,
    -- expand = "none"
}

-- Media playing
local playerctl_buttons = require("noodle.playerctl_buttons")
local playerctl_song = require("noodle.playerctl_song")
local playerctl_widget_children = playerctl_song:get_all_children()
local playerctl_title = playerctl_widget_children[1]
local playerctl_artist = playerctl_widget_children[2]
playerctl_title.font = "SF UI Display medium 15"
playerctl_artist.font = "SF UI Display medium 13"

-- Set forced height in order to limit the widgets to one line.
-- Might need to be adjusted depending on the font.
-- playerctl_title.forced_height = dpi(26)
-- playerctl_artist.forced_height = dpi(20)

playerctl_song:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("playerctl play-pause")
    end)
))

local volume_icon = wibox.widget.textbox()
local volume_bar = require("noodle.volume_bar")
local volume = format_progress_bar(volume_bar, volume_icon, "")

volume:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function ()
        helpers.volume_control(0)
    end),
    -- Right click - Run or raise pavucontrol
    awful.button({ }, 3, apps.volume),
    -- Scroll - Increase / Decrease volume
    awful.button({ }, 4, function ()
        helpers.volume_control(2)
    end),
    awful.button({ }, 5, function ()
        helpers.volume_control(-2)
    end)
))

local cpu_icon = wibox.widget.textbox()
local cpu_bar = require("noodle.cpu_bar")
local cpu = format_progress_bar(cpu_bar, cpu_icon, "")

cpu:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.system_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))

local ram_icon = wibox.widget.textbox()
local ram_bar = require("noodle.ram_bar")
local ram = format_progress_bar(ram_bar, ram_icon, "")

ram:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.system_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))

local temperature_icon = wibox.widget.textbox()
local temperature_bar = require("noodle.temperature_bar")
local temperature = format_progress_bar(temperature_bar, temperature_icon, "")

temperature:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.temperature_monitor)
))

local exit = wibox.widget.textbox()
exit.markup = "<span foreground='" .. x.color3 .."'>  </span> Exit" 
exit.font = "sans 14"

exit:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("~/.dotfiles/.scripts/powermenu.sh")
        -- sidebar_hide()
    end)
))

local disk_icon = wibox.widget.textbox()
disk_icon.markup = "<span foreground='" .. x.color3 .."'>  </span>" 
disk_icon.font = "sans 14"
local disk_space = require("noodle.disk")
disk_space.font = "sans 14"

local disk = wibox.widget{
    nil,
    {
        disk_icon,
        disk_space,
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

disk:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn(user.file_manager, {floating = true})
    end),
    awful.button({ }, 3, function ()
       -- awful.spawn(user.file_manager .. " /data", {floating = true})
    end)
))


awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    s.sidebar = wibox({screen = s, visible = false, ontop = true, type = "dock"})
    s.sidebar.bg = beautiful.sidebar_bg or beautiful.wibar_bg or "#111111"
    s.sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
    s.sidebar.height = s.geometry.height
    s.sidebar.width = beautiful.sidebar_width or dpi(300)
    s.sidebar.y = beautiful.sidebar_y or 0

    local radius = beautiful.sidebar_border_radius or 0
    if beautiful.sidebar_position == "right" then
        awful.placement.right(s.sidebar)
        s.sidebar.shape = helpers.prrect(radius, true, false, false, true)
    else
        awful.placement.left(s.sidebar)
        s.sidebar.shape = helpers.prrect(radius, false, true, true, false)
    end

    sidebar_show = function()
        s.sidebar.visible = true
    end

    sidebar_hide = function()
        s.sidebar.visible = false
    end

    sidebar_toggle = function()
        s.sidebar.visible = not sidebar.visible
    end

    s.sidebar:buttons(gears.table.join(
        -- Middle click - Hide sidebar
        awful.button({ }, 2, function ()
            s.sidebar.visible = false
        end)
    ))

    -- Hide sidebar when mouse leaves
    if user.sidebar.hide_on_mouse_leave then
        s.sidebar:connect_signal("mouse::leave", function ()
            s.sidebar.visible = false
        end)
    end

    -- Activate sidebar by moving the mouse at the edge of the screen
    if user.sidebar.show_on_mouse_screen_edge then
        local sidebar_activator = wibox({y = s.sidebar.y, width = 1, visible = true, ontop = false, opacity = 0, below = true, screen = s})
        sidebar_activator.height = s.sidebar.height
        sidebar_activator:connect_signal("mouse::enter", function ()
            s.sidebar.visible = true
        end)

        if beautiful.sidebar_position == "right" then
            awful.placement.right(sidebar_activator)
        else
            awful.placement.left(sidebar_activator)
        end

        sidebar_activator:buttons(
            gears.table.join(
                awful.button({ }, 4, function ()
                    awful.tag.viewprev()
                end),
                awful.button({ }, 5, function ()
                    awful.tag.viewnext()
               end)
        ))
    end

    -- Item placement
    s.sidebar:setup {
        { ----------- TOP GROUP -----------
            helpers.vertical_pad(40),
            time,
            date,
            helpers.vertical_pad(20),
            weather,
            helpers.vertical_pad(40),
            layout = wibox.layout.fixed.vertical
        },
        { ----------- MIDDLE GROUP -----------
            helpers.vertical_pad(200),
            --playerctl_buttons,
            {
                -- Put some margins at the left and right edge so that
                -- it looks better with extremely long titles/artists
                --playerctl_song,
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            --helpers.vertical_pad(200),
            --volume,
            --cpu,
            --ram,
            --temperature,
            helpers.vertical_pad(450),
            disk,
            --helpers.vertical_pad(40),
            layout = wibox.layout.fixed.vertical
        },
        { ----------- BOTTOM GROUP -----------
            nil,
            {   
                {
                    exit,
                    spacing = dpi(50),
                    layout = wibox.layout.fixed.horizontal
                },
                left = dpi(20),
                right = dpi(20),
                bottom = dpi(20),
                widget = wibox.container.margin
            },
            nil,
            layout = wibox.layout.align.horizontal,
            expand = "none"
        },
        layout = wibox.layout.align.vertical,
        -- expand = "none"
    }
end)

helpers.add_hover_cursor(cpu, "hand2")
helpers.add_hover_cursor(disk, "hand2")
helpers.add_hover_cursor(exit, "hand2")
helpers.add_hover_cursor(playerctl_song, "hand2")
helpers.add_hover_cursor(ram, "hand2")
helpers.add_hover_cursor(temperature, "hand2")
