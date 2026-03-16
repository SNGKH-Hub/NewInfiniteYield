--[[
╔══════════════════════════════════════════════════════════╗
║              NexusUI v2.0 — Full Executor UI Library     ║
║  Self-contained • No dependencies • LocalScript ready    ║
╠══════════════════════════════════════════════════════════╣
║  QUICK START:                                            ║
║    local UI = loadstring(game:HttpGet("..."))()          ║
║    local Win = UI:CreateWindow({...})                    ║
║    local Tab = Win:CreateTab({...})                      ║
║    Tab:CreateButton({...})                               ║
╚══════════════════════════════════════════════════════════╝

  ELEMENTS:
    :CreateSection(name)
    :CreateSeparator()
    :CreateLabel(cfg)           → { SetText }
    :CreateButton(cfg)          → { SetText, SetEnabled }
    :CreateToggle(cfg)          → { SetState, GetState }
    :CreateSlider(cfg)          → { SetValue, GetValue }
    :CreateInput(cfg)           → { SetValue, GetValue, Focus }
    :CreateDropdown(cfg)        → { GetSelected, SetSelected, SetOptions }
    :CreateMultiDropdown(cfg)   → { GetSelected, SetSelected, SetOptions }
    :CreateColorPicker(cfg)     → { GetColor, SetColor }
    :CreateKeybind(cfg)         → { GetKey, SetKey }

  WINDOW METHODS:
    Win:SetTheme(themeName)     -- "Dark","Light","Midnight","Ocean","Rose"
    Win:Notify(cfg)             -- { Title, Message, Duration, Type }
    Win:Destroy()
    Win:SetKeybind(key)         -- default RightShift to toggle

  THEMES: Dark, Light, Midnight, Ocean, Rose
]]

-- ═══════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════
local Players           = game:GetService("Players")
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local TextService       = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════
-- THEMES
-- ═══════════════════════════════════════════════════════════
local Themes = {
    Dark = {
        Background    = Color3.fromRGB(13,  13,  18 ),
        Surface       = Color3.fromRGB(20,  20,  28 ),
        SurfaceLight  = Color3.fromRGB(28,  28,  40 ),
        SurfaceHover  = Color3.fromRGB(33,  33,  48 ),
        Border        = Color3.fromRGB(45,  45,  65 ),
        Accent        = Color3.fromRGB(99,  102, 241),
        AccentHover   = Color3.fromRGB(129, 132, 255),
        AccentDim     = Color3.fromRGB(40,  42,  100),
        Success       = Color3.fromRGB(52,  211, 153),
        Warning       = Color3.fromRGB(251, 191, 36 ),
        Danger        = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96,  165, 250),
        TextPrimary   = Color3.fromRGB(240, 240, 255),
        TextSecondary = Color3.fromRGB(140, 140, 175),
        TextMuted     = Color3.fromRGB(80,  80,  110),
        Scrollbar     = Color3.fromRGB(50,  50,  72 ),
        TitlebarBg    = Color3.fromRGB(20,  20,  28 ),
        ShadowColor   = Color3.fromRGB(0,   0,   0  ),
        ToggleOn      = Color3.fromRGB(99,  102, 241),
        ToggleOff     = Color3.fromRGB(45,  45,  65 ),
    },
    Midnight = {
        Background    = Color3.fromRGB(8,   8,   20 ),
        Surface       = Color3.fromRGB(14,  14,  32 ),
        SurfaceLight  = Color3.fromRGB(22,  22,  44 ),
        SurfaceHover  = Color3.fromRGB(28,  28,  55 ),
        Border        = Color3.fromRGB(40,  40,  80 ),
        Accent        = Color3.fromRGB(138, 43,  226),
        AccentHover   = Color3.fromRGB(168, 90,  255),
        AccentDim     = Color3.fromRGB(55,  15,  90 ),
        Success       = Color3.fromRGB(52,  211, 153),
        Warning       = Color3.fromRGB(251, 191, 36 ),
        Danger        = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96,  165, 250),
        TextPrimary   = Color3.fromRGB(230, 220, 255),
        TextSecondary = Color3.fromRGB(150, 130, 200),
        TextMuted     = Color3.fromRGB(80,  70,  120),
        Scrollbar     = Color3.fromRGB(45,  40,  80 ),
        TitlebarBg    = Color3.fromRGB(14,  14,  32 ),
        ShadowColor   = Color3.fromRGB(0,   0,   10 ),
        ToggleOn      = Color3.fromRGB(138, 43,  226),
        ToggleOff     = Color3.fromRGB(40,  40,  80 ),
    },
    Ocean = {
        Background    = Color3.fromRGB(8,   20,  32 ),
        Surface       = Color3.fromRGB(12,  28,  45 ),
        SurfaceLight  = Color3.fromRGB(18,  38,  60 ),
        SurfaceHover  = Color3.fromRGB(22,  46,  72 ),
        Border        = Color3.fromRGB(30,  60,  90 ),
        Accent        = Color3.fromRGB(6,   182, 212),
        AccentHover   = Color3.fromRGB(50,  215, 240),
        AccentDim     = Color3.fromRGB(10,  60,  80 ),
        Success       = Color3.fromRGB(52,  211, 153),
        Warning       = Color3.fromRGB(251, 191, 36 ),
        Danger        = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96,  165, 250),
        TextPrimary   = Color3.fromRGB(220, 245, 255),
        TextSecondary = Color3.fromRGB(120, 180, 210),
        TextMuted     = Color3.fromRGB(60,  110, 140),
        Scrollbar     = Color3.fromRGB(25,  60,  85 ),
        TitlebarBg    = Color3.fromRGB(12,  28,  45 ),
        ShadowColor   = Color3.fromRGB(0,   8,   20 ),
        ToggleOn      = Color3.fromRGB(6,   182, 212),
        ToggleOff     = Color3.fromRGB(30,  60,  90 ),
    },
    Rose = {
        Background    = Color3.fromRGB(20,  10,  15 ),
        Surface       = Color3.fromRGB(30,  15,  22 ),
        SurfaceLight  = Color3.fromRGB(42,  20,  32 ),
        SurfaceHover  = Color3.fromRGB(50,  25,  38 ),
        Border        = Color3.fromRGB(70,  35,  55 ),
        Accent        = Color3.fromRGB(244, 63,  94 ),
        AccentHover   = Color3.fromRGB(255, 100, 125),
        AccentDim     = Color3.fromRGB(90,  20,  35 ),
        Success       = Color3.fromRGB(52,  211, 153),
        Warning       = Color3.fromRGB(251, 191, 36 ),
        Danger        = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96,  165, 250),
        TextPrimary   = Color3.fromRGB(255, 230, 235),
        TextSecondary = Color3.fromRGB(190, 130, 150),
        TextMuted     = Color3.fromRGB(110, 65,  80 ),
        Scrollbar     = Color3.fromRGB(65,  30,  45 ),
        TitlebarBg    = Color3.fromRGB(30,  15,  22 ),
        ShadowColor   = Color3.fromRGB(10,  0,   5  ),
        ToggleOn      = Color3.fromRGB(244, 63,  94 ),
        ToggleOff     = Color3.fromRGB(70,  35,  55 ),
    },
    Light = {
        Background    = Color3.fromRGB(248, 248, 252),
        Surface       = Color3.fromRGB(255, 255, 255),
        SurfaceLight  = Color3.fromRGB(240, 240, 248),
        SurfaceHover  = Color3.fromRGB(232, 232, 245),
        Border        = Color3.fromRGB(210, 210, 230),
        Accent        = Color3.fromRGB(99,  102, 241),
        AccentHover   = Color3.fromRGB(79,  82,  220),
        AccentDim     = Color3.fromRGB(220, 221, 255),
        Success       = Color3.fromRGB(16,  185, 129),
        Warning       = Color3.fromRGB(245, 158, 11 ),
        Danger        = Color3.fromRGB(220, 38,  38 ),
        Info          = Color3.fromRGB(59,  130, 246),
        TextPrimary   = Color3.fromRGB(15,  15,  30 ),
        TextSecondary = Color3.fromRGB(80,  80,  120),
        TextMuted     = Color3.fromRGB(160, 160, 190),
        Scrollbar     = Color3.fromRGB(190, 190, 215),
        TitlebarBg    = Color3.fromRGB(255, 255, 255),
        ShadowColor   = Color3.fromRGB(150, 150, 180),
        ToggleOn      = Color3.fromRGB(99,  102, 241),
        ToggleOff     = Color3.fromRGB(210, 210, 230),
    },
}

-- Active theme (default Dark)
local T = Themes.Dark

-- ═══════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════
local function Tween(obj, props, t, style, dir)
    if not obj or not obj.Parent then return end
    TweenService:Create(obj, TweenInfo.new(
        t or 0.18,
        style or Enum.EasingStyle.Quart,
        dir or Enum.EasingDirection.Out
    ), props):Play()
end

local function New(class, props)
    local ok, inst = pcall(Instance.new, class)
    if not ok then return nil end
    for k, v in pairs(props or {}) do
        local s, e = pcall(function() inst[k] = v end)
        if not s then warn("[NexusUI] Property error: "..k.." = "..tostring(v).."\n"..tostring(e)) end
    end
    return inst
end

local function Corner(parent, radius)
    local c = New("UICorner", { CornerRadius = UDim.new(0, radius or 8) })
    c.Parent = parent
    return c
end

local function Stroke(parent, thickness, color)
    local s = New("UIStroke", {
        Thickness = thickness or 1,
        Color = color or T.Border,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })
    s.Parent = parent
    return s
end

local function Pad(parent, top, right, bottom, left)
    local p = New("UIPadding", {
        PaddingTop    = UDim.new(0, top    or 0),
        PaddingRight  = UDim.new(0, right  or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft   = UDim.new(0, left   or 0),
    })
    p.Parent = parent
    return p
end

local function ListLayout(parent, padding, align)
    local l = New("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, padding or 0),
        HorizontalAlignment = align or Enum.HorizontalAlignment.Left,
    })
    l.Parent = parent
    return l
end

local function AutoCanvas(scroll, padding)
    padding = padding or 0
    scroll.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0,0,0, scroll.UIListLayout.AbsoluteContentSize.Y + padding)
    end)
end

local function Frame(props)
    local f = New("Frame", props)
    return f
end

local function RFrame(props, radius)
    local f = New("Frame", props)
    Corner(f, radius or 8)
    return f
end

local function Btn(props)
    local b = New("TextButton", props)
    return b
end

local function Lbl(props)
    local l = New("TextLabel", props)
    return l
end

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragStart, startPos
    handle = handle or frame

    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = i.Position
            startPos  = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if dragging and (
            i.UserInputType == Enum.UserInputType.MouseMovement or
            i.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = i.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Clamp window inside screen
local function ClampToScreen(frame)
    RunService.Heartbeat:Connect(function()
        local vp = workspace.CurrentCamera.ViewportSize
        local pos = frame.AbsolutePosition
        local siz = frame.AbsoluteSize
        local x = math.clamp(pos.X, 0, vp.X - siz.X)
        local y = math.clamp(pos.Y, 0, vp.Y - siz.Y)
        if x ~= pos.X or y ~= pos.Y then
            frame.Position = UDim2.new(0, x, 0, y)
        end
    end)
end

-- HSV → Color3
local function HSVtoRGB(h, s, v)
    return Color3.fromHSV(h, s, v)
end

-- Color3 → hex string
local function ToHex(c)
    return string.format("%02X%02X%02X",
        math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
end

-- ═══════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════
local NotifContainer -- set after ScreenGui creation

local function SpawnNotif(cfg, theme)
    if not NotifContainer then return end
    cfg = cfg or {}
    local title    = cfg.Title    or "Notification"
    local msg      = cfg.Message  or ""
    local duration = cfg.Duration or 3.5
    local ntype    = cfg.Type     or "info" -- info | success | warning | danger

    local typeColors = {
        info    = theme.Info,
        success = theme.Success,
        warning = theme.Warning,
        danger  = theme.Danger,
    }
    local accent = typeColors[ntype] or theme.Info

    local icons = { info = "ℹ", success = "✓", warning = "⚠", danger = "✕" }

    local card = RFrame({
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundColor3 = theme.Surface,
        ClipsDescendants = true,
        Parent = NotifContainer,
    }, 8)
    Stroke(card, 1, accent)

    -- Left color bar
    Frame({
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Parent = card,
    })

    -- Icon
    Lbl({
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 14, 0.5, -16),
        BackgroundColor3 = accent,
        BackgroundTransparency = 0.85,
        Text = icons[ntype] or "ℹ",
        TextColor3 = accent,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = card,
    })
    Corner(card:FindFirstChildOfClass("TextLabel") or New("Frame"), 6)

    Lbl({
        Size = UDim2.new(1, -60, 0, 18),
        Position = UDim2.new(0, 52, 0, 10),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = theme.TextPrimary,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = card,
    })
    Lbl({
        Size = UDim2.new(1, -60, 0, 28),
        Position = UDim2.new(0, 52, 0, 30),
        BackgroundTransparency = 1,
        Text = msg,
        TextColor3 = theme.TextSecondary,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = card,
    })

    -- Progress bar
    local progBg = Frame({
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = theme.Border,
        BorderSizePixel = 0,
        Parent = card,
    })
    local prog = Frame({
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Parent = progBg,
    })

    -- Slide in
    card.Position = UDim2.new(1, 10, 0, 0)
    Tween(card, { Position = UDim2.new(0, 0, 0, 0) }, 0.3, Enum.EasingStyle.Back)

    -- Progress drain
    Tween(prog, { Size = UDim2.new(0, 0, 1, 0) }, duration, Enum.EasingStyle.Linear)

    -- Auto destroy
    task.delay(duration, function()
        Tween(card, { Position = UDim2.new(1, 10, 0, 0) }, 0.25)
        task.delay(0.3, function()
            if card and card.Parent then card:Destroy() end
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════
-- MAIN LIBRARY
-- ═══════════════════════════════════════════════════════════
local NexusUI = {}
NexusUI.__index = NexusUI

function NexusUI:CreateWindow(config)
    config = config or {}
    local title      = config.Title      or "NexusUI"
    local subtitle   = config.Subtitle   or "v2.0"
    local size       = config.Size       or UDim2.new(0, 580, 0, 440)
    local pos        = config.Position   or UDim2.new(0.5, -290, 0.5, -220)
    local themeName  = config.Theme      or "Dark"
    local toggleKey  = config.ToggleKey  or Enum.KeyCode.RightShift

    -- Apply theme
    T = Themes[themeName] or Themes.Dark

    -- Destroy any existing instance
    local existing = PlayerGui:FindFirstChild("NexusUI_v2")
    if existing then existing:Destroy() end

    -- ── ScreenGui ───────────────────────────────────────────
    local screenGui = New("ScreenGui", {
        Name = "NexusUI_v2",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
        Parent = PlayerGui,
    })

    -- Notification container (top-right)
    NotifContainer = Frame({
        Name = "NotifContainer",
        Size = UDim2.new(0, 280, 1, 0),
        Position = UDim2.new(1, -295, 0, 20),
        BackgroundTransparency = 1,
        ZIndex = 200,
        Parent = screenGui,
    })
    ListLayout(NotifContainer, 8)
    Pad(NotifContainer, 8, 0, 8, 0)

    -- ── Root CanvasGroup (for fade) ─────────────────────────
    local root = New("CanvasGroup", {
        Name = "Root",
        Size = size,
        Position = pos,
        BackgroundTransparency = 1,
        ZIndex = 10,
        Parent = screenGui,
    })

    -- Drop shadow
    local shadow = RFrame({
        Size = UDim2.new(1, 30, 1, 30),
        Position = UDim2.new(0, -15, 0, -15),
        BackgroundColor3 = T.ShadowColor,
        BackgroundTransparency = 0.55,
        ZIndex = 1,
        Parent = root,
    }, 16)

    -- Main container
    local main = RFrame({
        Name = "Main",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = T.Background,
        ZIndex = 2,
        Parent = root,
    }, 10)
    local mainStroke = Stroke(main, 1, T.Border)

    -- ── Titlebar ────────────────────────────────────────────
    local titlebar = RFrame({
        Name = "Titlebar",
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = T.TitlebarBg,
        ZIndex = 5,
        Parent = main,
    }, 10)
    -- fill bottom corners
    Frame({
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = T.TitlebarBg,
        BorderSizePixel = 0,
        ZIndex = 5,
        Parent = titlebar,
    })
    -- bottom border line
    Frame({
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = T.Border,
        BorderSizePixel = 0,
        ZIndex = 6,
        Parent = titlebar,
    })

    -- Accent pill
    local pill = RFrame({
        Size = UDim2.new(0, 4, 0, 26),
        Position = UDim2.new(0, 14, 0.5, -13),
        BackgroundColor3 = T.Accent,
        ZIndex = 6,
        Parent = titlebar,
    }, 3)

    local titleLbl = Lbl({
        Size = UDim2.new(0, 260, 0, 22),
        Position = UDim2.new(0, 26, 0, 6),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = T.TextPrimary,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        Parent = titlebar,
    })
    local subtitleLbl = Lbl({
        Size = UDim2.new(0, 260, 0, 14),
        Position = UDim2.new(0, 26, 0, 30),
        BackgroundTransparency = 1,
        Text = subtitle,
        TextColor3 = T.TextMuted,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        Parent = titlebar,
    })

    -- Minimise + Close buttons
    local function MakeTitleBtn(offsetX, bg, hoverBg, symbol, symbolColor)
        local f = RFrame({
            Size = UDim2.new(0, 26, 0, 26),
            Position = UDim2.new(1, offsetX, 0.5, -13),
            BackgroundColor3 = bg,
            ZIndex = 7,
            Parent = titlebar,
        }, 6)
        local lbl = Lbl({
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Text = symbol,
            TextColor3 = symbolColor,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            ZIndex = 8,
            Parent = f,
        })
        local zone = Btn({
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 9,
            Parent = f,
        })
        zone.MouseEnter:Connect(function() Tween(f, {BackgroundColor3=hoverBg}, 0.12) end)
        zone.MouseLeave:Connect(function() Tween(f, {BackgroundColor3=bg}, 0.12) end)
        return zone, f, lbl
    end

    local closeZone = MakeTitleBtn(-14, Color3.fromRGB(50,25,25), T.Danger, "✕", T.Danger)
    local minZone, minFrame, minLbl = MakeTitleBtn(-46, T.SurfaceLight, T.Border, "─", T.TextSecondary)

    -- Minimise logic
    local minimised = false
    local fullSize  = size
    minZone.MouseButton1Click:Connect(function()
        minimised = not minimised
        if minimised then
            Tween(root, { Size = UDim2.new(0, fullSize.X.Offset, 0, 50) }, 0.22, Enum.EasingStyle.Quart)
            minLbl.Text = "□"
        else
            Tween(root, { Size = fullSize }, 0.22, Enum.EasingStyle.Quart)
            minLbl.Text = "─"
        end
    end)

    -- ── Sidebar ─────────────────────────────────────────────
    local sidebar = Frame({
        Name = "Sidebar",
        Size = UDim2.new(0, 148, 1, -50),
        Position = UDim2.new(0, 0, 0, 50),
        BackgroundColor3 = T.Surface,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 4,
        Parent = main,
    })
    -- separator
    Frame({
        Size = UDim2.new(0, 1, 1, -50),
        Position = UDim2.new(0, 148, 0, 50),
        BackgroundColor3 = T.Border,
        BorderSizePixel = 0,
        ZIndex = 4,
        Parent = main,
    })

    local sideList = Frame({
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = 4,
        Parent = sidebar,
    })
    ListLayout(sideList, 3)
    Pad(sideList, 10, 8, 10, 8)

    -- Content area
    local contentArea = Frame({
        Name = "ContentArea",
        Size = UDim2.new(1, -149, 1, -50),
        Position = UDim2.new(0, 149, 0, 50),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 4,
        Parent = main,
    })

    -- Draggable + clamped
    MakeDraggable(root, titlebar)
    ClampToScreen(root)

    -- Intro animation
    root.GroupTransparency = 1
    root.Position = UDim2.new(pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset + 16)
    task.defer(function()
        Tween(root, {GroupTransparency = 0, Position = pos}, 0.3, Enum.EasingStyle.Quart)
    end)

    -- ── Toggle Button ────────────────────────────────────────
    local toggleBtn = RFrame({
        Name = "ToggleBtn",
        Size = UDim2.new(0, 130, 0, 34),
        Position = UDim2.new(0, 16, 1, -50),
        BackgroundColor3 = T.Surface,
        ZIndex = 100,
        Parent = screenGui,
    }, 17)
    Stroke(toggleBtn, 1, T.Border)

    local tbDot = RFrame({
        Size = UDim2.new(0, 8, 0, 8),
        Position = UDim2.new(0, 13, 0.5, -4),
        BackgroundColor3 = T.Accent,
        ZIndex = 101,
        Parent = toggleBtn,
    }, 4)

    local tbLabel = Lbl({
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Text = "Toggle UI",
        TextColor3 = T.TextPrimary,
        TextSize = 12,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
        Parent = toggleBtn,
    })

    local tbKey = Lbl({
        Size = UDim2.new(0, 40, 0, 16),
        Position = UDim2.new(1, -44, 0.5, -8),
        BackgroundColor3 = T.SurfaceLight,
        BackgroundTransparency = 0,
        Text = toggleKey.Name:sub(1,5),
        TextColor3 = T.TextMuted,
        TextSize = 9,
        Font = Enum.Font.GothamBold,
        ZIndex = 102,
        Parent = toggleBtn,
    })
    Corner(tbKey, 4)

    local tbZone = Btn({
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 103,
        Parent = toggleBtn,
    })
    tbZone.MouseEnter:Connect(function() Tween(toggleBtn, {BackgroundColor3=T.SurfaceLight}, 0.12) end)
    tbZone.MouseLeave:Connect(function() Tween(toggleBtn, {BackgroundColor3=T.Surface}, 0.12) end)

    local guiVisible = true
    local function SetVisible(val)
        guiVisible = val
        if val then
            root.Visible = true
            Tween(root, {GroupTransparency = 0}, 0.2)
            Tween(tbDot, {BackgroundColor3 = T.Accent}, 0.2)
        else
            Tween(root, {GroupTransparency = 1}, 0.15)
            task.delay(0.16, function() root.Visible = false end)
            Tween(tbDot, {BackgroundColor3 = T.TextMuted}, 0.2)
        end
    end

    tbZone.MouseButton1Click:Connect(function() SetVisible(not guiVisible) end)

    -- Keyboard toggle
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == toggleKey then
            SetVisible(not guiVisible)
        end
    end)

    -- Close
    closeZone.MouseButton1Click:Connect(function()
        Tween(root, {GroupTransparency = 1}, 0.15)
        task.delay(0.2, function() screenGui:Destroy() end)
    end)

    -- ── Window Object ────────────────────────────────────────
    local Window = {
        _screenGui   = screenGui,
        _root        = root,
        _tabs        = {},
        _activeTab   = nil,
        _theme       = T,
        _toggleKey   = toggleKey,
    }

    -- ── Notify ───────────────────────────────────────────────
    function Window:Notify(cfg)
        SpawnNotif(cfg, self._theme)
    end

    -- ── Destroy ──────────────────────────────────────────────
    function Window:Destroy()
        Tween(root, {GroupTransparency = 1}, 0.15)
        task.delay(0.2, function()
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
            end
        end)
    end

    -- ── SetKeybind ───────────────────────────────────────────
    function Window:SetKeybind(key)
        self._toggleKey = key
        tbKey.Text = key.Name:sub(1,5)
    end

    -- ── SetTheme ─────────────────────────────────────────────
    function Window:SetTheme(name)
        local theme = Themes[name]
        if not theme then warn("[NexusUI] Unknown theme: "..tostring(name)) return end
        T = theme
        self._theme = theme
        -- Update root visuals
        main.BackgroundColor3          = theme.Background
        titlebar.BackgroundColor3      = theme.TitlebarBg
        titlebar:FindFirstChildOfClass("Frame").BackgroundColor3 = theme.TitlebarBg
        mainStroke.Color               = theme.Border
        sidebar.BackgroundColor3       = theme.Surface
        pill.BackgroundColor3          = theme.Accent
        titleLbl.TextColor3            = theme.TextPrimary
        subtitleLbl.TextColor3         = theme.TextMuted
        shadow.BackgroundColor3        = theme.ShadowColor
        toggleBtn.BackgroundColor3     = theme.Surface
        tbDot.BackgroundColor3         = theme.Accent
        tbLabel.TextColor3             = theme.TextPrimary
        -- Notify success
        self:Notify({Title="Theme Changed", Message=name.." theme applied.", Type="success", Duration=2})
    end

    -- ── Internal Tab Selector ────────────────────────────────
    function Window:_SelectTab(tab)
        if self._activeTab == tab then return end
        if self._activeTab then
            local old = self._activeTab
            old._page.Visible = false
            Tween(old._tabBtn, {BackgroundColor3=T.Surface, BackgroundTransparency=1}, 0.15)
            Tween(old._tabLbl, {TextColor3=T.TextMuted}, 0.15)
            Tween(old._indicator, {BackgroundTransparency=1}, 0.15)
        end
        self._activeTab = tab
        tab._page.Visible = true
        Tween(tab._tabBtn, {BackgroundColor3=T.AccentDim, BackgroundTransparency=0}, 0.15)
        Tween(tab._tabLbl, {TextColor3=T.TextPrimary}, 0.15)
        Tween(tab._indicator, {BackgroundTransparency=0, BackgroundColor3=T.Accent}, 0.15)
    end

    -- ════════════════════════════════════════════════════════
    -- CREATE TAB
    -- ════════════════════════════════════════════════════════
    function Window:CreateTab(cfg)
        cfg = cfg or {}
        local name = cfg.Name or "Tab"
        local icon = cfg.Icon or ""

        -- Sidebar button
        local tabBtn = RFrame({
            Name = "TabBtn_"..name,
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = T.Surface,
            BackgroundTransparency = 1,
            ZIndex = 5,
            Parent = sideList,
        }, 7)

        local indicator = Frame({
            Size = UDim2.new(0, 3, 0, 18),
            Position = UDim2.new(0, 0, 0.5, -9),
            BackgroundColor3 = T.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 6,
            Parent = tabBtn,
        })
        Corner(indicator, 2)

        local iconLbl = Lbl({
            Size = UDim2.new(0, 20, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1,
            Text = icon,
            TextColor3 = T.TextMuted,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            ZIndex = 6,
            Parent = tabBtn,
        })

        local tabLbl = Lbl({
            Size = UDim2.new(1, -36, 1, 0),
            Position = UDim2.new(0, (icon ~= "" and 34 or 14), 0, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = T.TextMuted,
            TextSize = 12,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 6,
            Parent = tabBtn,
        })

        -- Content page
        local page = New("ScrollingFrame", {
            Name = "Page_"..name,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = T.Scrollbar,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0,0,0,0),
            Visible = false,
            ZIndex = 5,
            Parent = contentArea,
        })
        ListLayout(page, 7)
        Pad(page, 12, 14, 12, 14)
        AutoCanvas(page, 24)

        -- Click zone
        local zone = Btn({
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 7,
            Parent = tabBtn,
        })
        zone.MouseEnter:Connect(function()
            if self._activeTab ~= Tab then
                Tween(tabBtn, {BackgroundTransparency=0.7, BackgroundColor3=T.SurfaceHover}, 0.12)
                Tween(tabLbl, {TextColor3=T.TextSecondary}, 0.12)
            end
        end)
        zone.MouseLeave:Connect(function()
            if self._activeTab ~= Tab then
                Tween(tabBtn, {BackgroundTransparency=1}, 0.12)
                Tween(tabLbl, {TextColor3=T.TextMuted}, 0.12)
            end
        end)
        zone.MouseButton1Click:Connect(function()
            self:_SelectTab(Tab)
        end)

        -- Tab object
        local Tab = {
            _page      = page,
            _tabBtn    = tabBtn,
            _tabLbl    = tabLbl,
            _indicator = indicator,
            _iconLbl   = iconLbl,
            _elemCount = 0,
            _window    = self,
        }

        table.insert(self._tabs, Tab)
        if #self._tabs == 1 then self:_SelectTab(Tab) end

        -- ── Helper: element container ─────────────────────────
        local function Elem(h)
            Tab._elemCount += 1
            local f = RFrame({
                Name = "Elem_"..Tab._elemCount,
                Size = UDim2.new(1, 0, 0, h),
                BackgroundColor3 = T.SurfaceLight,
                ZIndex = 6,
                LayoutOrder = Tab._elemCount,
                Parent = page,
            }, 7)
            Stroke(f, 1, T.Border)
            return f
        end

        -- ── SECTION ──────────────────────────────────────────
        function Tab:CreateSection(name)
            Tab._elemCount += 1
            local row = Frame({
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                LayoutOrder = Tab._elemCount,
                Parent = page,
            })
            Lbl({
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = string.upper(name or "SECTION"),
                TextColor3 = T.Accent,
                TextSize = 9,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                LetterSpacing = 2,
                Parent = row,
            })
            Frame({
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -1),
                BackgroundColor3 = T.Border,
                BorderSizePixel = 0,
                Parent = row,
            })
            return row
        end

        -- ── SEPARATOR ─────────────────────────────────────────
        function Tab:CreateSeparator()
            Tab._elemCount += 1
            local f = Frame({
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = T.Border,
                BorderSizePixel = 0,
                LayoutOrder = Tab._elemCount,
                Parent = page,
            })
            return f
        end

        -- ── LABEL ─────────────────────────────────────────────
        function Tab:CreateLabel(cfg)
            cfg = cfg or {}
            Tab._elemCount += 1
            local f = RFrame({
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = T.SurfaceLight,
                LayoutOrder = Tab._elemCount,
                ZIndex = 6,
                Parent = page,
            }, 7)
            Stroke(f, 1, T.Border)
            local lbl = Lbl({
                Size = UDim2.new(1, -28, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Text or "Label",
                TextColor3 = cfg.Color or T.TextSecondary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                ZIndex = 7,
                Parent = f,
            })
            return {
                SetText  = function(_, t) lbl.Text = tostring(t) end,
                SetColor = function(_, c) lbl.TextColor3 = c end,
            }
        end

        -- ── BUTTON ────────────────────────────────────────────
        function Tab:CreateButton(cfg)
            cfg = cfg or {}
            local f = Elem(42)
            local enabled = cfg.Enabled ~= false

            local nameLbl = Lbl({
                Size = UDim2.new(1, -100, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Button",
                TextColor3 = enabled and T.TextPrimary or T.TextMuted,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local btnFrame = RFrame({
                Size = UDim2.new(0, 72, 0, 26),
                Position = UDim2.new(1, -86, 0.5, -13),
                BackgroundColor3 = enabled and T.AccentDim or T.SurfaceLight,
                ZIndex = 7,
                Parent = f,
            }, 6)

            local btnLbl = Lbl({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = cfg.ButtonText or "Run",
                TextColor3 = enabled and T.Accent or T.TextMuted,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                ZIndex = 8,
                Parent = btnFrame,
            })

            local zone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 9,
                Parent = f,
            })

            zone.MouseEnter:Connect(function()
                if enabled then Tween(f, {BackgroundColor3=T.SurfaceHover}, 0.12) end
            end)
            zone.MouseLeave:Connect(function()
                if enabled then Tween(f, {BackgroundColor3=T.SurfaceLight}, 0.12) end
            end)
            zone.MouseButton1Down:Connect(function()
                if enabled then
                    Tween(btnFrame, {BackgroundColor3=T.Accent}, 0.08)
                    Tween(btnLbl, {TextColor3=Color3.new(1,1,1)}, 0.08)
                end
            end)
            zone.MouseButton1Up:Connect(function()
                if enabled then
                    Tween(btnFrame, {BackgroundColor3=T.AccentDim}, 0.2)
                    Tween(btnLbl, {TextColor3=T.Accent}, 0.2)
                    task.spawn(function()
                        if cfg.Callback then cfg.Callback() end
                    end)
                end
            end)

            return {
                SetText = function(_, t)
                    nameLbl.Text = tostring(t)
                end,
                SetEnabled = function(_, v)
                    enabled = v
                    nameLbl.TextColor3 = v and T.TextPrimary or T.TextMuted
                    btnFrame.BackgroundColor3 = v and T.AccentDim or T.SurfaceLight
                    btnLbl.TextColor3 = v and T.Accent or T.TextMuted
                end,
            }
        end

        -- ── TOGGLE ────────────────────────────────────────────
        function Tab:CreateToggle(cfg)
            cfg = cfg or {}
            local f = Elem(42)
            local state = cfg.Default == true

            Lbl({
                Size = UDim2.new(1, -70, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Toggle",
                TextColor3 = T.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local track = RFrame({
                Size = UDim2.new(0, 42, 0, 22),
                Position = UDim2.new(1, -56, 0.5, -11),
                BackgroundColor3 = state and T.ToggleOn or T.ToggleOff,
                ZIndex = 7,
                Parent = f,
            }, 11)

            local knob = RFrame({
                Size = UDim2.new(0, 16, 0, 16),
                Position = state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),
                BackgroundColor3 = Color3.new(1,1,1),
                ZIndex = 8,
                Parent = track,
            }, 8)

            -- Value label
            local valLbl = Lbl({
                Size = UDim2.new(0, 30, 0, 16),
                Position = UDim2.new(1, -90, 0.5, -8),
                BackgroundTransparency = 1,
                Text = state and "ON" or "OFF",
                TextColor3 = state and T.Accent or T.TextMuted,
                TextSize = 9,
                Font = Enum.Font.GothamBold,
                ZIndex = 7,
                Parent = f,
            })

            local zone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 9,
                Parent = f,
            })

            local function Apply(v, instant)
                local d = instant and 0 or 0.18
                if v then
                    Tween(track, {BackgroundColor3=T.ToggleOn}, d, Enum.EasingStyle.Back)
                    Tween(knob, {Position=UDim2.new(1,-19,0.5,-8)}, d, Enum.EasingStyle.Back)
                    Tween(valLbl, {TextColor3=T.Accent}, d)
                    valLbl.Text = "ON"
                else
                    Tween(track, {BackgroundColor3=T.ToggleOff}, d)
                    Tween(knob, {Position=UDim2.new(0,3,0.5,-8)}, d, Enum.EasingStyle.Back)
                    Tween(valLbl, {TextColor3=T.TextMuted}, d)
                    valLbl.Text = "OFF"
                end
            end

            zone.MouseEnter:Connect(function() Tween(f, {BackgroundColor3=T.SurfaceHover}, 0.12) end)
            zone.MouseLeave:Connect(function() Tween(f, {BackgroundColor3=T.SurfaceLight}, 0.12) end)
            zone.MouseButton1Click:Connect(function()
                state = not state
                Apply(state)
                task.spawn(function()
                    if cfg.Callback then cfg.Callback(state) end
                end)
            end)

            return {
                SetState = function(_, v)
                    state = v
                    Apply(v, false)
                    if cfg.Callback then task.spawn(cfg.Callback, state) end
                end,
                GetState = function(_) return state end,
            }
        end

        -- ── SLIDER ────────────────────────────────────────────
        function Tab:CreateSlider(cfg)
            cfg = cfg or {}
            local f = Elem(56)
            local min  = cfg.Min     or 0
            local max  = cfg.Max     or 100
            local step = cfg.Step    or 1
            local val  = math.clamp(cfg.Default or min, min, max)
            local suffix = cfg.Suffix or ""

            Lbl({
                Size = UDim2.new(1, -80, 0, 20),
                Position = UDim2.new(0, 14, 0, 8),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Slider",
                TextColor3 = T.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local valLbl = Lbl({
                Size = UDim2.new(0, 70, 0, 20),
                Position = UDim2.new(1, -84, 0, 8),
                BackgroundTransparency = 1,
                Text = tostring(val)..suffix,
                TextColor3 = T.Accent,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 7,
                Parent = f,
            })

            local trackBg = Frame({
                Size = UDim2.new(1, -28, 0, 4),
                Position = UDim2.new(0, 14, 1, -16),
                BackgroundColor3 = T.Border,
                BorderSizePixel = 0,
                ZIndex = 7,
                Parent = f,
            })
            Corner(trackBg, 2)

            local pct = (val - min) / (max - min)
            local fill = Frame({
                Size = UDim2.new(pct, 0, 1, 0),
                BackgroundColor3 = T.Accent,
                BorderSizePixel = 0,
                ZIndex = 8,
                Parent = trackBg,
            })
            Corner(fill, 2)

            local knob = RFrame({
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(pct, -7, 0.5, -7),
                BackgroundColor3 = Color3.new(1,1,1),
                ZIndex = 9,
                Parent = trackBg,
            }, 7)

            local dragging = false

            local function SetVal(rawX)
                local abs   = trackBg.AbsolutePosition.X
                local width = trackBg.AbsoluteSize.X
                if width == 0 then return end
                local t = math.clamp((rawX - abs) / width, 0, 1)
                local raw = min + t * (max - min)
                local snapped = math.round(raw / step) * step
                snapped = math.clamp(snapped, min, max)
                local p = (snapped - min) / (max - min)
                fill.Size = UDim2.new(p, 0, 1, 0)
                knob.Position = UDim2.new(p, -7, 0.5, -7)
                val = snapped
                valLbl.Text = tostring(snapped)..suffix
                task.spawn(function()
                    if cfg.Callback then cfg.Callback(snapped) end
                end)
            end

            local zone = Btn({
                Size = UDim2.new(1, 0, 0, 26),
                Position = UDim2.new(0,0,1,-26),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 10,
                Parent = f,
            })
            zone.MouseButton1Down:Connect(function(x) dragging = true; SetVal(x) end)
            zone.MouseButton1Up:Connect(function() dragging = false end)

            UserInputService.InputChanged:Connect(function(i)
                if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                    SetVal(i.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
            end)

            return {
                SetValue = function(_, v)
                    v = math.clamp(v, min, max)
                    local p = (v - min)/(max - min)
                    Tween(fill, {Size=UDim2.new(p,0,1,0)}, 0.15)
                    Tween(knob, {Position=UDim2.new(p,-7,0.5,-7)}, 0.15)
                    val = v
                    valLbl.Text = tostring(v)..suffix
                end,
                GetValue = function(_) return val end,
            }
        end

        -- ── INPUT ─────────────────────────────────────────────
        function Tab:CreateInput(cfg)
            cfg = cfg or {}
            local f = Elem(58)

            Lbl({
                Size = UDim2.new(1, -28, 0, 18),
                Position = UDim2.new(0, 14, 0, 6),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Input",
                TextColor3 = T.TextPrimary,
                TextSize = 12,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local inputBg = RFrame({
                Size = UDim2.new(1, -28, 0, 24),
                Position = UDim2.new(0, 14, 1, -30),
                BackgroundColor3 = T.Background,
                ZIndex = 7,
                Parent = f,
            }, 6)
            local inputStroke = Stroke(inputBg, 1, T.Border)

            local box = New("TextBox", {
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                PlaceholderText = cfg.Placeholder or "Type here...",
                PlaceholderColor3 = T.TextMuted,
                Text = cfg.Default or "",
                TextColor3 = T.TextPrimary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = cfg.ClearOnFocus ~= false,
                ZIndex = 8,
                Parent = inputBg,
            })

            box.Focused:Connect(function()
                Tween(inputStroke, {Color=T.Accent}, 0.15)
                Tween(inputBg, {BackgroundColor3=T.SurfaceLight}, 0.15)
            end)
            box.FocusLost:Connect(function(enter)
                Tween(inputStroke, {Color=T.Border}, 0.15)
                Tween(inputBg, {BackgroundColor3=T.Background}, 0.15)
                task.spawn(function()
                    if cfg.Callback then cfg.Callback(box.Text, enter) end
                end)
            end)

            return {
                GetValue = function(_) return box.Text end,
                SetValue = function(_, v) box.Text = tostring(v) end,
                Focus    = function(_) box:CaptureFocus() end,
            }
        end

        -- ── DROPDOWN ──────────────────────────────────────────
        function Tab:CreateDropdown(cfg)
            cfg = cfg or {}
            local options  = cfg.Options or {}
            local selected = cfg.Default or (options[1] or "Select...")
            local open     = false
            local maxShow  = cfg.MaxVisible or 5

            local f = Elem(42)
            f.ClipsDescendants = false

            Lbl({
                Size = UDim2.new(0.42, 0, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Dropdown",
                TextColor3 = T.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local dropBtn = RFrame({
                Size = UDim2.new(0.56, -8, 0, 28),
                Position = UDim2.new(0.44, 0, 0.5, -14),
                BackgroundColor3 = T.Background,
                ZIndex = 7,
                Parent = f,
            }, 6)
            local dropStroke = Stroke(dropBtn, 1, T.Border)

            local selLbl = Lbl({
                Size = UDim2.new(1, -28, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = selected,
                TextColor3 = T.TextPrimary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 8,
                Parent = dropBtn,
            })

            local arrowLbl = Lbl({
                Size = UDim2.new(0, 18, 1, 0),
                Position = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1,
                Text = "▾",
                TextColor3 = T.TextSecondary,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                ZIndex = 8,
                Parent = dropBtn,
            })

            -- List frame
            local listH = math.min(#options, maxShow) * 28
            local list = RFrame({
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 6),
                BackgroundColor3 = T.Surface,
                ClipsDescendants = true,
                ZIndex = 50,
                Parent = dropBtn,
            }, 7)
            Stroke(list, 1, T.Border)

            local listScroll = New("ScrollingFrame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ScrollBarThickness = 2,
                ScrollBarImageColor3 = T.Scrollbar,
                BorderSizePixel = 0,
                CanvasSize = UDim2.new(0,0,0,0),
                ZIndex = 51,
                Parent = list,
            })
            ListLayout(listScroll, 0)

            local function RebuildList()
                for _, c in ipairs(listScroll:GetChildren()) do
                    if not c:IsA("UIListLayout") then c:Destroy() end
                end
                listScroll.CanvasSize = UDim2.new(0,0,0, #options * 28)

                for _, opt in ipairs(options) do
                    local isSelected = opt == selected
                    local row = Btn({
                        Size = UDim2.new(1, 0, 0, 28),
                        BackgroundColor3 = isSelected and T.AccentDim or T.Surface,
                        BackgroundTransparency = isSelected and 0 or 1,
                        Text = "",
                        ZIndex = 52,
                        Parent = listScroll,
                    })
                    Lbl({
                        Size = UDim2.new(1, -20, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        BackgroundTransparency = 1,
                        Text = opt,
                        TextColor3 = isSelected and T.Accent or T.TextSecondary,
                        TextSize = 12,
                        Font = isSelected and Enum.Font.GothamBold or Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 53,
                        Parent = row,
                    })
                    if isSelected then
                        Lbl({
                            Size = UDim2.new(0, 16, 0, 16),
                            Position = UDim2.new(1, -22, 0.5, -8),
                            BackgroundTransparency = 1,
                            Text = "✓",
                            TextColor3 = T.Accent,
                            TextSize = 11,
                            Font = Enum.Font.GothamBold,
                            ZIndex = 53,
                            Parent = row,
                        })
                    end
                    row.MouseEnter:Connect(function()
                        Tween(row, {BackgroundTransparency=0, BackgroundColor3=T.SurfaceHover}, 0.1)
                    end)
                    row.MouseLeave:Connect(function()
                        Tween(row, {BackgroundTransparency = isSelected and 0 or 1,
                            BackgroundColor3 = isSelected and T.AccentDim or T.Surface}, 0.1)
                    end)
                    row.MouseButton1Click:Connect(function()
                        selected = opt
                        selLbl.Text = opt
                        open = false
                        Tween(list, {Size=UDim2.new(1,0,0,0)}, 0.15)
                        Tween(arrowLbl, {Rotation=0}, 0.15)
                        Tween(dropStroke, {Color=T.Border}, 0.15)
                        RebuildList()
                        task.spawn(function()
                            if cfg.Callback then cfg.Callback(opt) end
                        end)
                    end)
                end
            end
            RebuildList()

            local zone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 9,
                Parent = dropBtn,
            })
            zone.MouseButton1Click:Connect(function()
                open = not open
                local targetH = open and math.min(#options, maxShow)*28 or 0
                Tween(list, {Size=UDim2.new(1,0,0,targetH)}, 0.2, Enum.EasingStyle.Back)
                Tween(arrowLbl, {Rotation=open and 180 or 0}, 0.18)
                Tween(dropStroke, {Color=open and T.Accent or T.Border}, 0.15)
            end)

            return {
                GetSelected = function(_) return selected end,
                SetSelected = function(_, v)
                    selected = v; selLbl.Text = v; RebuildList()
                end,
                SetOptions  = function(_, opts)
                    options = opts; RebuildList()
                end,
            }
        end

        -- ── MULTI DROPDOWN ────────────────────────────────────
        function Tab:CreateMultiDropdown(cfg)
            cfg = cfg or {}
            local options   = cfg.Options  or {}
            local selected  = {}
            local open      = false
            local maxShow   = cfg.MaxVisible or 5

            -- Apply defaults
            if cfg.Default then
                for _, v in ipairs(cfg.Default) do selected[v] = true end
            end

            local f = Elem(42)
            f.ClipsDescendants = false

            Lbl({
                Size = UDim2.new(0.42, 0, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Multi Select",
                TextColor3 = T.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local dropBtn = RFrame({
                Size = UDim2.new(0.56, -8, 0, 28),
                Position = UDim2.new(0.44, 0, 0.5, -14),
                BackgroundColor3 = T.Background,
                ZIndex = 7,
                Parent = f,
            }, 6)
            local dropStroke = Stroke(dropBtn, 1, T.Border)

            local function GetDisplayText()
                local keys = {}
                for k in pairs(selected) do table.insert(keys, k) end
                if #keys == 0 then return "None" end
                if #keys == 1 then return keys[1] end
                return keys[1].." +"..tostring(#keys-1)
            end

            local selLbl = Lbl({
                Size = UDim2.new(1, -28, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = GetDisplayText(),
                TextColor3 = T.TextPrimary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 8,
                Parent = dropBtn,
            })

            local arrowLbl = Lbl({
                Size = UDim2.new(0, 18, 1, 0),
                Position = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1,
                Text = "▾",
                TextColor3 = T.TextSecondary,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                ZIndex = 8,
                Parent = dropBtn,
            })

            local list = RFrame({
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 6),
                BackgroundColor3 = T.Surface,
                ClipsDescendants = true,
                ZIndex = 50,
                Parent = dropBtn,
            }, 7)
            Stroke(list, 1, T.Border)

            local listScroll = New("ScrollingFrame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ScrollBarThickness = 2,
                ScrollBarImageColor3 = T.Scrollbar,
                BorderSizePixel = 0,
                CanvasSize = UDim2.new(0,0,0,0),
                ZIndex = 51,
                Parent = list,
            })
            ListLayout(listScroll, 0)

            local function RebuildList()
                for _, c in ipairs(listScroll:GetChildren()) do
                    if not c:IsA("UIListLayout") then c:Destroy() end
                end
                listScroll.CanvasSize = UDim2.new(0,0,0, #options*28)

                for _, opt in ipairs(options) do
                    local isSel = selected[opt] == true
                    local row = Btn({
                        Size = UDim2.new(1,0,0,28),
                        BackgroundColor3 = isSel and T.AccentDim or T.Surface,
                        BackgroundTransparency = isSel and 0 or 1,
                        Text = "",
                        ZIndex = 52,
                        Parent = listScroll,
                    })
                    -- Checkbox
                    local cb = RFrame({
                        Size = UDim2.new(0,14,0,14),
                        Position = UDim2.new(0,10,0.5,-7),
                        BackgroundColor3 = isSel and T.Accent or T.Border,
                        ZIndex = 53,
                        Parent = row,
                    }, 3)
                    Lbl({
                        Size = UDim2.new(1,0,1,0),
                        BackgroundTransparency = 1,
                        Text = isSel and "✓" or "",
                        TextColor3 = Color3.new(1,1,1),
                        TextSize = 9,
                        Font = Enum.Font.GothamBold,
                        ZIndex = 54,
                        Parent = cb,
                    })
                    Lbl({
                        Size = UDim2.new(1,-34,1,0),
                        Position = UDim2.new(0,30,0,0),
                        BackgroundTransparency = 1,
                        Text = opt,
                        TextColor3 = isSel and T.Accent or T.TextSecondary,
                        TextSize = 12,
                        Font = isSel and Enum.Font.GothamMedium or Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 53,
                        Parent = row,
                    })
                    row.MouseEnter:Connect(function()
                        Tween(row, {BackgroundTransparency=0, BackgroundColor3=T.SurfaceHover}, 0.1)
                    end)
                    row.MouseLeave:Connect(function()
                        Tween(row, {BackgroundTransparency=isSel and 0 or 1,
                            BackgroundColor3=isSel and T.AccentDim or T.Surface}, 0.1)
                    end)
                    row.MouseButton1Click:Connect(function()
                        if selected[opt] then
                            selected[opt] = nil
                        else
                            selected[opt] = true
                        end
                        selLbl.Text = GetDisplayText()
                        RebuildList()
                        local out = {}
                        for k in pairs(selected) do table.insert(out, k) end
                        task.spawn(function()
                            if cfg.Callback then cfg.Callback(out) end
                        end)
                    end)
                end
            end
            RebuildList()

            local zone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 9,
                Parent = dropBtn,
            })
            zone.MouseButton1Click:Connect(function()
                open = not open
                local targetH = open and math.min(#options, maxShow)*28 or 0
                Tween(list, {Size=UDim2.new(1,0,0,targetH)}, 0.2, Enum.EasingStyle.Back)
                Tween(arrowLbl, {Rotation=open and 180 or 0}, 0.18)
                Tween(dropStroke, {Color=open and T.Accent or T.Border}, 0.15)
            end)

            return {
                GetSelected = function(_)
                    local out = {}
                    for k in pairs(selected) do table.insert(out, k) end
                    return out
                end,
                SetSelected = function(_, arr)
                    selected = {}
                    for _, v in ipairs(arr) do selected[v] = true end
                    selLbl.Text = GetDisplayText()
                    RebuildList()
                end,
                SetOptions = function(_, opts)
                    options = opts
                    selected = {}
                    selLbl.Text = GetDisplayText()
                    RebuildList()
                end,
            }
        end

        -- ── COLOR PICKER ──────────────────────────────────────
        function Tab:CreateColorPicker(cfg)
            cfg = cfg or {}
            local f = Elem(42)
            f.ClipsDescendants = false

            local color  = cfg.Default or Color3.fromRGB(99, 102, 241)
            local h, s, v = Color3.toHSV(color)
            local open = false

            Lbl({
                Size = UDim2.new(1, -80, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Color Picker",
                TextColor3 = T.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local preview = RFrame({
                Size = UDim2.new(0, 42, 0, 24),
                Position = UDim2.new(1, -56, 0.5, -12),
                BackgroundColor3 = color,
                ZIndex = 7,
                Parent = f,
            }, 6)
            Stroke(preview, 1, T.Border)

            local hexLbl = Lbl({
                Size = UDim2.new(0, 60, 0, 16),
                Position = UDim2.new(1, -118, 0.5, -8),
                BackgroundTransparency = 1,
                Text = "#"..ToHex(color),
                TextColor3 = T.TextSecondary,
                TextSize = 10,
                Font = Enum.Font.GothamBold,
                ZIndex = 7,
                Parent = f,
            })

            -- Popup panel
            local panel = RFrame({
                Size = UDim2.new(0, 200, 0, 0),
                Position = UDim2.new(1, -210, 1, 8),
                BackgroundColor3 = T.Surface,
                ClipsDescendants = true,
                ZIndex = 60,
                Parent = f,
            }, 8)
            Stroke(panel, 1, T.Border)

            local PANEL_H = 170

            local function UpdateColor()
                color = HSVtoRGB(h, s, v)
                preview.BackgroundColor3 = color
                hexLbl.Text = "#"..ToHex(color)
                if cfg.Callback then task.spawn(cfg.Callback, color) end
            end

            -- SV square
            local svBg = Frame({
                Size = UDim2.new(1, -14, 0, 110),
                Position = UDim2.new(0, 7, 0, 8),
                BackgroundColor3 = Color3.fromHSV(h, 1, 1),
                ZIndex = 61,
                Parent = panel,
            })
            Corner(svBg, 5)

            -- White gradient
            local wGrad = New("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
                    ColorSequenceKeypoint.new(1, Color3.new(1,1,1)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                }),
                Parent = svBg,
            })

            local bGrad = New("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
                    ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0),
                }),
                Rotation = 90,
                Parent = svBg,
            })

            -- SV knob
            local svKnob = Frame({
                Size = UDim2.new(0, 10, 0, 10),
                Position = UDim2.new(s, -5, 1-v, -5),
                BackgroundColor3 = Color3.new(1,1,1),
                ZIndex = 63,
                Parent = svBg,
            })
            Corner(svKnob, 5)
            Stroke(svKnob, 1, Color3.new(0,0,0))

            -- Hue bar
            local hueBar = Frame({
                Size = UDim2.new(1, -14, 0, 12),
                Position = UDim2.new(0, 7, 0, 124),
                BackgroundColor3 = Color3.new(1,1,1),
                ZIndex = 61,
                Parent = panel,
            })
            Corner(hueBar, 6)
            New("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0,    Color3.fromHSV(0,    1, 1)),
                    ColorSequenceKeypoint.new(0.167,Color3.fromHSV(0.167,1, 1)),
                    ColorSequenceKeypoint.new(0.333,Color3.fromHSV(0.333,1, 1)),
                    ColorSequenceKeypoint.new(0.5,  Color3.fromHSV(0.5,  1, 1)),
                    ColorSequenceKeypoint.new(0.667,Color3.fromHSV(0.667,1, 1)),
                    ColorSequenceKeypoint.new(0.833,Color3.fromHSV(0.833,1, 1)),
                    ColorSequenceKeypoint.new(1,    Color3.fromHSV(1,    1, 1)),
                }),
                Parent = hueBar,
            })

            local hueKnob = RFrame({
                Size = UDim2.new(0, 8, 1, 4),
                Position = UDim2.new(h, -4, 0, -2),
                BackgroundColor3 = Color3.new(1,1,1),
                ZIndex = 62,
                Parent = hueBar,
            }, 4)
            Stroke(hueKnob, 1, Color3.new(0,0,0))

            -- Hex input at bottom
            local hexInput = New("TextBox", {
                Size = UDim2.new(1, -14, 0, 22),
                Position = UDim2.new(0, 7, 0, 142),
                BackgroundColor3 = T.Background,
                Text = ToHex(color),
                TextColor3 = T.TextPrimary,
                TextSize = 11,
                Font = Enum.Font.GothamMedium,
                PlaceholderText = "RRGGBB",
                PlaceholderColor3 = T.TextMuted,
                ZIndex = 62,
                Parent = panel,
            })
            Corner(hexInput, 5)
            Stroke(hexInput, 1, T.Border)

            hexInput.FocusLost:Connect(function()
                local txt = hexInput.Text:gsub("#","")
                if #txt == 6 then
                    local r = tonumber(txt:sub(1,2),16)
                    local g = tonumber(txt:sub(3,4),16)
                    local b = tonumber(txt:sub(5,6),16)
                    if r and g and b then
                        color = Color3.fromRGB(r,g,b)
                        h,s,v = Color3.toHSV(color)
                        svBg.BackgroundColor3 = Color3.fromHSV(h,1,1)
                        hueKnob.Position = UDim2.new(h,-4,0,-2)
                        svKnob.Position  = UDim2.new(s,-5,1-v,-5)
                        preview.BackgroundColor3 = color
                        hexLbl.Text = "#"..ToHex(color)
                        if cfg.Callback then task.spawn(cfg.Callback, color) end
                    end
                end
                hexInput.Text = ToHex(color)
            end)

            -- SV drag
            local svDrag = false
            local svZone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 64,
                Parent = svBg,
            })
            local function UpdateSV(x, y)
                local ax, ay = svBg.AbsolutePosition.X, svBg.AbsolutePosition.Y
                local aw, ah = svBg.AbsoluteSize.X, svBg.AbsoluteSize.Y
                s = math.clamp((x-ax)/aw, 0, 1)
                v = 1 - math.clamp((y-ay)/ah, 0, 1)
                svKnob.Position = UDim2.new(s,-5,1-v,-5)
                UpdateColor()
            end
            svZone.MouseButton1Down:Connect(function(x,y) svDrag=true; UpdateSV(x,y) end)
            svZone.MouseButton1Up:Connect(function() svDrag=false end)

            -- Hue drag
            local hueDrag = false
            local hueZone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency=1,
                Text="",
                ZIndex=64,
                Parent=hueBar,
            })
            local function UpdateHue(x)
                local ax = hueBar.AbsolutePosition.X
                local aw = hueBar.AbsoluteSize.X
                h = math.clamp((x-ax)/aw, 0, 1)
                hueKnob.Position = UDim2.new(h,-4,0,-2)
                svBg.BackgroundColor3 = Color3.fromHSV(h,1,1)
                UpdateColor()
            end
            hueZone.MouseButton1Down:Connect(function(x) hueDrag=true; UpdateHue(x) end)
            hueZone.MouseButton1Up:Connect(function() hueDrag=false end)

            UserInputService.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement then
                    if svDrag  then UpdateSV(i.Position.X, i.Position.Y) end
                    if hueDrag then UpdateHue(i.Position.X) end
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    svDrag = false; hueDrag = false
                end
            end)

            -- Toggle panel
            local pZone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency=1,
                Text="",
                ZIndex=9,
                Parent=f,
            })
            pZone.MouseButton1Click:Connect(function()
                open = not open
                Tween(panel, {Size=UDim2.new(0,200,0,open and PANEL_H or 0)}, 0.22, Enum.EasingStyle.Back)
            end)

            return {
                GetColor = function(_) return color end,
                SetColor = function(_, c)
                    color = c
                    h,s,v = Color3.toHSV(c)
                    preview.BackgroundColor3 = c
                    hexLbl.Text = "#"..ToHex(c)
                    svBg.BackgroundColor3 = Color3.fromHSV(h,1,1)
                    hueKnob.Position = UDim2.new(h,-4,0,-2)
                    svKnob.Position  = UDim2.new(s,-5,1-v,-5)
                    hexInput.Text = ToHex(c)
                end,
            }
        end

        -- ── KEYBIND ───────────────────────────────────────────
        function Tab:CreateKeybind(cfg)
            cfg = cfg or {}
            local f = Elem(42)
            local boundKey  = cfg.Default or Enum.KeyCode.E
            local listening = false

            Lbl({
                Size = UDim2.new(1, -100, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Name or "Keybind",
                TextColor3 = T.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7,
                Parent = f,
            })

            local keyFrame = RFrame({
                Size = UDim2.new(0, 80, 0, 26),
                Position = UDim2.new(1, -94, 0.5, -13),
                BackgroundColor3 = T.Background,
                ZIndex = 7,
                Parent = f,
            }, 6)
            Stroke(keyFrame, 1, T.Border)

            local keyLbl = Lbl({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency = 1,
                Text = boundKey.Name,
                TextColor3 = T.Accent,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                ZIndex = 8,
                Parent = keyFrame,
            })

            local zone = Btn({
                Size = UDim2.new(1,0,1,0),
                BackgroundTransparency=1,
                Text="",
                ZIndex=9,
                Parent=f,
            })
            zone.MouseEnter:Connect(function() Tween(f, {BackgroundColor3=T.SurfaceHover}, 0.12) end)
            zone.MouseLeave:Connect(function() Tween(f, {BackgroundColor3=T.SurfaceLight}, 0.12) end)
            zone.MouseButton1Click:Connect(function()
                if listening then return end
                listening = true
                keyLbl.Text = "..."
                keyLbl.TextColor3 = T.Warning
                Tween(keyFrame, {BackgroundColor3=T.SurfaceLight}, 0.12)

                local conn
                conn = UserInputService.InputBegan:Connect(function(input, gp)
                    if gp then return end
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        boundKey = input.KeyCode
                        keyLbl.Text = boundKey.Name
                        keyLbl.TextColor3 = T.Accent
                        Tween(keyFrame, {BackgroundColor3=T.Background}, 0.12)
                        listening = false
                        conn:Disconnect()
                        task.spawn(function()
                            if cfg.Callback then cfg.Callback(boundKey) end
                        end)
                    end
                end)
            end)

            -- Execute callback when key pressed
            UserInputService.InputBegan:Connect(function(input, gp)
                if gp or listening then return end
                if input.KeyCode == boundKey and cfg.OnPress then
                    task.spawn(cfg.OnPress)
                end
            end)

            return {
                GetKey = function(_) return boundKey end,
                SetKey = function(_, k)
                    boundKey = k
                    keyLbl.Text = k.Name
                end,
            }
        end

        return Tab
    end

    return Window
end

return NexusUI
