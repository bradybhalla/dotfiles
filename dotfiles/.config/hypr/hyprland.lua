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
  -- start desktop components
  hl.exec_cmd("waybar") -- status bar
  hl.exec_cmd("hyprpaper") -- wallpaper
  hl.exec_cmd("swaync") -- notifications
  hl.exec_cmd("swayosd-server") -- on-screen display for volume/media
  hl.exec_cmd("eww daemon") -- widgets

  -- start other processes
  hl.exec_cmd("hyprsunset") -- allows night mode
  hl.exec_cmd("hypridle") -- idle behavior
  hl.exec_cmd("sh -c '" .. waitForTray .. " exec 1password --silent'") -- 1password tray applet  TODO: it seems like this is needed but double check
  hl.exec_cmd("maestral_qt") -- dropbox (maestral) tray applet and daemon
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

-- TODO: rework binds
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
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Screenshots (copied to clipboard and saved)
-- TODO: maybe just save to desktop?
local screenshotArgs = "-o ~/Pictures/Screenshots"
hl.bind("Print",                   hl.dsp.exec_cmd("hyprshot -m output " .. screenshotArgs))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region " .. screenshotArgs))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprshot -m window " .. screenshotArgs))

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

-- Volume keys (swayosd-client shows an on-screen display)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise --max-volume 100"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"),                  { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),            { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),             { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("swayosd-client --brightness raise"),                     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("swayosd-client --brightness lower"),                     { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("swayosd-client --playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("swayosd-client --playerctl prev"),       { locked = true })


---------------------------
---- WINDOWS RULES --------
---------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- No window blur by default. Hyprland's decoration:blur:enabled is a global
-- master switch (and must stay on for the waybar layer_rule blur to render),
-- so instead we disable blur for every window and opt back in only where
-- wanted -- add `no_blur = false` to a specific window rule to re-enable it.
hl.window_rule({
    name  = "no-blur-by-default",
    match = { class = ".*" },
    no_blur = true,
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
    match = { class = "^\\.blueman-manager-wrapped$" },
    float = true,
})
hl.window_rule({
    name  = "pavucontrol (volume control)",
    match = { class = "^org\\.pulseaudio\\.pavucontrol$" },
    float = true,
    size  = "1100 800",
})
hl.window_rule({
    name  = "1Password",
    match = { class = "^1password$" },
    float = true,
})
hl.window_rule({
    name  = "qimgv (image viewer)",
    match = { class = "^qimgv$" },
    float = true,
})
hl.window_rule({
    name  = "firefox picture-in-picture",
    match = { class = "^firefox$", title = "^Picture-in-Picture$" },
    float = true,
    pin   = true,
    -- don't steal focus when it pops out (can still be focused afterward by
    -- hover/click -- unlike no_focus, which would disable focus entirely and
    -- break the hover-fade opacity below).
    no_initial_focus = true,
    -- spawn in the bottom-right corner, lined up with tiled window borders.
    -- move positions the content box and the border is drawn outside it, so
    -- the margin is gaps_out(6) + border_size(3) = 9 (tiled window content
    -- sits inset by that same 9px). monitor_w/h and window_w/h are this lua
    -- config's position tokens (native 100%-w is NOT supported here).
    move  = "monitor_w-window_w-9 monitor_h-window_h-9",
    -- fade to 20% while hovered/focused, full opacity otherwise.
    -- relies on focus-follows-mouse (follow_mouse = 1, the default) so
    -- "active" == "pointer is over it": opacity <active> <inactive>
    opacity = "0.2 1.0",
})

hl.layer_rule({
  match = { namespace = "waybar" },
  blur = true,
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
    blur = {
        passes = 3,
    },
    },
    misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
  },
})

hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "default" })
