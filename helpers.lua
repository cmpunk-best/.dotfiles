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
  config.font_size = 18
  config.window_background_opacity = 0.90
  config.window_decorations = "NONE"
  config.enable_tab_bar = false
  config.adjust_window_size_when_changing_font_size = false
  wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
  end)
  wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
  end)
  config.keys = {
    {
      key = 'h',
      mods = 'CTRL',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'b',
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
