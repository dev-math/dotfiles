local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
local title_color =  beautiful.playerctl_song_title_color or beautiful.wibar_fg
local artist_color = beautiful.playerctl_song_artist_color or beautiful.wibar_fg
local paused_color = beautiful.playerctl_song_paused_color or beautiful.normal_fg

local playerctl_title = wibox.widget{
    text = "---------",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local playerctl_artist = wibox.widget{
    text = "---------",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

-- Main widget
local playerctl_song = wibox.widget{
    playerctl_title,
    playerctl_artist,
    layout = wibox.layout.fixed.vertical
}

local artist_fg
local title_fg

awesome.connect_signal("evil::playerctl", function(artist, title, status)
    if status == "paused" then
        artist_fg = paused_color
        title_fg = paused_color
    else
        artist_fg = artist_color
        title_fg = title_color
    end

    if status == "" then
    else
        playerctl_artist.markup =
            "<span foreground='" .. artist_fg .."'>"
            .. artist .. "</span>"

        playerctl_title.markup =
            "<span foreground='" .. title_fg .."'>"
            .. title .. "</span>"
    end
end)

return playerctl_song
