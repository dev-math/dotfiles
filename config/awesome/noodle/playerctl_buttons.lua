-- Text buttons for playerctl control using "Font Awesome 5 Free" font
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")

local playerctl_prev_symbol = wibox.widget.textbox()
playerctl_prev_symbol.markup = helpers.colorize_text("", x.foreground)
playerctl_prev_symbol.font = "Font Awesome 5 Free 18"
playerctl_prev_symbol.align = "center"
playerctl_prev_symbol.valign = "center"

local playerctl_center_symbol = wibox.widget.textbox()
playerctl_center_symbol.markup = helpers.colorize_text("", x.color3)
playerctl_center_symbol.font = "Font Awesome 5 Free 18"
playerctl_center_symbol.align = "center"
playerctl_center_symbol.valign = "center"

local playerctl_next_symbol = wibox.widget.textbox()
playerctl_next_symbol.markup = helpers.colorize_text("", x.foreground)
playerctl_next_symbol.font = "Font Awesome 5 Free 18"
playerctl_next_symbol.align = "center"
playerctl_next_symbol.valign = "center"

local playerctl_center_icon = wibox.widget {
    playerctl_center_symbol,
    -- shape = gears.shape.circle,
    widget = wibox.container.background
}
playerctl_center_icon:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("playerctl --player=%any,chromium play-pause")
    end)
))

local playerctl_prev_icon = wibox.widget {
    playerctl_prev_symbol,
    widget = wibox.container.background
}

playerctl_prev_icon:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("playerctl --player=%any,chromium previous")
    end)
))

local playerctl_next_icon = wibox.widget {
    playerctl_next_symbol,
    widget = wibox.container.background
}
playerctl_next_icon:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("playerctl --player=%any,chromium next")
    end)
))

local playerctl_buttons = wibox.widget {
    nil,
    {
        playerctl_prev_icon,
        playerctl_center_icon,
        playerctl_next_icon,
        spacing = dpi(14),
        layout  = wibox.layout.fixed.horizontal
    },
    expand = "none",
    layout = wibox.layout.align.horizontal,
}

-- Add clickable mouse effects on some widgets
helpers.add_hover_cursor(playerctl_next_icon, "hand2")
helpers.add_hover_cursor(playerctl_prev_icon, "hand2")
helpers.add_hover_cursor(playerctl_center_icon, "hand2")

return playerctl_buttons
