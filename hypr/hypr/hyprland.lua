-- Hyprland Lua config (migrated from hyprland.conf, Hyprland >= 0.55)
-- Reference: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- Generic monitor fallback
-- Uses the preferred resolution/refresh rate, places
-- the monitor automatically, and applies scale 1.
-- Useful as a default rule for unknown/new displays.
-- Disabled for now to avoid wrong monitor placement.
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Built-in laptop display
-- Kept at position 0x0 as the anchor display
hl.monitor({ output = "eDP-1", mode = "2880x1800@60", position = "0x0", scale = 1.5 })

-- External monitor
-- Placed to the right of the laptop display
-- eDP-1: 2880 / 1.5 = 1920 logical width, so use 1920x0
-- DP-6 is a standard 1080p display, scale 1.25 as a comfortable middle ground
hl.monitor({ output = "DP-6", mode = "1920x1080@60", position = "1920x0", scale = 1.25 })


---------------------
---- MY PROGRAMS ----
---------------------

local mainMod     = "SUPER"
local terminal     = "alacritty"
local fileManager  = "thunar"
local menu         = "rofi -show drun"
local browser      = "firefox"


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- These ensure common applications use native Wayland
-- support instead of falling back to XWayland.
hl.env("XCURSOR_SIZE", "24")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_DATA_DIRS", "/home/erik/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share")


-------------------
---- AUTOSTART ----
-------------------

-- Startup applications and services.
-- These commands run once when Hyprland starts.
hl.on("hyprland.start", function()
    -- Export important session variables to systemd/dbus-aware applications
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd([[bash -lc 'eval "$(/usr/bin/gnome-keyring-daemon --start --components=secrets,pkcs11,ssh)"; systemctl --user import-environment GNOME_KEYRING_CONTROL SSH_AUTH_SOCK; dbus-update-activation-environment --systemd GNOME_KEYRING_CONTROL SSH_AUTH_SOCK']])

    -- PolicyKit authentication agent
    hl.exec_cmd("/usr/lib/hyprpolkitagent")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Network manager tray applet
    hl.exec_cmd("nm-applet --indicator")

    -- Status bar
    hl.exec_cmd("waybar")

    -- Notification daemon
    hl.exec_cmd("dunst")

    -- Clipboard history daemon
    hl.exec_cmd("~/.local/bin/clipboard-daemon")

    -- Hyprpaper
    hl.exec_cmd("~/.local/bin/hyprpaper-start")
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------

local active_border   = "rgba(7aa2f7ff)"
local inactive_border = "rgba(3b426199)"

hl.config({
    general = {
        -- Inner gaps between tiled windows
        gaps_in = 1,

        -- Outer gaps between windows and screen edges
        gaps_out = 1,

        -- Window border thickness
        border_size = 1,

        col = {
            -- Border color of the active window
            active_border = active_border,

            -- Border color of inactive windows
            inactive_border = inactive_border,
        },

        -- Default tiling layout
        layout = "dwindle",

        -- Allow resizing windows by dragging borders
        resize_on_border = true,
    },

    decoration = {
        -- Rounded window corners
        rounding = 6,

        blur = {
            -- Enable blur effects
            enabled = true,

            -- Blur strength/size
            size = 6,

            -- Number of blur passes
            passes = 2,
        },

        shadow = {
            -- Enable window shadows
            enabled = false,

            -- Shadow size/range
            range = 16,

            -- Shadow rendering intensity
            render_power = 3,
        },
    },

    animations = {
        -- Enable animations globally
        enabled = true,
    },

    input = {
        -- German keyboard layout
        kb_layout = "de",

        -- Focus follows mouse movement
        follow_mouse = 1,

        touchpad = {
            -- Natural scrolling for touchpad gestures
            natural_scroll = true,
        },

        -- Mouse sensitivity (0 = default)
        sensitivity = 0,

        -- Natural scrolling for other pointing devices if supported
        natural_scroll = true,
    },

    misc = {
        -- Disable Hyprland startup logo
        disable_hyprland_logo = false,

        -- Disable default wallpaper
        force_default_wallpaper = 0,

        -- Disable Splash rendering
        disable_splash_rendering = true,
    },

    cursor = {
        -- Workaround for SEGV crash in aquamarine/DRM hardware cursor
        -- handling on Intel Arrow Lake-U (see hyprlandCrashReport2613.txt)
        no_hardware_cursors = true,
    },
})

-- Custom easing curve
hl.curve("ease", { type = "bezier", points = { {0.22, 1.0}, {0.36, 1.0} } })

-- Window open/move animation
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "ease" })

-- Window close animation
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "ease", style = "popin 80%" })

-- Border transition animation
hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "ease" })

-- Fade animation
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "ease" })

-- Workspace switching animation
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "ease" })


---------------------
---- KEYBINDINGS ----
---------------------

-- Open terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

-- Open application launcher
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

-- File manager
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("~/.local/bin/open-from-active-cwd thunar"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(fileManager .. " $HOME"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(fileManager .. " /"))

-- Yazi
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("~/.local/bin/open-from-active-cwd yazi"))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd(terminal .. " -e yazi $HOME"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(terminal .. " -e yazi /"))

-- Open web browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Open NeoVim in terminal
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(terminal .. " nvim"))

-- Close active window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Exit Hyprland session
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- Toggle fullscreen for active window
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Toggle floating mode for active window
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Lock screen
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Open power menu
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("~/.local/bin/power-menu"))

-- Open clipboard history menu
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("~/.local/bin/clipboard-menu"))

-- Open Bluetooth device menu
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.local/bin/bluetooth-menu"))

-- Reload Hyprland configuration
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Toggle split orientation in dwindle layout
hl.bind(mainMod .. " + X", hl.dsp.layout("togglesplit"))

-- Focus movement between windows
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move windows within the layout
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse bindings for moving/resizing floating windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media and brightness keys

-- Raise audio volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })

-- Lower audio volume
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })

-- Toggle audio mute
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Increase screen brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"))
hl.bind(mainMod .. " + F6",      hl.dsp.exec_cmd("brightnessctl set +10%"))

-- Decrease screen brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
hl.bind(mainMod .. " + F5",      hl.dsp.exec_cmd("brightnessctl set 10%-"))

-- Additional workspace and monitor bindings
hl.workspace_rule({ workspace = "1", monitor = "eDP-1",    default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default = true, persistent = true })

hl.bind(mainMod .. " + CTRL + left",         hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + right",        hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + SHIFT + left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + SHIFT + right",hl.dsp.workspace.move({ monitor = "r" }))

-- Screenshot keybindings
-- SUPER + COMMA  = select area
-- SUPER + PERIOD = active window
-- SUPER + MINUS  = full screen
hl.bind(mainMod .. " + COMMA",  hl.dsp.exec_cmd("~/.local/bin/polarshot area"))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd("~/.local/bin/polarshot active"))
hl.bind(mainMod .. " + MINUS",  hl.dsp.exec_cmd("~/.local/bin/polarshot full"))

-- Restore wallpaper
hl.bind(mainMod .. " + ssharp", hl.dsp.exec_cmd("pkill hyprpaper; ~/.local/bin/hyprpaper-start"))

-- Emacs opacity
hl.window_rule({
    name  = "emacs-opacity",
    match = { class = "^(emacs)$" },
    opacity = "0.80 override 0.80 override 1.0 override",
})

-- Emacs
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("emacs --no-splash"))


---------------
---- INPUT ----
---------------

hl.device({ name = "ugreen-receiver--mouse", natural_scroll = false })
hl.device({ name = "hid-1bcf:08a0-mouse",    natural_scroll = false })
