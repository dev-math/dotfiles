local gears = require("gears")

local function file_exists(path)
    -- Try to open it
    local f = io.open(path)
    if f then
        f:close()
        return true
    end
    return false
end

local icons = {}
icons.image = {}
icons.text = {}

icons.text.by_class = {
    -- Terminals
    ['URxvt'] = { symbol = "", color = x.color5 },

    -- Image viewers
    ['feh'] = { symbol = "", color = x.color1 },
    ['eog'] = { symbol = "", color = x.color1 },

    -- General
    ['TelegramDesktop'] = { symbol = "", color = x.color4 },
    ['Firefox'] = { symbol = "", color = x.color3 },
    ['firefox'] = { symbol = "", color = x.color3 },
    ['Nightly'] = { symbol = "", color = x.color4 },
    ['Chromium'] = { symbol = "", color = x.color4 },
    ['Chromium-browser'] = { symbol = "", color = x.color4 },
    ['Steam'] = { symbol = "", color = x.color2 },
    ['Lutris'] = { symbol = "", color = x.color6 },
    ['editor'] = { symbol = "", color = x.color5 },
    ['Emacs'] = { symbol = "", color = x.color2 },
    ['email'] = { symbol = "", color = x.color6 },
    ['music'] = { symbol = "", color = x.color6 },
    ['mpv'] = { symbol = "", color = x.color6 },
    ['KeePassXC'] = { symbol = "", color = x.color1 },
    ['Gucharmap'] = { symbol = "", color = x.color6 },
    ['Pavucontrol'] = { symbol = "", color = x.color4 },
    ['htop'] = { symbol = "", color = x.color2 },
    ['Screenruler'] = { symbol = "", color = x.color3 },
    ['Galculator'] = { symbol = "", color = x.color2 },
    ['Zathura'] = { symbol = "", color = x.color2 },
    ['Qemu-system-x86_64'] = { symbol = "", color = x.color3 },
    ['Wine'] = { symbol = "", color = x.color1 },
    ['markdown_input'] = { symbol = "", color = x.color2 },
    ['scratchpad'] = { symbol = "", color = x.color1 },
    ['weechat'] = { symbol = "", color = x.color5 },
    ['discord'] = { symbol = "", color = x.color5 },
    ['6cord'] = { symbol = "", color = x.color3 },
    ['libreoffice-writer'] = { symbol = "", color = x.color4 },
    ['libreoffice-calc'] = { symbol = "", color = x.color2 },
    ['libreoffice-impress'] = { symbol = "", color = x.color1 },
    ['Godot'] = { symbol = "", color = x.color4 },

    -- File managers
    ['Thunar'] = { symbol = "", color = x.color3 },
    ['Nemo'] = { symbol = "", color = x.color3 },
    ['files'] = { symbol = "", color = x.color3 },

    ['Gimp'] = { symbol = "", color = x.color4 },
    ['Inkscape'] = { symbol = "", color = x.color2 },
    ['Gpick'] = { symbol = "", color = x.color6 },

    -- Default
    ['_'] = { symbol = "", color = x.color7.."99" }
}

-- Available icons
local image_icon_names = {
    "screenshot",
}

-- Path to icons
local p

-- Assumes all the icon files end in .png
local function set_image_icon(icon_name)
    local i = p..icon_name..".png"
    icons.image[icon_name] = i
end

-- Set all the icon variables
function icons.init(theme_name)
    -- Set the path to image icons
    p = gears.filesystem.get_configuration_dir().."icons/"..theme_name.."/"

    for i = 1, #image_icon_names do
        set_image_icon(image_icon_names[i])
    end

    -- Set symbols and accent colors for text icons
end

return icons
