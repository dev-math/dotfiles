-- Functions that you use more than once and in different files would
-- be nice to define here.

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local naughty = require("naughty")

local helpers = {}

-- Tag back and forth:
-- If you try to focus the tag you are already at, go back to the previous tag.
-- Useful for quick switching after for example checking an incoming chat
-- message at tag 2 and coming back to your work at tag 1 with the same
-- keypress.
function helpers.tag_back_and_forth(tag_index)
    local s = mouse.screen
    local tag = s.tags[tag_index]
    if tag then
         if tag == s.selected_tag then
             awful.tag.history.restore()
         else
             tag:view_only()
         end
    end
end

local direction_translate = {
    ['up'] = 'top',
    ['down'] = 'bottom',
    ['left'] = 'left',
    ['right'] = 'right'
}

function helpers.move_to_edge(c, direction)
    local old = c:geometry()
    local new = awful.placement[direction_translate[direction]](c, {honor_padding = true, honor_workarea = true, margins = beautiful.useless_gap * 2, pretend = true})
    if direction == "up" or direction == "down" then
        c:geometry({ x = old.x, y = new.y })
    else
        c:geometry({ x = new.x, y = old.y })
    end
end

-- Move client DWIM (Do What I Mean)
-- Move to edge if the client / layout is floating
-- Swap by index if maximized
-- Else swap client by direction
function helpers.move_client_dwim(c, direction)
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        helpers.move_to_edge(c, direction)
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end

-- volume
function helpers.volume_control(step)
    local cmd
    if step == 0 then
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    else
        sign = step > 0 and "+" or ""
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "..sign..tostring(step).."%"
    end
    awful.spawn.with_shell(cmd)
end

function helpers.run_or_raise(match, move, spawn_cmd, spawn_args)
    local matcher = function (c)
        return awful.rules.match(c, match)
    end

    -- Find and raise
    local found = false
    for c in awful.client.iterate(matcher) do
        found = true
        c.minimized = false
        if move then
            c:move_to_tag(mouse.screen.selected_tag)
            client.focus = c
        else
            c:jump_to()
        end
        break
    end

    -- Spawn if not found
    if not found then
        awful.spawn(spawn_cmd, spawn_args)
    end
end

-- The directory of the currently executed lua script
-- Requires the `debug` library to be available in the build of Lua that is running
function helpers.this_dir()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

-- Create rounded rectangle shape (in one line)
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

helpers.colorize_text = function(text, color)
    return "<span foreground='"..color.."'>"..text.."</span>"
end

-- Add a hover cursor to a widget by changing the cursor on
-- mouse::enter and mouse::leave
-- You can find the names of the available cursors by opening any
-- cursor theme and looking in the "cursors folder"
-- For example: "hand1" is the cursor that appears when hovering over
-- links
function helpers.add_hover_cursor(w, hover_cursor)
    local original_cursor = "left_ptr"

    w:connect_signal("mouse::enter", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = hover_cursor
        end
    end)

    w:connect_signal("mouse::leave", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = original_cursor
        end
    end)
end

function helpers.vertical_pad(height)
    return wibox.widget{
        forced_height = height,
        layout = wibox.layout.fixed.vertical
    }
end

function helpers.horizontal_pad(width)
    return wibox.widget{
        forced_width = width,
        layout = wibox.layout.fixed.horizontal
    }
end

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

-- Useful for periodically checking the output of a command that
-- requires internet access.
-- Ensures that `command` will be run EXACTLY once during the desired
-- `interval`, even if awesome restarts multiple times during this time.
-- Saves output in `output_file` and checks its last modification
-- time to determine whether to run the command again or not.
-- Passes the output of `command` to `callback` function.
function helpers.remote_watch(command, interval, output_file, callback)
    local run_the_thing = function()
        -- Pass output to callback AND write it to file
        awful.spawn.easy_async_with_shell(command.." | tee "..output_file, function(out) callback(out) end)
    end

    local timer
    timer = gears.timer {
        timeout = interval,
        call_now = true,
        autostart = true,
        single_shot = false,
        callback = function()
            awful.spawn.easy_async_with_shell("date -r "..output_file.." +%s", function(last_update, _, __, exitcode)
                -- Probably the file does not exist yet (first time
                -- running after reboot)
                if exitcode == 1 then
                    run_the_thing()
                    return
                end

                local diff = os.time() - tonumber(last_update)
                if diff >= interval then
                    run_the_thing()
                else
                    -- Pass the date saved in the file since it is fresh enough
                    awful.spawn.easy_async_with_shell("cat "..output_file, function(out) callback(out) end)

                    -- Schedule an update for when the remaining time to complete the interval passes
                    timer:stop()
                    gears.timer.start_new(interval - diff, function()
                        run_the_thing()
                        timer:again()
                    end)
                end
            end)
        end
    }
end

-- Rounds a number to any number of decimals
function helpers.round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end

-- Adds a maximized mask to a screen
function helpers.screen_mask(s, bg)
    local mask = wibox({visible = false, ontop = true, type = "splash", screen = s})
    awful.placement.maximize(mask)
    mask.bg = bg
    return mask
end

local double_tap_timer = nil
function helpers.single_double_tap(single_tap_function, double_tap_function)
    if double_tap_timer then
        double_tap_timer:stop()
        double_tap_timer = nil
        double_tap_function()
        return
    end

    double_tap_timer =
        gears.timer.start_new(0.20, function()
            double_tap_timer = nil
            if single_tap_function then
                single_tap_function()
            end
            return false
        end)
end

function helpers.float_and_resize(c, width, height)
    c.maximized = false
    c.width = width
    c.height = height
    awful.placement.centered(c,{honor_workarea=true, honor_padding = true})
    awful.client.property.set(c, 'floating_geometry', c:geometry())
    c.floating = true
    c:raise()
end

function helpers.toggle_float_tile(c)
    local clients = awful.screen.focused().clients
    if (awful.layout.get(mouse.screen) == awful.layout.suit.floating) or (awful.layout.get(mouse.screen) == awful.layout.suit.max) then
        -- TILE
	for _, c in pairs(clients) do
	    c.maximized = false
	    c.floating = false
        end
	awful.layout.set(awful.layout.suit.tile)
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.tile then
	-- FLOAT
	awful.layout.set(awful.layout.suit.floating)
    end
end

-- Lain Helpers

-- run a command and execute a function on its output line by line
function helpers.line_callback(cmd, callback)
    return spawn.with_line_callback(cmd, {
        stdout = function (line)
            callback(line)
        end,
    })
end

-- get first line of a file
function helpers.first_line(path)
    local file, first = io.open(path, "rb"), nil
    if file then
        first = file:read("*l")
        file:close()
    end
    return first
end

-- {{{ Timer maker

helpers.timer_table = {}

function helpers.newtimer(name, timeout, fun, nostart, stoppable)
    if not name or #name == 0 then return end
    name = (stoppable and name) or timeout
    if not helpers.timer_table[name] then
        helpers.timer_table[name] = timer({ timeout = timeout })
        helpers.timer_table[name]:start()
    end
    helpers.timer_table[name]:connect_signal("timeout", fun)
    if not nostart then
        helpers.timer_table[name]:emit_signal("timeout")
    end
    return stoppable and helpers.timer_table[name]
end

-- }}}

-- End Lain Helpers

return helpers
