local awful                              = require("awful")
local wibox                              = require("wibox")
local gears                              = require("gears")
local theme_name                         = "pywal"
local theme_assets                       = require("beautiful.theme_assets")
local xresources                         = require("beautiful.xresources")
local dpi                                = xresources.apply_dpi
local gfs                                = require("gears.filesystem")
local themes_path                        = gfs.get_themes_dir()
local xrdb                               = xresources.get_current_theme()
local theme                              = {}

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
theme.wallpaper                          = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/wallpaper.jpg"

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
-- theme.font                               = "sans 11"
-- theme.font                               = "monospace 11"
theme.font                               = "SF UI Display 11"

-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark                            = x.background
theme.bg_normal                          = x.color0
theme.bg_focus                           = x.color8
theme.bg_urgent                          = x.color8
theme.bg_minimize                        = x.color8
theme.bg_systray                         = x.background

theme.fg_normal                          = x.color8
theme.fg_focus                           = x.color4
theme.fg_urgent                          = x.color9
theme.fg_minimize                        = x.color8

-- Tooltip
theme.tooltip_font                       = "SF UI Display 12"
theme.tooltip_bg                         = x.foreground
theme.tooltip_fg                         = x.background

-- Layout icons
theme.layout_fairh                       = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv                       = themes_path.."default/layouts/fairvw.png"
theme.layout_floating                    = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier                   = themes_path.."default/layouts/magnifierw.png"
theme.layout_max                         = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen                  = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom                  = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft                    = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile                        = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop                     = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral                      = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle                     = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw                    = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne                    = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw                    = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse                    = themes_path.."default/layouts/cornersew.png"

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled                  = true
theme.titlebar_size                      = dpi(32)

theme.titlebar_title_enabled             = true
theme.titlebar_font                      = "SF UI Display bold 12"

-- Window title alignment: left, right, center
theme.titlebar_title_align               = "center"
-- Titlebar position: top, bottom, left, right
theme.titlebar_position                  = "top"
theme.titlebar_bg                        = x.background.."CC"
-- theme.titlebar_bg_focus                  = x.color12
-- theme.titlebar_bg_normal                 = x.color8
theme.titlebar_fg_focus                  = x.color7
theme.titlebar_fg_normal                 = x.color7
-- theme.titlebar_fg                        = x.color7

-- Gaps
theme.useless_gap                        = dpi(5)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin                      = dpi(5)

-- Borders
theme.border_width                       = dpi(0)
-- theme.border_color                       = x.color0
theme.border_normal                      = x.background
theme.border_focus                       = x.background
-- Rounded corners
theme.border_radius                      = dpi(6)

-- Wibar(s)
-- Keep in mind that these settings could be ignored by the bar theme
theme.wibar_position                     = "top"
theme.wibar_height                       = dpi(35)
theme.wibar_fg                           = x.background
theme.wibar_bg                           = x.foreground
theme.wibar_border_color                 = x.color0
theme.wibar_border_width                 = dpi(0)
theme.wibar_border_radius                = dpi(0)
theme.wibar_width                        = dpi(380)

theme.prefix_fg                          = x.color8

-- Tag names
theme.tagnames = {
    " 1 ",
    " 2 ",
    " 3 ",
    " 4 ",
    " 5 ",
    " 6 ",
    " 7 ",
    " 8 ",
    " 9 ",
    " 0 ",
}

-- Noodle Text Taglist
theme.taglist_text_font                  = "SF UI Display 15"
theme.taglist_text_empty                 = {"","",""," 4"," 5"," 6"," 7"," 8","",""}
theme.taglist_text_occupied              = {"","",""," 4"," 5"," 6"," 7"," 8","",""}
theme.taglist_text_focused               = {"","",""," 4"," 5"," 6"," 7"," 8","",""}
theme.taglist_text_urgent                = {"","",""," 4"," 5"," 6"," 7"," 8","",""}

theme.taglist_text_color_empty           = x.color4
theme.taglist_text_color_occupied        = x.color7
theme.taglist_text_color_focused         = x.color4
theme.taglist_text_color_urgent          = x.color3.."A0"

-- Prompt
theme.prompt_fg                          = x.color12

-- Text Taglist (default)
theme.taglist_font                       = "SF UI Display bold 9"
theme.taglist_bg_focus                   = x.background
theme.taglist_fg_focus                   = x.color12
theme.taglist_bg_occupied                = x.background
theme.taglist_fg_occupied                = x.color8
theme.taglist_bg_empty                   = x.background
theme.taglist_fg_empty                   = x.background
theme.taglist_bg_urgent                  = x.background
theme.taglist_fg_urgent                  = x.color3
theme.taglist_disable_icon               = true
theme.taglist_spacing                    = dpi(0)
-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Sidebar
-- (Sidebar items can be customized in sidebar.lua)
theme.sidebar_bg                         = x.background
theme.sidebar_fg                         = x.color7
theme.sidebar_opacity                    = 1
theme.sidebar_position                   = "left" -- left or right
theme.sidebar_width                      = dpi(350)
theme.sidebar_x                          = 0
theme.sidebar_y                          = 0
theme.sidebar_border_radius              = 0

-- Playerctl song
theme.playerctl_song_title_color         = x.color7
theme.playerctl_song_artist_color        = x.color7
theme.playerctl_song_paused_color        = x.color8

-- Volume bar
theme.volume_bar_active_color            = x.color3
theme.volume_bar_active_background_color = x.color1
theme.volume_bar_muted_color             = x.color1
theme.volume_bar_muted_background_color  = x.color1

-- Volume bar
theme.cpu_bar_active_color               = x.color3
theme.cpu_bar_background_color           = x.color1

-- RAM bar
theme.ram_bar_active_color               = x.color3
theme.ram_bar_background_color           = x.color1

-- Brightness bar
theme.brightness_bar_active_color        = x.color3
theme.brightness_bar_background_color    = x.color1

-- Temperature bar
theme.temperature_bar_active_color       = x.color3
theme.temperature_bar_background_color   = x.color1

-- Battery bar
theme.battery_bar_active_color           = x.color3
theme.battery_bar_background_color       = x.color1

-- Brightness bar
theme.brightness_bar_active_color        = x.color3
theme.brightness_bar_background_color    = x.color0

-- Dashboard
theme.dashboard_bg                       = x.color0.."CC"
theme.dashboard_fg                       = x.color7

-- Notifications
-- ============================
-- Note: Some of these options are ignored by my custom
-- notification widget_template
-- ============================
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle
theme.notification_position              = "top_right"
theme.notification_border_width          = dpi(0)
theme.notification_border_radius         = theme.border_radius
theme.notification_border_color          = x.color10
theme.notification_bg                    = x.background
theme.notification_fg                    = x.foreground
theme.notification_crit_bg               = x.background
theme.notification_crit_fg               = x.color1
theme.notification_icon_size             = dpi(60)
theme.notification_margin                = dpi(16)
theme.notification_opacity               = 1
theme.notification_font                  = "SF UI Display 13"
theme.notification_padding               = theme.screen_margin * 2
theme.notification_spacing               = theme.screen_margin * 4

--Tasklist
theme.tasklist_font                      = "SF UI Display medium 12"
theme.tasklist_disable_icon              = true
theme.tasklist_plain_task_name           = true
theme.tasklist_bg_focus                  = x.color0
theme.tasklist_fg_focus                  = x.color4
theme.tasklist_bg_normal                 = "#00000000"
theme.tasklist_fg_normal                 = x.foreground
theme.tasklist_bg_minimize               = "#00000000"
theme.tasklist_fg_minimize               = x.foreground
theme.tasklist_font_minimized            = "SF UI Display italic 12"
theme.tasklist_bg_urgent                 = x.background
theme.tasklist_fg_urgent                 = x.color3
theme.tasklist_spacing                   = dpi(0)
theme.tasklist_align                     = "center"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Papirus"

return theme
