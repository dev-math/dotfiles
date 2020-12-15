-- Provides:
-- evil::playerctl
--      artist (string)
--      song (string)
--      status (string) [playing | paused | stopped]
local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

local lgi = require("lgi")
local Playerctl = lgi.Playerctl
local player = Playerctl.Player{}

player.on_metadata = update_metadata
player.on_playback_status = update_metadata
player.on_play = update_metadata
player.on_pause = update_metadata

local update_metadata = function()
    local artist = player:get_artist()
    local title = player:get_title()
    local status = player.status

    naughty.notify({ title = title, text = "Evil"})
    awesome.emit_signal("evil::playerctl", artist, title, status)
end


update_metadata()

local spotify_script = [[
  sh -c '
    playerctl status
  ']]

-- Emit song info with each line printed
awful.spawn.with_line_callback(spotify_script, {
    stdout = function()
    naughty.notify({ title = "Player", text = "STATE CHANGED"})
        update_metadata()
    end
})
