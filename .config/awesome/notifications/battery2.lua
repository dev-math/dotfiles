local helpers = require("helpers")
local icons = require("icons")
local notifications = require("notifications")

-- Helper variables
local battery_first_time = true
local charger_plugged = true
local battery_full_already_notified = true
local battery_low_already_notified = false
local battery_critical_already_notified = false
local notif
local battery_current = 100
local battery_full_threshold = 99

-- Full / Low / Critical notifications
awesome.connect_signal("evil::battery2", function(battery)
    local message
    local icon
    local timeout
    battery_current = battery
    if battery_first_time then
        battery_first_time = false
        return
    end
    if not charger_plugged then
        icon = icons.image.battery
        if battery <= user.battery_threshold_critical and not battery_critical_already_notified then
            battery_critical_already_notified = true
            message = "CRITICAL"
            -- message = helpers.colorize_text("CRITICAL", x.color9)
            timeout = 0
        elseif battery <= user.battery_threshold_low and not battery_low_already_notified then
            battery_low_already_notified = true
            message = "Low"
            -- message = helpers.colorize_text("Low", x.color11)
            timeout = 6
        end
    else
        icon = icons.image.battery_charging
        if battery > battery_full_threshold and not battery_full_already_notified then
            battery_full_already_notified = true
            message = "Full"
            -- message = helpers.colorize_text("Full", x.color10)
            timeout = 6
        end
    end

    -- If message has been initialized, then we need to send a notification
    if message then
        notif = notifications.notify_dwim({ title = "Battery", message = message, icon = icon, timeout = timeout, app_name = "battery" }, notif)
    end
end)
