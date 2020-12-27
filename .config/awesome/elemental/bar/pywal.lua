local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local apps = require("apps")
local naughty = require("naughty")

local keys = require("keys")
local helpers = require("helpers")

-- Helper function that creates a button widget
local create_button = function (symbol, color, bg_color, hover_color)
    local widget = wibox.widget {
        font = "SF UI Display 14",
        align = "center",
        id = "text_role",
        valign = "center",
        markup = helpers.colorize_text(symbol, color),
        widget = wibox.widget.textbox()
    }

    local section = wibox.widget {
        widget,
        forced_width = dpi(40),
        bg = bg_color,
        widget = wibox.container.background
    }

    -- Hover animation
    section:connect_signal("mouse::enter", function ()
        section.bg = hover_color
    end)
    section:connect_signal("mouse::leave", function ()
        section.bg = bg_color
    end)

    -- helpers.add_hover_cursor(section, "hand1")

    return section
end

local exit = create_button("", x.color0, x.color4,x.color4.."E0")
exit:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("~/.dotfiles/.scripts/powermenu.sh")
    end)
))

local volume_symbol = ""
local volume_muted_symbol = ""
local volume_muted_color = x.color0
local volume_unmuted_color = x.color0
local volume = create_button(volume_symbol, volume_unmuted_color, x.color4, x.color4.."E0")
volume.forced_width = dpi(110)

volume:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function ()
        helpers.volume_control(0)
    end),
    -- Right click - Run or raise volume control client
    awful.button({ }, 3, apps.volume),
    -- Scroll - Increase / Decrease volume
    awful.button({ }, 4, function ()
        helpers.volume_control(5)
    end),
    awful.button({ }, 5, function ()
        helpers.volume_control(-5)
    end)
))

awesome.connect_signal("evil::volume", function(volume_int, muted)
    local t = volume:get_all_children()[1]

    if muted then
        t.markup = helpers.colorize_text(volume_muted_symbol, volume_muted_color)
    else
        if ( volume_int == 0 ) then
            volume_symbol = ""
        elseif ( volume_int > 0 and volume_int <= 33 ) then
            volume_symbol = ""
        elseif ( volume_int > 33 ) then
            volume_symbol = ""
        end
        t.markup = helpers.colorize_text(volume_symbol.. " " ..volume_int.. "%", volume_unmuted_color)
    end
end)

local microphone_symbol = ""
local microphone_muted_symbol = ""
local microphone_muted_color = x.color0
local microphone_unmuted_color = x.color0
local microphone = create_button(microphone_symbol, microphone_unmuted_color, x.color4, x.color4.."E0")

microphone:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("amixer -D pulse sset Capture toggle &> /dev/null")
    end)
))

awesome.connect_signal("evil::microphone", function(muted)
    local t = microphone:get_all_children()[1]
    if muted then
        t.markup = helpers.colorize_text(microphone_muted_symbol, microphone_muted_color)
    else
        t.markup = helpers.colorize_text(microphone_symbol, microphone_unmuted_color)
    end
end)

beautiful.bg_systray = x.color0
beautiful.systray_icon_spacing = 10

local systray = wibox.widget {
    {
        font = "SF UI Display 14",
        align = "center",
        id = "text_role",
        valign = "center",
        widget = wibox.widget.systray()
    },
    widget,
    bg = x.color0,
    widget = wibox.container.background
}

local systrayc = systray:get_all_children()[1]
systrayc:set_base_size(25)
systrayc:set_reverse (true)

local music = wibox.widget {
    {
        font = "SF UI Display medium 14",
        align = "center",
        id = "text_role",
        valign = "center",
        widget = wibox.widget.textbox("...")
    },
    widget,
    forced_width = 0,
    bg = x.color4,
    widget = wibox.container.background
}

-- Hover animation
music:connect_signal("mouse::enter", function ()
    music.bg = x.color4.."E0"
end)
music:connect_signal("mouse::leave", function ()
    music.bg = x.color4
end)

music:buttons(gears.table.join(
    -- Left click
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("playerctl play-pause")
    end)
))

local musicprev = create_button("", x.color0, x.color4, x.color4.."E0")

musicprev:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("playerctl previous")
    end)
))

local musicnext = create_button("", x.color0, x.color4, x.color4.."E0")

musicnext:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("playerctl next")
    end)
))

musicprev.forced_width = 0
musicnext.forced_width = 0

awesome.connect_signal("evil::playerctl", function(artist, title, status)
    local musict = music:get_all_children()[1]
    musicprev.forced_width = dpi(70)
    musicnext.forced_width = dpi(70)
    music.forced_width = dpi(400)

    if status == "paused" then
        musict.markup = title.. " - " .. artist .. " (paused)"
    elseif (status == "playing") then
        musict.markup = title.. " - " .. artist
    else
        music.forced_width = 0
        musicprev.forced_width = 0
        musicnext.forced_width = 0
    end
end)

local clock = wibox.widget {
    {
        font = "SF UI Display 14",
        align = "center",
        id = "text_role",
        valign = "center",
        widget = wibox.widget.textclock("   %H:%M ")
    },
    widget,
    -- forced_width = dpi(110),
    bg = x.color4,
    widget = wibox.container.background
}

-- Hover animation                             
clock:connect_signal("mouse::enter", function ()   
    clock.bg = x.color4.."E0"              
end)
clock:connect_signal("mouse::leave", function ()
    clock.bg = x.color4
end)

clock:buttons(gears.table.join(
    -- Left click - Open calendar
    awful.button({ }, 1, function ()
        if dashboard_show then
            dashboard_show()
        end
    end)
))

local clock2 = wibox.widget {
    {
        font = "SF UI Display medium 14",
	align = "center",
	id = "text_role",
	valign = "center",
	widget = wibox.widget.textclock(" %a, %H:%M ")
    },
    widget,
    bg = x.background,
    fg = x.foreground,
    widget = wibox.container.background
}


-- Hover animation
clock2:connect_signal("mouse::enter", function ()
    clock2.bg = x.color3.."21"
end)
clock2:connect_signal("mouse::leave", function ()
    clock2.bg = x.background
end)

clock2:buttons(gears.table.join(
    -- Left click - Open calendar
    awful.button({ }, 1, function ()
        if dashboard_show then
            dashboard_show()
        end
    end)
))

local battery1 = wibox.widget {
    {
        font = "SF UI Display 14",
        align = "center",
        id = "text_role",
        valign = "center",
        widget = wibox.widget.textbox
    },
    widget,
    -- forced_width = dpi(110),
    bg = x.color4,
    widget = wibox.container.background
}

local battery2 = wibox.widget {
    {
        font = "SF UI Display 14",
        align = "center",
        id = "text_role",
        valign = "center",
        widget = wibox.widget.textbox
    },
    widget,
    -- forced_width = dpi(110),
    bg = x.color4,
    widget = wibox.container.background
}

local battery1_icon = ""
local battery1_status = ""
local battery1_capacity = ""

local battery2_icon = ""
local battery2_status = ""
local battery2_capacity = ""

function setbattery_icon(battery_capacity)
    if ( battery_capacity <= 5 ) then
        battery_icon = ""
    elseif ( battery_capacity > 5 and battery_capacity <= 25 ) then
        battery_icon = ""
    elseif ( battery_capacity > 25 and battery_capacity <= 50 ) then
        battery_icon = ""
    elseif ( battery_capacity > 50 and battery_capacity <= 75 ) then
        battery_icon = ""
    else
        battery_icon = ""
    end

    return battery_icon
end

awesome.connect_signal("evil::battery", function(value)
    local t = battery1:get_all_children()[1]
    battery1_capacity = value

    if (battery1_capacity == 99) then
        battery1_capacity = 100
    end
   
    if (battery1_status == false) then
       battery1_icon = setbattery_icon(battery1_capacity)
    end

    t.markup = "<span foreground='" .. x.color0 .."'> " .. battery1_icon .. " " .. battery1_capacity .. "%</span>"

end)

awesome.connect_signal("evil::battery2", function(value)
    local t = battery2:get_all_children()[1]
    battery2_capacity = value

    if (battery2_capacity == 99) then
        battery2_capacity = 100
    end
   
    if (battery2_status == false) then
       battery2_icon = setbattery_icon(battery2_capacity)
    end

    t.markup = "<span foreground='" .. x.color0 .."'>  " .. battery2_icon .. " " .. battery2_capacity .. "% </span>"

end)

awesome.connect_signal("evil::charger", function(value)
    local t1 = battery1:get_all_children()[1]
    local t2 = battery2:get_all_children()[1]
    battery1_status = value
    battery2_status = value

    if (battery1_status == true and battery2_status == true) then
        battery1_icon = ""
        battery2_icon = ""
    else
        battery1_icon = setbattery_icon(battery1_capacity)
        battery2_icon = setbattery_icon(battery2_capacity)
    end
        t1.markup = "<span foreground='" .. x.color0 .."'> " .. battery1_icon .. " " .. battery1_capacity .. "%</span>"
        t2.markup = "<span foreground='" .. x.color0 .."'>  " .. battery2_icon .. " " .. battery2_capacity .. "% </span>"
end)


local sandwich = create_button("", x.color3, x.color8.."30", x.color8.."50")
local sandwichc = sandwich:get_all_children()[1]
sandwichc.font = "SF UI Display 18"

sandwich:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        app_drawer_show()
    end)
))

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.markup = helpers.colorize_text("  " ..beautiful.taglist_text_focused[index], beautiful.taglist_text_color_focused)
    elseif tag.urgent then
        item.markup = helpers.colorize_text("  " ..beautiful.taglist_text_urgent[index], beautiful.taglist_text_color_urgent)
    elseif #tag:clients() > 0 then
        item.markup = helpers.colorize_text("  " ..beautiful.taglist_text_occupied[index], beautiful.taglist_text_color_occupied)
    else
        --item.markup = helpers.colorize_text(beautiful.taglist_text_empty[index], beautiful.taglist_text_color_empty)
        item.markup = ""
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Create a taglist for every screen
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout = wibox.layout.fixed.horizontal,
        widget_template = {
            widget = wibox.widget.textbox,
            create_callback = function(self, tag, index, _)
                self.align = "center"
                self.valign = "center"
                -- self.forced_width = dpi(35)
                self.font = beautiful.taglist_text_font

                update_taglist(self, tag, index)
            end,
            update_callback = function(self, tag, index, _)
                update_taglist(self, tag, index)
            end,
        },
        buttons = keys.taglist_buttons,
    }

    -- Create a tasklist for every screen
    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = keys.tasklist_buttons,
        style    = {
            font = beautiful.tasklist_font,
        },
        layout   = {
            -- spacing = dpi(10),
            -- layout  = wibox.layout.fixed.horizontal
            layout  = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'text_role',
                    align  = "center",
                    widget = wibox.widget.textbox,
                },
                --forced_width = dpi(220),
                left = dpi(15),
                right = dpi(15),
                -- Add margins to top and bottom in order to force the
                -- text to be on a single line, if needed. Might need
                -- to adjust them according to font size.
                top  = dpi(4),
                bottom = dpi(4),
                widget = wibox.container.margin
            },
            --shape = helpers.rrect(dpi(8)),
            --border_width = dpi(2),
            --id = "bg_role",
            id = "background_role",
            -- shape = gears.shape.rounded_bar,
            widget = wibox.container.background,
        },
    }

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox.resize = true
    s.mylayoutbox.forced_width  = beautiful.wibar_height - dpi(15)
    s.mylayoutbox.forced_height = beautiful.wibar_height - dpi(15)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () helpers.toggle_float_tile(c) end),
        awful.button({ }, 2, function () awful.layout.set(awful.layout.suit.floating) end)
    ))

    --s.mylayoutbox.tooltip:remove_from_object(s.mylayoutbox)
    s.mylayoutbox.enable_tooltip = false
    
    -- Create the wibox
    s.mywibox = awful.wibar({screen = s, visible = true, ontop = true, type = "dock", position = "top"})
    s.mywibox.height = beautiful.wibar_height
    -- s.mywibox.width = beautiful.wibar_width

    -- For antialiasing
    -- The actual background color is defined in the wibar items
    -- s.mywibox.bg = "#00000000"

    -- s.mywibox.bg = x.color8
    -- s.mywibox.bg = x.foreground
    -- s.mywibox.bg = x.background.."88"
    -- s.mywibox.bg = x.background
    s.mywibox.bg = x.background

    -- Bar placement
    awful.placement.maximize_horizontally(s.mywibox)

    -- Wibar items
    -- Add or remove widgets here
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --sandwich,
            --s.mytaglist,
	    s.mytaglist,
	    s.mytasklist,
            --musicprev,
            --music,
            --musicnext,
        },
        clock2, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.place(systray),
            wibox.widget.textbox("   "),
            volume,
            -- microphone,
            battery1,
            battery2,
	    --clock,
            exit,
	    wibox.container.background(wibox.container.place(s.mylayoutbox), x.color4),
	    wibox.container.background(wibox.widget.textbox(" "), x.color4)
        },
    }

end)

-- We have set the wibar(s) to be ontop, but we do not want it to be above fullscreen clients
local function no_wibar_ontop(c)
    local s = awful.screen.focused()
    if c.fullscreen then
        s.mywibox.ontop = false
    else
        s.mywibox.ontop = true
    end
end

client.connect_signal("focus", no_wibar_ontop)
client.connect_signal("unfocus", no_wibar_ontop)
client.connect_signal("property::fullscreen", no_wibar_ontop)

-- Every bar theme should provide these fuctions
function wibars_toggle()
    local s = awful.screen.focused()
    s.mywibox.visible = not s.mywibox.visible
    s.mytopwibox.visible = not s.mytopwibox.visible
end

function tray_toggle()
    local s = awful.screen.focused()
    s.traybox.visible = not s.traybox.visible
end
