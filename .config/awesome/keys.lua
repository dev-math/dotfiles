local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local apps = require("apps")
local switcher = require("elemental.awesome-switcher")
local helpers = require("helpers")

-- Math
local math = math
local abs = math.abs

local keys = {}

-- Mod keys
superkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

-- settings
local titlebar_win_shade_enabled = true

local double_click_jitter_tolerance = 4
local double_click_time_window_ms = 250

-- {{{ Mouse bindings on desktop
keys.desktopbuttons = gears.table.join(
    -- Middle button - Toggle dashboard
    awful.button({ }, 2, function ()
        if dashboard_show then
            dashboard_show()
        end
    end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("rofi -no-lazy-grab -show themes:~/.dotfiles/.config/rofi/themeswitch.sh -theme $HOME/.cache/wal/colors-rofi-dark.rasi")
    end)
)
-- }}}

-- {{{ Key bindings
keys.globalkeys = gears.table.join(
    -- start a terminal
    awful.key({ superkey }, "Return", function () awful.spawn(user.terminal) end,
        {description = "open a terminal", group = "launcher"}),

    awful.key({ superkey,           }, "u",
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then
                return
            else
                awful.client.urgent.jumpto()
            end
        end,
        {description = "jump to urgent client", group = "client"}),

    -- change focus 
    awful.key({ superkey }, "j",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}),
    awful.key({ superkey }, "k",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
    awful.key({ superkey }, "h",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
    awful.key({ superkey }, "l",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),

    -- toggle gaps
    awful.key({ superkey, shiftkey }, "g",
        function ()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key({ superkey }, "g",
        function ()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),

    -- reload the configuration file
    awful.key({ superkey, shiftkey }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),

    -- exit Awesome
    -- Logout, Shutdown, Restart, Suspend, Lock
    awful.key({ superkey, shiftkey }, "e",
        function ()
            awful.spawn.with_shell("~/.dotfiles/.scripts/powermenu.sh")
        end,
        {description = "quit awesome", group = "awesome"}),
    awful.key({ }, "XF86PowerOff",
        function ()
            awful.spawn.with_shell("~/.dotfiles/.scripts/powermenu.sh")
        end,
        {description = "quit awesome", group = "awesome"}),

    -- lock screen
    awful.key({ superkey, shiftkey }, "l",
        function ()
            awful.spawn.with_shell("~/.local/bin/lock")
        end,
        {description = "lock screen", group = "awesome"}),

    -- Brightness
    awful.key( { }, "XF86MonBrightnessDown",
        function()
            awful.spawn.with_shell("light -U 10")
        end,
        {description = "decrease brightness", group = "brightness"}),
    awful.key( { }, "XF86MonBrightnessUp",
        function()
            awful.spawn.with_shell("light -A 10")
        end,
        {description = "increase brightness", group = "brightness"}),

    -- Volume Control with volume keys
    awful.key( { }, "XF86AudioMute",
        function()
            helpers.volume_control(0)
        end,
        {description = "(un)mute volume", group = "volume"}),
    awful.key( { }, "XF86AudioLowerVolume",
        function()
            helpers.volume_control(-1)
        end,
        {description = "lower volume", group = "volume"}),
    awful.key( { }, "XF86AudioRaiseVolume",
        function()
            helpers.volume_control(1)
        end,
        {description = "raise volume", group = "volume"}),

    -- exec rofi
    awful.key({ ctrlkey }, "space",
        function()
            awful.spawn.with_shell("rofi -no-lazy-grab -show drun -modi drun -theme $HOME/.cache/wal/colors-rofi-launch2.rasi")
        end,
        {description = "rofi launcher", group = "launcher"}),

    -- exec file manager
    awful.key({ superkey }, "e", apps.file_manager,
        {description = "file manager", group = "launcher"}),

    -- exec system monitor
    awful.key({ ctrlkey, altkey }, "Delete", apps.system_monitor,
        {description = "system monitor", group = "launcher"}),

    -- Screenshots
    awful.key( { superkey }, "Print", function() apps.screenshot("full") end,
        {description = "select area to capture", group = "screenshots"}),
    awful.key( { }, "Print", function() apps.screenshot("selection") end,
        {description = "take full screenshot", group = "screenshots"}),

    -- exec app switcher (alt-tab)
    awful.key({ altkey }, "Tab", function() switcher.switch( 1, "Mod1", "Alt_L", "Shift", "Tab") end,
        {description = "application switcher", group = "launcher"}),

    -- Max layout
    -- Single tap: Set max layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key({ superkey }, "w",
        function()
            awful.layout.set(awful.layout.suit.max)
            helpers.single_double_tap(
                nil,
                function()
                    local clients = awful.screen.focused().clients
                    for _, c in pairs(clients) do
                        c.floating = false
                    end
                end)
        end,
        {description = "set max layout", group = "tag"}),

    -- Toggle Tiling/Floating
    awful.key({ superkey }, "s",
        function()
            helpers.toggle_float_tile(c)
        end,
	{description = "toggle layout tiling/floating", group = "tag"}),
      
    -- Number of master clients
    awful.key({ superkey, altkey }, "h",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ superkey, altkey }, "l",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ superkey, altkey }, "Left",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ superkey, altkey }, "Right",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),

    -- Number of columns
    awful.key({ superkey, altkey }, "k",   
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ superkey, altkey }, "j",   
        function () 
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ superkey, altkey }, "Up",   
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ superkey, altkey }, "Down",   
        function () 
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"})
)

keys.clientkeys = gears.table.join(
    -- kill focused window
    awful.key({ superkey, shiftkey   }, "q",      function (c) c:kill() end,
        {description = "close", group = "client"}),
    awful.key({ altkey }, "F4",      function (c) c:kill() end,
        {description = "close", group = "client"}),    

    -- Single tap: Center client 
    -- Double tap: Center client + Floating + Resize
    awful.key({ superkey }, "c", function (c)
        awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
        helpers.single_double_tap(
            nil,
            function ()
                helpers.float_and_resize(c, screen_width * 0.65, screen_height * 0.9)
            end)
    end),

    -- move focused window
    awful.key({ superkey }, "Down", function (c)
        helpers.move_client_dwim(c, "down")
    end),
    awful.key({ superkey }, "Up", function (c)
        helpers.move_client_dwim(c, "up")
    end),
    awful.key({ superkey }, "Left", function (c)
        helpers.move_client_dwim(c, "left")
    end),
    awful.key({ superkey }, "Right", function (c)
        helpers.move_client_dwim(c, "right")
    end),

    -- enter fullscreen mode for the focused container
    awful.key({ superkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    
    -- toggle floating client
    awful.key({ superkey, ctrlkey }, "space",
        function(c)
            local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
            if not layout_is_floating then
                awful.client.floating.toggle()
            end
        end,
        {description = "toggle floating", group = "client"})

) 

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = 10
for i = 1, ntags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- switch to workspace 
        -- View tag only.
        awful.key({ superkey }, "#" .. i + 9,
            function ()
                -- Tag back and forth
                helpers.tag_back_and_forth(i)

                -- Simple tag view
                -- local tag = mouse.screen.tags[i]
                -- if tag then
                -- tag:view_only()
                -- end
            end,
            {description = "view tag #"..i, group = "tag"}),

        -- Toggle tag display.
        awful.key({ superkey, ctrlkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),

        -- Move focused container to workspace
        awful.key({ superkey, shiftkey }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),

        -- Move all visible clients to tag and focus that tag
        awful.key({ superkey, altkey }, "#" .. i + 9,
            function ()
                local tag = client.focus.screen.tags[i]
                local clients = awful.screen.focused().clients
                if tag then
                    for _, c in pairs(clients) do
                        c:move_to_tag(tag)
                    end
                    tag:view_only()
                end
            end,
            {description = "move all visible clients to tag #"..i, group = "tag"}),

        -- Toggle tag on focused client.
        awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        client.focus = c
        c:raise()

        -- Only use bottom left/right corner, because dragging titlebar is already mapped to move
        local corners = {
            { c.x + c.width, c.y + c.height },
            { c.x, c.y + c.height },
        }

        local m = mouse.coords()
        local distance = 20

        for _, pos in ipairs(corners) do
            if math.sqrt((m.x - pos[1]) ^ 2 + (m.y - pos[2]) ^ 2) <= distance then
                awful.mouse.client.resize(c)
                break
            end
        end


    end),
    awful.button({ superkey }, 1, awful.mouse.client.move),
    -- awful.button({ superkey }, 2, function (c) c:kill() end),
    awful.button({ superkey }, 3, function(c)
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end)
)

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t)
        -- t:view_only()
        helpers.tag_back_and_forth(t.index)
    end),
    awful.button({ superkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    -- awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 3, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ superkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

-- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the superkey is pressed
keys.tasklist_buttons = gears.table.join(
    awful.button({ 'Any' }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
            end
    end),
    -- Middle mouse button closes the window (on release)
    awful.button({ 'Any' }, 2, nil, function (c) c:kill() end),
    awful.button({ 'Any' }, 3, function (c) c.minimized = true end),
    awful.button({ 'Any' }, 4, function ()
        awful.client.focus.byidx(-1)
    end),
    awful.button({ 'Any' }, 5, function ()
        awful.client.focus.byidx(1)
    end),

    -- Side button up - toggle floating
    awful.button({ 'Any' }, 9, function(c)
        c.floating = not c.floating
    end),
    -- Side button down - toggle ontop
    awful.button({ 'Any' }, 8, function(c)
        c.ontop = not c.ontop
    end)
)

-- TITLEBAR BUTTONS
function get_titlebar_mouse_bindings(c)
    local shade_enabled = titlebar_win_shade_enabled
    -- Add functionality for double click to (un)maximize, and single click and hold to move
    local clicks = 0
    local tolerance = double_click_jitter_tolerance
    local buttons = {
        awful.button(
            {}, 1, function()
                local cx, cy = _G.mouse.coords().x, _G.mouse.coords().y
                local delta = double_click_time_window_ms / 1000
                clicks = clicks + 1
                if clicks == 2 then
                    local nx, ny = _G.mouse.coords().x, _G.mouse.coords().y
                    -- The second click is only counted as a double click if it is within the neighborhood of the first click's position, and occurs within the set time window
                    if abs(cx - nx) <= tolerance and abs(cy - ny) <= tolerance then
                        c.maximized = not c.maximized
			c:raise()
                    end
                else
                    c:activate{context = "titlebar", action = "mouse_move"}
                end
                -- Start a timer to clear the click count
                gears.timer.weak_start_new(
                    delta, function() clicks = 0 end)
            end),
        awful.button(
            {}, 3, function()
                c:activate{context = "mouse_click", action = "mouse_resize"}
            end),
    }
    return buttons
end

-- }}}
-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
