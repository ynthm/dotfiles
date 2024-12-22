local wezterm = require 'wezterm'

-- This will hold the configuration.
local c = {}
if wezterm.config_builder then
    c = wezterm.config_builder()
end

-- 初始大小
c.initial_cols = 96
c.initial_rows = 30

-- 关闭时不进行确认  设置后 后面的 confirm = true 无效  AlwaysPrompt/NeverPrompt
c.window_close_confirmation = 'NeverPrompt'
-- c.hide_tab_bar_if_only_one_tab = true

-- 字体
-- c.font = wezterm.font 'CaskaydiaCove Nerd Font'

c.font = wezterm.font_with_fallback({{
    family = "CaskaydiaCove Nerd Font",
    weight = "Bold"
}, {
    family = "PingFang SC",
    weight = "Regular"
}, "Noto Color Emoji"})

c.font_size = 16
-- 配色
local materia = wezterm.color.get_builtin_schemes()['Material Darker (base16)']
-- materia.scrollbar_thumb = '#cccccc' -- 更明显的滚动条
c.colors = materia

-- 透明背景
c.window_background_opacity = 0.96

-- c.window_background_image = '/Users/ynthm/Images/yande.re.1178225-an_yasuri-tsukatsuki_rio.png'
c.window_background_image = '/Users/ynthm/.dotfiles/config/image/bg-01.jpg'

c.window_background_image_hsb = {
    -- Darken the background image by reducing it to 1/3rd
    brightness = 0.08,

    -- You can adjust the hue by scaling its value.
    -- a multiplier of 1.0 leaves the value unchanged.
    hue = 1.0,

    -- You can adjust the saturation also.
    saturation = 1.0
}

-- 取消 Windows 原生标题栏
c.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- 滚动条尺寸为 15 ，其他方向不需要 pad
c.window_padding = {
    left = 0,
    right = 24,
    top = 0,
    bottom = 0
}
-- 启用滚动条
c.enable_scroll_bar = true

-- 默认启动 PowerShell
c.default_prog = {'zsh'}

-- 启动菜单的一些启动项
c.launch_menu = {{
    label = 'router.1',
    args = {'ssh', 'root@10.0.0.1'}
}, {
    label = 'nas / ssh',
    args = {'ssh', 'nas'}
}}

-- 取消所有默认的热键
-- c.disable_default_key_bindings = true
local act = wezterm.action
-- timeout_milliseconds defaults to 1000 and can be omitted
c.leader = {
    key = 'a',
    mods = 'CTRL',
    timeout_milliseconds = 1000
}
c.keys = {{
    -- Ctrl+Shift+Tab 遍历 tab
    key = 'Tab',
    mods = 'SHIFT|CTRL',
    action = act.ActivateTabRelative(1)
}, {
    -- F11 切换全屏
    key = 'F11',
    mods = 'NONE',
    action = act.ToggleFullScreen
}, {
    -- Ctrl+Shift++ 字体增大
    key = '+',
    mods = 'SHIFT|CTRL',
    action = act.IncreaseFontSize
}, {
    -- Ctrl+Shift+- 字体减小
    key = '_',
    mods = 'SHIFT|CTRL',
    action = act.DecreaseFontSize
}, {
    -- Ctrl+Shift+C 复制选中区域
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
        selection_text = window:get_selection_text_for_pane(pane)
        is_selection_active = string.len(selection_text) ~= 0
        if is_selection_active then
            window:perform_action(wezterm.action.CopyTo('ClipboardAndPrimarySelection'), pane)
        else
            window:perform_action(wezterm.action.SendKey {
                key = 'c',
                mods = 'CTRL'
            }, pane)
        end
    end)
}, -- Ctrl+Shift+V 粘贴剪切板的内容
{
    key = 'V',
    mods = 'SHIFT|CTRL',
    action = act.PasteFrom 'Clipboard'
}, -- Ctrl+Shift+N 新窗口
{
    key = 'N',
    mods = 'SHIFT|CTRL',
    action = act.SpawnWindow
}, {
    -- Ctrl+Shift+T 显示启动菜单 (替换默认)
    key = 'T',
    mods = 'SHIFT|CTRL',
    action = act.ShowLauncher
}, {
    -- Ctrl+Shift+T 新 tab (默认功能改键)
    key = 't',
    mods = 'CTRL',
    action = act {
        SpawnTab = "CurrentPaneDomain"
    }
}, -- Ctrl+Shift+Enter 显示启动菜单
{
    key = 'Enter',
    mods = 'SHIFT|CTRL',
    action = act.ShowLauncherArgs {
        flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS'
    }
}, {
    key = "w",
    mods = "CTRL",
    action = {
        CloseCurrentPane = {
            confirm = true
        }
    }
}, {
    -- Ctrl+Shift+W 关闭 tab 且不进行确认
    key = 'W',
    mods = 'SHIFT|CTRL',
    action = act.CloseCurrentTab {
        confirm = true
    }
}, {
    -- Ctrl+Shift+UpArrow 向上滚动一行
    key = 'PageUp',
    mods = 'SHIFT|CTRL',
    action = act.ScrollByLine(-3)
}, {
    -- Ctrl+Shift+DownArrow 向下滚动一行
    key = 'PageDown',
    mods = 'SHIFT|CTRL',
    action = act.ScrollByLine(3)
}, {
    -- CTRL+a 1s 内接 \ 竖向分屏 exit 退出
    key = '\\',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain'
    }
}, {
    -- CTRL+a 1s 内接 SHIFT+| 竖向分屏 exit 退出
    key = '|',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain'
    }
}, {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain'
    }
}, -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
{
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey {
        key = 'a',
        mods = 'CTRL'
    }
}, {
    key = "h",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Left")
}, {
    key = "l",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Right")
}, {
    key = "k",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Up")
}, {
    key = "j",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Down")
}}
-- 鼠标左键选中复制，右键单击时，执行粘贴操作
c.mouse_bindings = {{
    event = {
        Down = {
            streak = 1,
            button = "Right"
        }
    },
    action = wezterm.action {
        PasteFrom = "Clipboard"
    }
}}

return c
