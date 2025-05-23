-- I am helpers.lua and I should live in ~/.config/wezterm/helpers.lua

local wezterm = require 'wezterm'

-- This is the module table that we will export
local module = {}

-- This function is private to this module and is not visible
-- outside.
local function private_helper()
  wezterm.log_error 'hello!'
end

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
  private_helper()

  config.color_scheme = 'moonfly'
  config.enable_wayland = false
  config.font_size = 18
  config.window_background_opacity = 0.90
  config.window_decorations = "NONE"
  config.enable_tab_bar = false 
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false
  config.adjust_window_size_when_changing_font_size = false

--  wezterm.on('update-right-status', function(window, pane)
--    window:set_right_status(window:active_workspace())
--  end)
--  wezterm.on('update-right-status', function(window, pane)
--    window:set_right_status(window:active_workspace())
--  end)
  ------------------------------------
  ---WEZTERM SPECIFIC ISSUE 
  ------------------------------------
  local padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0.5cell',
  }

  wezterm.on('user-var-changed', function(window, pane, name, value)
    if name == "NVIM_ENTER" then
      local overrides = window:get_config_overrides() or {}
      if value == "1" then
        overrides.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0
        }
      else
        overrides.window_padding = padding
      end
      window:set_config_overrides(overrides)
    end
  end)
  ------------------------------------

  config.colors = {
    tab_bar = {
      -- Background color of the tab bar
      background = "#1c1c1c",

      -- Active tab
      active_tab = {
        bg_color = "#ffcc00",  -- Background color of active tab
        fg_color = "#000000",  -- Text color of active tab
        intensity = "Bold",    -- Text intensity
        underline = "None",
        italic = false,
        strikethrough = false,
      },

      -- Inactive tabs
      inactive_tab = {
        bg_color = "#3c3c3c",  -- Background color of inactive tabs
        fg_color = "#d3d3d3",  -- Text color of inactive tabs
      },
  }
  }
  config.keys = {
    {
      key = 'i',
      mods = 'CTRL',
      -- action = wezterm.action.SplitHorizontal {  domain = "CurrentPaneDomain" },
       action = wezterm.action_callback(function(win, pane)
        -- Split the pane horizontally
        win:perform_action(wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }, pane)
        -- Adjust the right pane size by resizing the left one
        wezterm.sleep_ms(100)  -- Small delay to ensure the pane has split
        win:perform_action(wezterm.action.AdjustPaneSize { "Right", 25}, pane)  -- Adjust size to fit your needs
      end),
    },
    {
      key = "LeftArrow",
      mods = "SHIFT",
      action = wezterm.action.AdjustPaneSize { "Left", 5 }, -- Adjust pane size by 5 cells to the left
    },
    -- Keybinding to resize the right pane (expand the right one)
    {
      key = "RightArrow",
      mods = "SHIFT",
      action = wezterm.action.AdjustPaneSize { "Right", 5 }, -- Adjust pane size by 5 cells to the right
    },
    {
      key = 'n',
      mods = 'CTRL',
      action = wezterm.action.SplitVertical{ domain = 'CurrentPaneDomain' },
    },
    {
    key = 'f',
    mods = 'CTRL',
    action = wezterm.action.ToggleFullScreen,
    },
   {
    key = 'o',
    mods = 'CTRL',
    action = wezterm.action.ActivateLastTab,
   },
   {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  { key = 'k', mods = 'CTRL', action = wezterm.action.SwitchToWorkspace },
  { key = 'j', mods = 'CTRL', action = wezterm.action.SwitchWorkspaceRelative(1) },
  { key = 'p', mods = 'CTRL', action = wezterm.action.SwitchWorkspaceRelative(-1) },
  { key = 'r', mods = 'CTRL', action = wezterm.action.RotatePanes 'Clockwise' },
  {
    key = 'q',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  { key = 't', mods = 'CTRL', action = wezterm.action.ShowTabNavigator },
}
end

return module
