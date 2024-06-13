local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'SauceCodePro Nerd Font'
config.color_scheme = 'Tokyo Night'
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.font_size = 10.0
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"

config.default_prog = { 'wsl', '--cd', '~' }
config.window_background_opacity = 0.8

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- Send C-a when pressing C-a twice
  { key = "a", mods = "LEADER",       action = wezterm.action.SendKey { key = "a", mods = "CTRL" } },
  { key = "c", mods = "LEADER",       action = wezterm.action.ActivateCopyMode },

  -- Pane keybindings
  { key = "s", mods = "LEADER",       action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "s", mods = "ALT",       action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "Enter", mods = "ALT",       action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  -- SHIFT is for when caps lock is on
  { key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "v", mods = "ALT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "LeftArrow",  mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "DownArrow",  mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "UpArrow",    mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "RightArrow", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "LeftArrow",  mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "DownArrow",  mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "UpArrow",    mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "RightArrow", mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "h", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "h", mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "ALT",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "q", mods = "LEADER",       action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = "q", mods = "ALT",       action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = "z", mods = "LEADER",       action = wezterm.action.TogglePaneZoomState },
  { key = "\\", mods = "LEADER",       action = wezterm.action.RotatePanes "Clockwise" },
  { key = "\\", mods = "ALT",       action = wezterm.action.RotatePanes "Clockwise" },
  -- We can make separate keybindings for resizing panes
  -- But Wezterm offers custom "mode" in the name of "KeyTable"
  { key = "r", mods = "LEADER",       action = wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false } },
  { key = "r", mods = "ALT",       action = wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false } },

  -- Tab keybindings
  { key = "n", mods = "LEADER",       action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(1) },
  { key = "t", mods = "LEADER",       action = wezterm.action.ShowTabNavigator },
  -- Key table for moving tabs around
  { key = "m", mods = "LEADER",       action = wezterm.action.ActivateKeyTable { name = "move_tab", one_shot = false } },


  -- Lastly, workspace
  { key = "w", mods = "LEADER",       action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
  { key = "w", mods = "ALT",       action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1)
  })
  table.insert(config.keys, {
    key = tostring(i),
    mods = "ALT",
    action = wezterm.action.ActivateTab(i - 1)
  })
end

config.key_tables = {
  resize_pane = {
    { key = "LeftArrow",      action = wezterm.action.AdjustPaneSize { "Left", 1 } },
    { key = "DownArrow",      action = wezterm.action.AdjustPaneSize { "Down", 1 } },
    { key = "UpArrow",      action = wezterm.action.AdjustPaneSize { "Up", 1 } },
    { key = "RightArrow",      action = wezterm.action.AdjustPaneSize { "Right", 1 } },
    { key = "k",      action = wezterm.action.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = wezterm.action.AdjustPaneSize { "Down", 1 } },
    { key = "k",      action = wezterm.action.AdjustPaneSize { "Up", 1 } },
    { key = "l",      action = wezterm.action.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
  move_tab = {
    { key = "LeftArrow",      action = wezterm.action.MoveTabRelative(-1) },
    { key = "DownArrow",      action = wezterm.action.MoveTabRelative(-1) },
    { key = "UpArrow",      action = wezterm.action.MoveTabRelative(1) },
    { key = "RightArrow",      action = wezterm.action.MoveTabRelative(1) },
    { key = "h",      action = wezterm.action.MoveTabRelative(-1) },
    { key = "j",      action = wezterm.action.MoveTabRelative(-1) },
    { key = "k",      action = wezterm.action.MoveTabRelative(1) },
    { key = "l",      action = wezterm.action.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  }
}

return config
