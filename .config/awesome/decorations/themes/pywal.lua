local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local keys = require("keys")
local decorations = require("decorations")

-- This decoration theme will round clients according to your theme's
-- border_radius value
-- Disable this if using `picom` to round your corners
-- decorations.enable_rounding()

-- Button configuration
local gen_button_size = dpi(16)
local gen_button_margin = dpi(8)
local gen_button_color_unfocused = x.color8
local gen_button_shape = gears.shape.circle

-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
    awful.titlebar(c, {font = beautiful.titlebar_font, position = beautiful.titlebar_position, size = beautiful.titlebar_size}) : setup {
        {
            -- AwesomeWM native buttons (images loaded from theme)
            -- awful.titlebar.widget.minimizebutton(c),
            -- awful.titlebar.widget.maximizedbutton(c),
            -- awful.titlebar.widget.closebutton(c),

            -- Generated buttons
            decorations.button(c, gen_button_shape, "#fe6254", "#fe6254", "#fe6254C0", gen_button_size, gen_button_margin, "close"),
            decorations.button(c, gen_button_shape, "#f1ae1b", "#f1ae1b", "#f1ae1bC0", gen_button_size, gen_button_margin, "minimize"),
            decorations.button(c, gen_button_shape, "#59c837", "#59c837", "#59c837C0", gen_button_size, gen_button_margin, "maximize"),
            --decorations.text_button(c, "", "Material Icons 9", x.color1, gen_button_color_unfocused, x.color9, gen_button_size, gen_button_margin, "close"),

            -- Create some extra padding at the edge
            helpers.horizontal_pad(gen_button_margin / 2),
            layout = wibox.layout.fixed.horizontal
        },
        {
            {
                -- Generated text title
                align = beautiful.titlebar_title_align or "center",
                decorations.text_title(c, beautiful.titlebar_font, x.foreground, "1"),
                layout = wibox.layout.flex.horizontal,
            },
            buttons = get_titlebar_mouse_bindings(c),
            layout = wibox.layout.flex.horizontal,
        },
        --nill,
        layout = wibox.layout.align.horizontal,
    }
end)
