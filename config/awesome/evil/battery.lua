-- Provides:
-- evil::battery
--      percentage (integer)
-- evil::battery2
--      percentage (integer)
-- evil::charger
--      plugged (boolean)

local awful = require("awful")
local lainbattery = require("noodle.lainbattery")

local battery1 = lainbattery({
    battery = "BAT0",
    --timeout = 2,
    notify = "off",

    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc or bat_now.perc
	awesome.emit_signal("evil::battery", perc)
    end
})

local battery2 = lainbattery({
    battery = "BAT1",
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc or bat_now.perc       
        --if bat_now.ac_status == 1 then
        --    perc = perc .. " plug"
        --end
        awesome.emit_signal("evil::battery2", perc)             
    end
}) 

-- Subscribe to power supply status changes with acpi_listen
local charger_script = [[
    sh -c '
    acpi_listen | grep --line-buffered ac_adapter
    '
]]

-- First get charger file path
awful.spawn.easy_async_with_shell("sh -c 'out=\"$(find /sys/class/power_supply/*/online)\" && (echo \"$out\" | head -1) || false' ", function (charger_file, _, __, exit_code)
    -- No charger file found
    if not (exit_code == 0) then
        return
    end
    -- Then initialize function that emits charger info
    local emit_charger_info = function()
        awful.spawn.easy_async_with_shell("cat "..charger_file, function (out)
            local status = tonumber(out) == 1
            awesome.emit_signal("evil::charger", status)
        end)
    end

    -- Run once to initialize widgets
    emit_charger_info()

    -- Kill old acpi_listen process
    awful.spawn.easy_async_with_shell("ps x | grep \"acpi_listen\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
        -- Update charger status with each line printed
        awful.spawn.with_line_callback(charger_script, {
            stdout = function(_)
                emit_charger_info()
            end
        })
    end)
end)
