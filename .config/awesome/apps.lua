local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("helpers")
local icons = require("icons")
-- local notifications = require("notifications")

local apps = {}

apps.file_manager = function ()
    awful.spawn(user.file_manager, { floating = true })
end

apps.system_monitor = function ()
    helpers.run_or_raise({instance = 'gotop'}, false, user.terminal.." --class gotop -e gotop -r 10s", { switchtotag = true })
end

apps.temperature_monitor = function ()
    helpers.run_or_raise({class = 'sensors'}, false, user.terminal.." --class sensors -e watch sensors", { switchtotag = true, tag = mouse.screen.tags[5] })
end

apps.process_monitor_gui = function ()
    helpers.run_or_raise({class = 'Lxtask'}, false, "lxtask")
end

apps.volume = function ()
    helpers.run_or_raise({class = 'Pavucontrol'}, true, "pavucontrol")
end

-- Screenshots
local capture_notif = nil
local screenshot_notification_app_name = "screenshot"
function apps.screenshot(action, delay)
-- Screenshot capturing actions
    local cmd
    local timestamp = os.date("%d-%m-%Y-%M:%M:%S")
    local filename = user.dirs.screenshots.."/"..timestamp..".png"
    local icon = ""

    -- Configure action buttons for the notification
    local screenshot_open = naughty.action { name = "Open" }
    local screenshot_copy = naughty.action { name = "Copy" }
    local screenshot_edit = naughty.action { name = "Edit" }
    local screenshot_delete = naughty.action { name = "Delete" }
    screenshot_open:connect_signal('invoked', function()
        awful.spawn.with_shell("eog "..filename.."")
    end)
    screenshot_copy:connect_signal('invoked', function()
        awful.spawn.with_shell("xclip -selection clipboard -t image/png "..filename.." &>/dev/null")
    end)
    screenshot_edit:connect_signal('invoked', function()
        awful.spawn.with_shell("gimp "..filename.." >/dev/null")
    end)
    screenshot_delete:connect_signal('invoked', function()
        awful.spawn.with_shell("rm "..filename)
    end)

    if action == "full" then
        cmd = "maim "..filename
        awful.spawn.easy_async_with_shell(cmd, function()
            naughty.notification({
                title = "Screenshot ",
                message = "Screenshot taken",
                icon = icon,
                actions = { screenshot_open, screenshot_copy, screenshot_edit, screenshot_delete },
                app_name = screenshot_notification_app_name,
            })
        end)
    elseif action == "selection" then
        cmd = "maim -s "..filename
        capture_notif = naughty.notification({ title = "Screenshot", message = "Select area to capture.", icon = icon, timeout = 1, app_name = screenshot_notification_app_name })
        awful.spawn.easy_async_with_shell(cmd, function(_, __, ___, exit_code)
            naughty.destroy(capture_notif)
            if exit_code == 0 then
                naughty.notification({
                    title = "Screenshot",
                    message = "Selection captured",
                    icon = icon,
                    actions = { screenshot_open, screenshot_copy, screenshot_edit, screenshot_delete },
                    app_name = screenshot_notification_app_name,
                })
            end
        end)
    end

end


return apps 
