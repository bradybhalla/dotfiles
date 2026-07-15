---------------------
---- INITIAL SETUP --
---------------------

hl.on("hyprland.start", function()
    -- start desktop components
    hl.exec_cmd("waybar")         -- status bar
    hl.exec_cmd("hyprpaper")      -- wallpaper
    hl.exec_cmd("swaync")         -- notifications
    hl.exec_cmd("swayosd-server") -- on-screen display for volume/media
    hl.exec_cmd("eww daemon")     -- widgets

    -- start other processes
    hl.exec_cmd("hyprsunset")  -- allows night mode
    hl.exec_cmd("hypridle")    -- idle behavior
    hl.exec_cmd("maestral_qt") -- dropbox (maestral) tray applet and daemon
    -- TODO: 1password and trayscale have too many issues to start here
end)

---------------------
---- KEYBINDINGS ----
---------------------

-- TODO: get rid of these
local terminal       = "alacritty"
local menu           = "rofi -show drun"
local browser        = "firefox"
local locker         = "hyprlock"
local logout         = "hyprshutdown -p 'uwsm stop'"

local mainMod        = "SUPER"

local screenshotArgs = "-o ~/Screenshots"

-- every keybind, as { key, action, opts? }. a string action is run as a shell
-- command; a dispatcher/function is bound directly. see bind() above for how
-- opts (including withMod) is handled. registered by the loop at the end.
-- TODO: rework binds
local binds          = {
    -- apps and window actions
    { "Return",               terminal },
    { "Space",                menu },
    { "B",                    browser },
    { "E",                    "emacsclient -c -a ''" },
    { "F",                    hl.dsp.window.fullscreen({ mode = 1 }) },
    { "SHIFT + F",            hl.dsp.window.float({ action = "toggle" }) },
    { "N",                    "swaync-client -t -sw" },
    { "Q",                    hl.dsp.window.close() },
    { "SHIFT + Q",            locker },
    { "CTRL + SHIFT + Q",     logout },
    { "M",                    "eww open --toggle music" },
    { "P",                    "1password --quick-access" },

    -- Screenshots (copied to clipboard and saved)
    { "S",                    "hyprshot -m region " .. screenshotArgs },

    -- Window focus and moving
    { "H",                    hl.dsp.focus({ direction = "left" }) },
    { "L",                    hl.dsp.focus({ direction = "right" }) },
    { "K",                    hl.dsp.focus({ direction = "up" }) },
    { "J",                    hl.dsp.focus({ direction = "down" }) },
    { "SHIFT + H",            hl.dsp.window.move({ direction = "left" }) },
    { "SHIFT + L",            hl.dsp.window.move({ direction = "right" }) },
    { "SHIFT + K",            hl.dsp.window.move({ direction = "up" }) },
    { "SHIFT + J",            hl.dsp.window.move({ direction = "down" }) },

    -- Workspace focus and moving
    { "1",                    hl.dsp.focus({ workspace = 1 }) },
    { "2",                    hl.dsp.focus({ workspace = 2 }) },
    { "3",                    hl.dsp.focus({ workspace = 3 }) },
    { "4",                    hl.dsp.focus({ workspace = 4 }) },
    { "5",                    hl.dsp.focus({ workspace = 5 }) },
    { "6",                    hl.dsp.focus({ workspace = 6 }) },
    { "7",                    hl.dsp.focus({ workspace = 7 }) },
    { "8",                    hl.dsp.focus({ workspace = 8 }) },
    { "9",                    hl.dsp.focus({ workspace = 9 }) },
    { "0",                    hl.dsp.focus({ workspace = 10 }) },
    { "SHIFT + 1",            hl.dsp.window.move({ workspace = 1 }) },
    { "SHIFT + 2",            hl.dsp.window.move({ workspace = 2 }) },
    { "SHIFT + 3",            hl.dsp.window.move({ workspace = 3 }) },
    { "SHIFT + 4",            hl.dsp.window.move({ workspace = 4 }) },
    { "SHIFT + 5",            hl.dsp.window.move({ workspace = 5 }) },
    { "SHIFT + 6",            hl.dsp.window.move({ workspace = 6 }) },
    { "SHIFT + 7",            hl.dsp.window.move({ workspace = 7 }) },
    { "SHIFT + 8",            hl.dsp.window.move({ workspace = 8 }) },
    { "SHIFT + 9",            hl.dsp.window.move({ workspace = 9 }) },
    { "SHIFT + 0",            hl.dsp.window.move({ workspace = 10 }) },

    -- window/workspace with mouse keys
    { "mouse_down",           hl.dsp.focus({ workspace = "e+1" }) },                                       -- scroll through workspaces
    { "mouse_up",             hl.dsp.focus({ workspace = "e-1" }) },
    { "mouse:272",            hl.dsp.window.drag(),                                    { mouse = true } }, -- move with left mouse
    { "mouse:273",            hl.dsp.window.resize(),                                  { mouse = true } }, -- resize with right mouse

    -- Volume and audio control
    { "XF86AudioRaiseVolume", "swayosd-client --output-volume raise --max-volume 100", { locked = true, repeating = true, withMod = false } },
    { "XF86AudioLowerVolume", "swayosd-client --output-volume lower",                  { locked = true, repeating = true, withMod = false } },
    { "XF86AudioMute",        "swayosd-client --output-volume mute-toggle",            { locked = true, repeating = true, withMod = false } },
    { "XF86AudioMicMute",     "swayosd-client --input-volume mute-toggle",             { locked = true, repeating = true, withMod = false } },
    { "XF86AudioNext",        "swayosd-client --playerctl next",                       { locked = true, withMod = false } },
    { "XF86AudioPause",       "swayosd-client --playerctl play-pause",                 { locked = true, withMod = false } },
    { "XF86AudioPlay",        "swayosd-client --playerctl play-pause",                 { locked = true, withMod = false } },
    { "XF86AudioPrev",        "swayosd-client --playerctl prev",                       { locked = true, withMod = false } },
}

local function bind(key, action, opts)
    opts = opts or {}
    local withMod = opts.withMod
    if withMod == nil then withMod = true end
    opts.withMod = nil -- strip it so hl.bind never sees it
    if withMod then key = mainMod .. " + " .. key end
    if type(action) == "string" then action = hl.dsp.exec_cmd(action) end
    hl.bind(key, action, opts)
end

for _, b in ipairs(binds) do
    bind(b[1], b[2], b[3])
end


---------------------------
---- THEME ----------------
---------------------------

local catppuccin = require("catppuccin-frappe")

hl.config({
    general = {
        border_size             = 3,
        gaps_in                 = 3,
        gaps_out                = 6,
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
    -- with some login screens the cursor was staying around
    cursor = {
        no_hardware_cursors = true,
    },
})

hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "default" })


---------------------------
---- WINDOWS RULES --------
---------------------------

-- TODO: got from suggested config, are these actually helpful?
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})


-- needed because blur is enabled for waybar but I don't want it anywhere else
hl.window_rule({
    name    = "no-blur-by-default",
    match   = { class = ".*" },
    no_blur = true,
})

hl.window_rule({
    name         = "fullscreen-border",
    match        = { fullscreen = true, focus = true },
    border_color = catppuccin.teal
})


hl.window_rule({
    name         = "1Password Quick Access",
    match        = { title = "^Quick Access — 1Password$" },
    stay_focused = true
})
hl.window_rule({
    name             = "firefox picture-in-picture",
    match            = { class = "^firefox$", title = "^Picture-in-Picture$" },
    float            = true,
    pin              = true,
    no_initial_focus = true,
    move             = "monitor_w-window_w-9 monitor_h-window_h-9",
    -- opacity 20% while focused
    opacity          = "0.2 1.0",
})

-- make windows float
local float_windows = {
    { match = { class = "^\\.blueman-manager-wrapped$" } },                                                   -- blueman (bluetooth tray)
    { match = { class = "^org\\.pulseaudio\\.pavucontrol$" }, enforce_size = "1100 800" },                    -- pavucontrol (volume control)
    { match = { class = "^1password$" } },                                                                    -- 1Password
    { match = { class = "^python3$", title = "^Maestral.*" } },                                               -- maestral
    { match = { class = "^qimgv$" } },                                                                        -- qimgv (image viewer)
    { match = { class = "^dev\\.deedles\\.Trayscale$" },      enforce_size = "1100 800" }                     -- trayscale (tailscale tray)
}
local function add_float_rule(match, enforce_size)
    hl.window_rule({
        match = match,
        float = true,
        size  = enforce_size,
    })
end
for _, w in ipairs(float_windows) do
    add_float_rule(w.match, w.enforce_size)
end


hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
})


---------------------------
---- MONITORS -------------
---------------------------

-- Monitor configuration for VMs
hl.monitor({ output = "Virtual-1", mode = "1920x1200@59.88", position = "0x0", scale = 1.0 })
hl.monitor({ output = "Unknown-1", disabled = true })
