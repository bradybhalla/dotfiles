local catppuccin = require("catppuccin-frappe")

-- with some login screens the cursor was staying around
hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

-- Monitor configuration for VMs
hl.monitor({ output = "Virtual-1", mode = "1920x1200@59.88", position = "0x0", scale = 1.0 })
hl.monitor({ output = "Unknown-1", disabled = true })

-- 1password's tray applet checks for the StatusNotifierWatcher name once at
-- startup and gives up if waybar hasn't claimed it yet, so wait for waybar to
-- own it first. (Qt apps like maestral re-register on their own and don't need this.)
local waitForTray = "until busctl --user status org.kde.StatusNotifierWatcher >/dev/null 2>&1; do sleep 0.2; done;"

hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar") -- status bar (provides the system tray / StatusNotifierWatcher)
  hl.exec_cmd("hyprpaper") -- wallpaper
  hl.exec_cmd("hyprsunset") -- background process for night mode
  hl.exec_cmd("eww daemon") -- background process for eww widgets
  hl.exec_cmd("sh -c '" .. waitForTray .. " exec 1password --silent'") -- 1password tray applet  TODO: it seems like this is needed but double check
  hl.exec_cmd("maestral_qt") -- dropbox (maestral) tray applet
end)

local terminal    = "alacritty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"
local browser     = "firefox"
local locker      = "hyprlock"
local logout      = "hyprshutdown -p 'uwsm stop'"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + space",  hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + SHIFT + Q", hl.dsp.exec_cmd(logout))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + SHIFT + Q",         hl.dsp.exec_cmd(locker))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("eww open --toggle music"))

-- Move focus with mainMod + hjk;
hl.bind(mainMod .. " + H",         hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",         hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",         hl.dsp.focus({ direction = "down" }))

-- Move windows with mainMod + SHIFT + hjk;
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


---------------------------
---- WINDOWS RULES --------
---------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "fullscreen-border",
    match = { fullscreen = true, focus = true },
    border_color = catppuccin.teal
})

-- special windows
hl.window_rule({
    name  = "blueman (bluetooth tray)",
    match = { class = ".blueman-manager-wrapped" },
    float = true,
})
hl.window_rule({
    name  = "pavucontrol (volume control)",
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
    size  = "1100 800",
})
hl.window_rule({
    name  = "1Password",
    match = { class = "1password" },
    float = true,
})


---------------------------
---- THEME ----------------
---------------------------

hl.config({
    general = {
        border_size = 3,
        gaps_in= 3,
        gaps_out= 6,
        ["col.active_border"]   = catppuccin.blue,
        ["col.inactive_border"] = catppuccin.overlay0,
    },
    decoration = {
        rounding = 10,
    },
    misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
  },
})

hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "default" })
