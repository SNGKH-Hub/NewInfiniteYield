local SNUI = {}
SNUI.__index = SNUI

-- ─── Services ─────────────────────────────────────────────────────────────────
local Players         = game:GetService("Players")
local TweenService    = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService      = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ─── Theme ────────────────────────────────────────────────────────────────────
local T = {
    Bg          = Color3.fromRGB(12, 12, 18),
    Surface     = Color3.fromRGB(20, 20, 30),
    SurfaceAlt  = Color3.fromRGB(26, 26, 40),
    Card        = Color3.fromRGB(22, 22, 35),
    CardHover   = Color3.fromRGB(30, 30, 46),
    Accent      = Color3.fromRGB(108, 87, 230),
    AccentHover = Color3.fromRGB(130, 110, 255),
    AccentGlow  = Color3.fromRGB(80, 60, 200),
    AccentDim   = Color3.fromRGB(60, 48, 150),
    Text        = Color3.fromRGB(235, 235, 252),
    TextSub     = Color3.fromRGB(148, 148, 185),
    TextDim     = Color3.fromRGB(80, 80, 115),
    Border      = Color3.fromRGB(45, 45, 68),
    BorderHi    = Color3.fromRGB(75, 60, 160),
    SliderBg    = Color3.fromRGB(35, 35, 55),
    SliderFill  = Color3.fromRGB(108, 87, 230),
    TogOn       = Color3.fromRGB(108, 87, 230),
    TogOff      = Color3.fromRGB(40, 40, 62),
    Red         = Color3.fromRGB(215, 55, 75),
    White       = Color3.fromRGB(255, 255, 255),
}

-- ─── Utility ──────────────────────────────────────────────────────────────────
local function Tween(obj, props, t, style, dir)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.22, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
        props
    ):Play()
end

local function Corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or T.Border
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.4
    s.Parent = parent
    return s
end

local function New(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    if parent then inst.Parent = parent end
    return inst
end

-- ─── Draggable ────────────────────────────────────────────────────────────────
local function MakeDraggable(frame, handle)
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = inp.Position
            startPos  = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if not dragging then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement
        or inp.UserInputType == Enum.UserInputType.Touch then
            local d = inp.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ─── CreateWindow ─────────────────────────────────────────────────────────────
function SNUI:CreateWindow(config)
    config = config or {}
    local Title  = config.Title  or "Script Hub"
    local Author = config.Author or ""

    -- ScreenGui
    local SG = New("ScreenGui", {
        Name             = "SNUI_" .. Title:gsub("%s+", ""),
        ResetOnSpawn     = false,
        ZIndexBehavior   = Enum.ZIndexBehavior.Sibling,
        DisplayOrder     = 999,
    })
    pcall(function() SG.Parent = game:GetService("CoreGui") end)
    if not SG.Parent then SG.Parent = PlayerGui end

    -- Drop shadow layer
    local Shadow = New("Frame", {
        Name                  = "Shadow",
        Size                  = UDim2.new(0, 592, 0, 432),
        Position              = UDim2.new(0.5, -292, 0.5, -208),
        BackgroundColor3      = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency= 0.55,
        BorderSizePixel       = 0,
        ZIndex                = 1,
        Parent                = SG,
    })
    Corner(Shadow, 16)

    -- Main window
    local Main = New("Frame", {
        Name             = "Main",
        Size             = UDim2.new(0, 578, 0, 418),
        Position         = UDim2.new(0.5, -289, 0.5, -209),
        BackgroundColor3 = T.Bg,
        BorderSizePixel  = 0,
        ZIndex           = 2,
        Parent           = SG,
    })
    Corner(Main, 12)
    Stroke(Main, T.Border, 1.5, 0.25)

    -- Sync shadow to main each frame
    local shadowConn
    shadowConn = RunService.RenderStepped:Connect(function()
        if not Main or not Main.Parent then shadowConn:Disconnect() return end
        Shadow.Position = UDim2.new(
            Main.Position.X.Scale, Main.Position.X.Offset + 7,
            Main.Position.Y.Scale, Main.Position.Y.Offset + 7
        )
    end)

    -- ── Top Bar ───────────────────────────────────────────────────────────────
    local Topbar = New("Frame", {
        Name             = "Topbar",
        Size             = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = T.Surface,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = Main,
    })
    Corner(Topbar, 12)
    -- flatten bottom corners of topbar
    New("Frame", {
        Size             = UDim2.new(1, 0, 0, 12),
        Position         = UDim2.new(0, 0, 1, -12),
        BackgroundColor3 = T.Surface,
        BorderSizePixel  = 0,
        ZIndex           = 3,
        Parent           = Topbar,
    })

    -- Accent left bar
    local accentBar = New("Frame", {
        Size             = UDim2.new(0, 3, 0, 30),
        Position         = UDim2.new(0, 14, 0.5, -15),
        BackgroundColor3 = T.Accent,
        BorderSizePixel  = 0,
        ZIndex           = 4,
        Parent           = Topbar,
    })
    Corner(accentBar, 4)

    -- Title
    local TitleLbl = New("TextLabel", {
        Size              = UDim2.new(0, 280, 0, Author ~= "" and 22 or 52),
        Position          = UDim2.new(0, 26, 0, Author ~= "" and 7 or 0),
        BackgroundTransparency = 1,
        Text              = Title,
        Font              = Enum.Font.GothamBold,
        TextSize          = 15,
        TextColor3        = T.Text,
        TextXAlignment    = Enum.TextXAlignment.Left,
        ZIndex            = 4,
        Parent            = Topbar,
    })

    if Author ~= "" then
        New("TextLabel", {
            Size              = UDim2.new(0, 280, 0, 16),
            Position          = UDim2.new(0, 26, 0, 31),
            BackgroundTransparency = 1,
            Text              = Author,
            Font              = Enum.Font.Gotham,
            TextSize          = 11,
            TextColor3        = T.TextSub,
            TextXAlignment    = Enum.TextXAlignment.Left,
            ZIndex            = 4,
            Parent            = Topbar,
        })
    end

    -- Minimize button
    local MinBtn = New("TextButton", {
        Size             = UDim2.new(0, 30, 0, 30),
        Position         = UDim2.new(1, -76, 0.5, -15),
        BackgroundColor3 = T.SurfaceAlt,
        BorderSizePixel  = 0,
        Text             = "─",
        Font             = Enum.Font.GothamBold,
        TextSize         = 13,
        TextColor3       = T.TextSub,
        ZIndex           = 5,
        Parent           = Topbar,
    })
    Corner(MinBtn, 8)
    Stroke(MinBtn, T.Border, 1, 0.4)

    -- Close button
    local CloseBtn = New("TextButton", {
        Size             = UDim2.new(0, 30, 0, 30),
        Position         = UDim2.new(1, -38, 0.5, -15),
        BackgroundColor3 = T.Red,
        BorderSizePixel  = 0,
        Text             = "✕",
        Font             = Enum.Font.GothamBold,
        TextSize         = 12,
        TextColor3       = T.White,
        ZIndex           = 5,
        Parent           = Topbar,
    })
    Corner(CloseBtn, 8)

    -- Draggable
    MakeDraggable(Main, Topbar)

    -- ── Content area ─────────────────────────────────────────────────────────
    local Content = New("Frame", {
        Name                  = "Content",
        Size                  = UDim2.new(1, 0, 1, -52),
        Position              = UDim2.new(0, 0, 0, 52),
        BackgroundTransparency= 1,
        ZIndex                = 2,
        Parent                = Main,
    })

    -- Left tab bar
    local TabBar = New("ScrollingFrame", {
        Name                 = "TabBar",
        Size                 = UDim2.new(0, 148, 1, -10),
        Position             = UDim2.new(0, 5, 0, 5),
        BackgroundColor3     = T.Surface,
        BorderSizePixel      = 0,
        ScrollBarThickness   = 2,
        ScrollBarImageColor3 = T.Accent,
        CanvasSize           = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize  = Enum.AutomaticSize.Y,
        ZIndex               = 3,
        Parent               = Content,
    })
    Corner(TabBar, 10)
    Stroke(TabBar, T.Border, 1, 0.5)
    New("UIPadding", {
        PaddingTop    = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft   = UDim.new(0, 6),
        PaddingRight  = UDim.new(0, 6),
        Parent        = TabBar,
    })
    New("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding   = UDim.new(0, 4),
        Parent    = TabBar,
    })

    -- Vertical divider
    New("Frame", {
        Size             = UDim2.new(0, 1, 1, -20),
        Position         = UDim2.new(0, 158, 0, 10),
        BackgroundColor3 = T.Border,
        BorderSizePixel  = 0,
        BackgroundTransparency = 0.4,
        ZIndex           = 3,
        Parent           = Content,
    })

    -- Tab page container
    local TabContent = New("Frame", {
        Name                  = "TabContent",
        Size                  = UDim2.new(1, -168, 1, -10),
        Position              = UDim2.new(0, 163, 0, 5),
        BackgroundTransparency= 1,
        ZIndex                = 3,
        Parent                = Content,
    })

    -- ── Floating "Open UI" pill button (shown when window is hidden) ─────────
    local OpenPill = New("TextButton", {
        Name             = "OpenPill",
        Size             = UDim2.new(0, 110, 0, 32),
        Position         = UDim2.new(0.5, -55, 0, 18),
        BackgroundColor3 = T.Accent,
        BorderSizePixel  = 0,
        Text             = "",
        AutoButtonColor  = false,
        Visible          = false,
        ZIndex           = 50,
        Parent           = SG,
    })
    Corner(OpenPill, 16)
    Stroke(OpenPill, T.AccentHover, 1.5, 0.2)

    -- Glow behind pill
    local PillGlow = New("Frame", {
        Size                  = UDim2.new(1, 16, 1, 14),
        Position              = UDim2.new(0, -8, 0, -7),
        BackgroundColor3      = T.Accent,
        BackgroundTransparency= 0.72,
        BorderSizePixel       = 0,
        ZIndex                = 49,
        Parent                = OpenPill,
    })
    Corner(PillGlow, 20)

    -- Triangle icon
    New("TextLabel", {
        Size              = UDim2.new(0, 22, 1, 0),
        Position          = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text              = "▲",
        Font              = Enum.Font.GothamBold,
        TextSize          = 11,
        TextColor3        = T.White,
        ZIndex            = 51,
        Parent            = OpenPill,
    })

    -- "Open UI" label
    New("TextLabel", {
        Size              = UDim2.new(1, -32, 1, 0),
        Position          = UDim2.new(0, 30, 0, 0),
        BackgroundTransparency = 1,
        Text              = "Open UI",
        Font              = Enum.Font.GothamSemibold,
        TextSize          = 13,
        TextColor3        = T.White,
        TextXAlignment    = Enum.TextXAlignment.Left,
        ZIndex            = 51,
        Parent            = OpenPill,
    })

    -- Pill is draggable too
    MakeDraggable(OpenPill, OpenPill)

    -- Hover glow pulse on pill
    OpenPill.MouseEnter:Connect(function()
        Tween(OpenPill, {BackgroundColor3 = T.AccentHover}, 0.15)
        Tween(PillGlow, {BackgroundTransparency = 0.55}, 0.15)
    end)
    OpenPill.MouseLeave:Connect(function()
        Tween(OpenPill, {BackgroundColor3 = T.Accent}, 0.15)
        Tween(PillGlow, {BackgroundTransparency = 0.72}, 0.15)
    end)

    -- ── Topbar button hover/logic ─────────────────────────────────────────────
    local windowHidden = false
    local savedPos     = Main.Position

    local function HideWindow()
        if windowHidden then return end
        windowHidden = true
        savedPos = Main.Position
        -- Scroll up animation: slide to above screen + shrink height
        local targetY = Main.Position.Y.Offset - 440
        Tween(Main,   {Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset, 0, targetY),
                       Size     = UDim2.new(0, 578, 0, 0)},
              0.38, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        Tween(Shadow, {BackgroundTransparency = 1}, 0.22)
        task.delay(0.32, function()
            Main.Visible   = false
            Shadow.Visible = false
            OpenPill.Visible = true
            -- animate pill in
            OpenPill.Size = UDim2.new(0, 0, 0, 32)
            OpenPill.BackgroundTransparency = 1
            Tween(OpenPill, {Size = UDim2.new(0, 110, 0, 32), BackgroundTransparency = 0}, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end)
    end

    local function ShowWindow()
        if not windowHidden then return end
        windowHidden = false
        -- Hide pill
        Tween(OpenPill, {Size = UDim2.new(0, 0, 0, 32), BackgroundTransparency = 1}, 0.18)
        task.delay(0.16, function()
            OpenPill.Visible = false
            Main.Visible     = true
            Shadow.Visible   = true
            -- Restore position but start from above, scroll down
            Main.Position   = UDim2.new(savedPos.X.Scale, savedPos.X.Offset, 0, savedPos.Y.Offset - 60)
            Main.Size       = UDim2.new(0, 578, 0, 0)
            Shadow.BackgroundTransparency = 0.55
            Tween(Main, {Position = savedPos, Size = UDim2.new(0, 578, 0, 418)},
                  0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end)
    end

    MinBtn.MouseEnter:Connect(function() Tween(MinBtn, {BackgroundColor3 = T.Border}, 0.15) end)
    MinBtn.MouseLeave:Connect(function() Tween(MinBtn, {BackgroundColor3 = T.SurfaceAlt}, 0.15) end)
    CloseBtn.MouseEnter:Connect(function() Tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(240, 70, 90)}, 0.15) end)
    CloseBtn.MouseLeave:Connect(function() Tween(CloseBtn, {BackgroundColor3 = T.Red}, 0.15) end)

    -- Minimize = collapse to topbar only
    local isMinimized = false
    MinBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            Content.Visible = false
            Tween(Main, {Size = UDim2.new(0, 578, 0, 52)}, 0.28, Enum.EasingStyle.Quart)
            Tween(Shadow, {Size = UDim2.new(0, 592, 0, 66)}, 0.28)
            MinBtn.Text = "□"
        else
            Content.Visible = true
            Tween(Main, {Size = UDim2.new(0, 578, 0, 418)}, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            Tween(Shadow, {Size = UDim2.new(0, 592, 0, 432)}, 0.28)
            MinBtn.Text = "─"
        end
    end)

    -- Close = scroll up → show Open UI pill
    CloseBtn.MouseButton1Click:Connect(HideWindow)
    OpenPill.MouseButton1Click:Connect(ShowWindow)

    -- ── Window Object ─────────────────────────────────────────────────────────
    local Window = { _tabs = {}, _activeTab = nil }

    function Window:Tab(tabCfg)
        tabCfg = tabCfg or {}
        local tabTitle  = tabCfg.Title  or "Tab"
        local tabLocked = tabCfg.Locked or false

        -- Tab button in sidebar
        local TabBtn = New("TextButton", {
            Size             = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = T.Surface,
            BorderSizePixel  = 0,
            Text             = "",
            AutoButtonColor  = false,
            ZIndex           = 4,
            LayoutOrder      = #Window._tabs + 1,
            Parent           = TabBar,
        })
        Corner(TabBtn, 8)

        -- Icon dot
        local Dot = New("Frame", {
            Size             = UDim2.new(0, 6, 0, 6),
            Position         = UDim2.new(0, 11, 0.5, -3),
            BackgroundColor3 = T.TextDim,
            BorderSizePixel  = 0,
            ZIndex           = 5,
            Parent           = TabBtn,
        })
        Corner(Dot, 10)

        New("TextLabel", {
            Name              = "Lbl",
            Size              = UDim2.new(1, -28, 1, 0),
            Position          = UDim2.new(0, 26, 0, 0),
            BackgroundTransparency = 1,
            Text              = tabTitle,
            Font              = Enum.Font.Gotham,
            TextSize          = 13,
            TextColor3        = tabLocked and T.TextDim or T.TextSub,
            TextXAlignment    = Enum.TextXAlignment.Left,
            ZIndex            = 5,
            Parent            = TabBtn,
        })

        -- Lock badge
        if tabLocked then
            local lockBadge = New("TextLabel", {
                Size              = UDim2.new(0, 18, 0, 16),
                Position          = UDim2.new(1, -22, 0.5, -8),
                BackgroundColor3  = T.SurfaceAlt,
                BackgroundTransparency = 0.2,
                Text              = "🔒",
                TextSize          = 9,
                Font              = Enum.Font.Gotham,
                TextColor3        = T.TextDim,
                ZIndex            = 6,
                Parent            = TabBtn,
            })
            Corner(lockBadge, 4)
        end

        -- Page (scrollable)
        local Page = New("ScrollingFrame", {
            Name                 = "Page_" .. tabTitle,
            Size                 = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel      = 0,
            ScrollBarThickness   = 3,
            ScrollBarImageColor3 = T.Accent,
            CanvasSize           = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize  = Enum.AutomaticSize.Y,
            Visible              = false,
            ZIndex               = 4,
            Parent               = TabContent,
        })
        New("UIPadding", {
            PaddingTop    = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 8),
            PaddingLeft   = UDim.new(0, 2),
            PaddingRight  = UDim.new(0, 6),
            Parent        = Page,
        })
        New("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding   = UDim.new(0, 5),
            Parent    = Page,
        })

        -- Activate / deactivate tab
        local function Activate()
            if tabLocked then return end
            for _, td in ipairs(Window._tabs) do
                td.btn.BackgroundColor3       = T.Surface
                td.lbl.TextColor3             = T.TextSub
                td.lbl.Font                   = Enum.Font.Gotham
                td.dot.BackgroundColor3       = T.TextDim
                td.page.Visible               = false
            end
            TabBtn.BackgroundColor3     = T.SurfaceAlt
            TabBtn.Lbl.TextColor3       = T.Text
            TabBtn.Lbl.Font             = Enum.Font.GothamSemibold
            Dot.BackgroundColor3        = T.Accent
            Page.Visible                = true
            Window._activeTab           = tabTitle
        end

        TabBtn.MouseButton1Click:Connect(Activate)
        TabBtn.MouseEnter:Connect(function()
            if tabLocked or Window._activeTab == tabTitle then return end
            Tween(TabBtn, {BackgroundColor3 = T.CardHover}, 0.15)
        end)
        TabBtn.MouseLeave:Connect(function()
            if tabLocked or Window._activeTab == tabTitle then return end
            Tween(TabBtn, {BackgroundColor3 = T.Surface}, 0.15)
        end)

        local tabData = { btn = TabBtn, lbl = TabBtn.Lbl, dot = Dot, page = Page, title = tabTitle }
        table.insert(Window._tabs, tabData)
        if #Window._tabs == 1 then Activate() end

        -- ── Helper: Card ──────────────────────────────────────────────────────
        local elemCount = 0
        local function Card(h)
            elemCount += 1
            local c = New("Frame", {
                Size             = UDim2.new(1, 0, 0, h or 54),
                BackgroundColor3 = T.Card,
                BorderSizePixel  = 0,
                ZIndex           = 5,
                LayoutOrder      = elemCount,
                Parent           = Page,
            })
            Corner(c, 9)
            Stroke(c, T.Border, 1, 0.5)
            return c
        end

        local function Labels(parent, title, desc)
            New("TextLabel", {
                Size              = UDim2.new(0.55, 0, 0, 19),
                Position          = UDim2.new(0, 12, 0, desc ~= "" and 8 or 0),
                BackgroundTransparency = 1,
                Text              = title,
                Font              = Enum.Font.GothamSemibold,
                TextSize          = 13,
                TextColor3        = T.Text,
                TextXAlignment    = Enum.TextXAlignment.Left,
                ZIndex            = 6,
                Parent            = parent,
            })
            if desc and desc ~= "" then
                New("TextLabel", {
                    Size              = UDim2.new(0.55, 0, 0, 14),
                    Position          = UDim2.new(0, 12, 0, 29),
                    BackgroundTransparency = 1,
                    Text              = desc,
                    Font              = Enum.Font.Gotham,
                    TextSize          = 11,
                    TextColor3        = T.TextSub,
                    TextXAlignment    = Enum.TextXAlignment.Left,
                    ZIndex            = 6,
                    Parent            = parent,
                })
            end
        end

        -- ─── Tab API ──────────────────────────────────────────────────────────
        local Tab = {}

        -- Button ──────────────────────────────────────────────────────────────
        function Tab:Button(cfg)
            cfg = cfg or {}
            local locked = cfg.Locked or false
            local c = Card(54)
            Labels(c, cfg.Title or "Button", cfg.Desc or "")

            local btn = New("TextButton", {
                Size             = UDim2.new(0, 82, 0, 28),
                Position         = UDim2.new(1, -92, 0.5, -14),
                BackgroundColor3 = locked and T.TextDim or T.Accent,
                BorderSizePixel  = 0,
                Text             = "Execute",
                Font             = Enum.Font.GothamSemibold,
                TextSize         = 12,
                TextColor3       = T.White,
                AutoButtonColor  = false,
                ZIndex           = 7,
                Parent           = c,
            })
            Corner(btn, 7)

            if not locked then
                btn.MouseEnter:Connect(function()   Tween(btn, {BackgroundColor3 = T.AccentHover}, 0.15) end)
                btn.MouseLeave:Connect(function()   Tween(btn, {BackgroundColor3 = T.Accent}, 0.15) end)
                btn.MouseButton1Down:Connect(function() Tween(btn, {BackgroundColor3 = T.AccentGlow}, 0.1) end)
                btn.MouseButton1Up:Connect(function()   Tween(btn, {BackgroundColor3 = T.Accent}, 0.15) end)
                btn.MouseButton1Click:Connect(function()
                    if cfg.Callback then pcall(cfg.Callback) end
                end)
            else
                New("TextLabel", {
                    Size              = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text              = "🔒",
                    TextSize          = 12,
                    Font              = Enum.Font.Gotham,
                    TextColor3        = T.TextDim,
                    ZIndex            = 8,
                    Parent            = btn,
                })
            end
        end

        -- Toggle ──────────────────────────────────────────────────────────────
        function Tab:Toggle(cfg)
            cfg = cfg or {}
            local val = cfg.Value or false
            local c = Card(54)
            Labels(c, cfg.Title or "Toggle", cfg.Desc or "")

            local track = New("Frame", {
                Size             = UDim2.new(0, 46, 0, 24),
                Position         = UDim2.new(1, -56, 0.5, -12),
                BackgroundColor3 = val and T.TogOn or T.TogOff,
                BorderSizePixel  = 0,
                ZIndex           = 7,
                Parent           = c,
            })
            Corner(track, 12)

            local knob = New("Frame", {
                Size             = UDim2.new(0, 18, 0, 18),
                Position         = val and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
                BackgroundColor3 = T.White,
                BorderSizePixel  = 0,
                ZIndex           = 8,
                Parent           = track,
            })
            Corner(knob, 10)

            local click = New("TextButton", {
                Size                  = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency= 1,
                Text                  = "",
                ZIndex                = 9,
                Parent                = track,
            })
            click.MouseButton1Click:Connect(function()
                val = not val
                Tween(track, {BackgroundColor3 = val and T.TogOn or T.TogOff}, 0.2)
                Tween(knob, {Position = val and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}, 0.22)
                if cfg.Callback then pcall(cfg.Callback, val) end
            end)
        end

        -- Slider ──────────────────────────────────────────────────────────────
        function Tab:Slider(cfg)
            cfg = cfg or {}
            local vCfg    = cfg.Value or {}
            local Min     = vCfg.Min     or 0
            local Max     = vCfg.Max     or 100
            local Default = vCfg.Default or Min
            local Step    = cfg.Step     or 1
            local curVal  = Default

            local c = Card(72)
            Labels(c, cfg.Title or "Slider", cfg.Desc or "")

            -- Live value display
            local valLbl = New("TextLabel", {
                Size              = UDim2.new(0, 52, 0, 19),
                Position          = UDim2.new(1, -60, 0, 8),
                BackgroundTransparency = 1,
                Text              = tostring(Default),
                Font              = Enum.Font.GothamBold,
                TextSize          = 13,
                TextColor3        = T.Accent,
                TextXAlignment    = Enum.TextXAlignment.Right,
                ZIndex            = 6,
                Parent            = c,
            })

            -- Track
            local track = New("Frame", {
                Size             = UDim2.new(1, -24, 0, 8),
                Position         = UDim2.new(0, 12, 1, -22),
                BackgroundColor3 = T.SliderBg,
                BorderSizePixel  = 0,
                ZIndex           = 6,
                Parent           = c,
            })
            Corner(track, 6)

            local function fillRatio() return math.clamp((curVal - Min) / (Max - Min), 0, 1) end

            local fill = New("Frame", {
                Size             = UDim2.new(fillRatio(), 0, 1, 0),
                BackgroundColor3 = T.SliderFill,
                BorderSizePixel  = 0,
                ZIndex           = 7,
                Parent           = track,
            })
            Corner(fill, 6)

            local handle = New("Frame", {
                Size             = UDim2.new(0, 14, 0, 14),
                Position         = UDim2.new(fillRatio(), -7, 0.5, -7),
                BackgroundColor3 = T.White,
                BorderSizePixel  = 0,
                ZIndex           = 8,
                Parent           = track,
            })
            Corner(handle, 10)
            Stroke(handle, T.Accent, 2, 0)

            local function SetVal(x)
                local abs = track.AbsolutePosition.X
                local sz  = track.AbsoluteSize.X
                local rel = math.clamp((x - abs) / sz, 0, 1)
                local raw = Min + (Max - Min) * rel
                local snapped = Step ~= 0 and (math.round(raw / Step) * Step) or raw
                snapped = math.clamp(snapped, Min, Max)
                if Step < 1 then
                    local dec = math.max(0, math.floor(-math.log10(Step) + 0.5))
                    curVal = math.floor(snapped * (10^dec) + 0.5) / (10^dec)
                else
                    curVal = math.floor(snapped + 0.5)
                end
                local f = fillRatio()
                fill.Size     = UDim2.new(f, 0, 1, 0)
                handle.Position = UDim2.new(f, -7, 0.5, -7)
                valLbl.Text   = tostring(curVal)
                if cfg.Callback then pcall(cfg.Callback, curVal) end
            end

            local sliding = false
            track.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                    sliding = true; SetVal(inp.Position.X)
                end
            end)
            UserInputService.InputChanged:Connect(function(inp)
                if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement
                    or inp.UserInputType == Enum.UserInputType.Touch) then
                    SetVal(inp.Position.X)
                end
            end)
            UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1
                or inp.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)
        end

        -- Dropdown ────────────────────────────────────────────────────────────
        function Tab:Dropdown(cfg)
            cfg = cfg or {}
            local values   = cfg.Values or {}
            local curVal   = cfg.Value  or (values[1] or "Select...")
            local isOpen   = false
            local itemH    = 30
            local listH    = #values * itemH + 8

            local c = Card(54)
            c.ClipsDescendants = false
            Labels(c, cfg.Title or "Dropdown", cfg.Desc or "")

            local dropBtn = New("TextButton", {
                Size             = UDim2.new(0, 118, 0, 28),
                Position         = UDim2.new(1, -128, 0.5, -14),
                BackgroundColor3 = T.SurfaceAlt,
                BorderSizePixel  = 0,
                Text             = "",
                AutoButtonColor  = false,
                ZIndex           = 7,
                Parent           = c,
            })
            Corner(dropBtn, 7)
            Stroke(dropBtn, T.Border, 1, 0.3)

            New("TextLabel", {
                Name              = "Val",
                Size              = UDim2.new(1, -22, 1, 0),
                Position          = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                Text              = curVal,
                Font              = Enum.Font.Gotham,
                TextSize          = 12,
                TextColor3        = T.Text,
                TextXAlignment    = Enum.TextXAlignment.Left,
                ZIndex            = 8,
                Parent            = dropBtn,
            })

            local arrow = New("TextLabel", {
                Size              = UDim2.new(0, 18, 1, 0),
                Position          = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1,
                Text              = "▾",
                Font              = Enum.Font.GothamBold,
                TextSize          = 13,
                TextColor3        = T.Accent,
                ZIndex            = 8,
                Parent            = dropBtn,
            })

            -- Dropdown list
            local list = New("Frame", {
                Name             = "List",
                Size             = UDim2.new(0, 118, 0, listH),
                Position         = UDim2.new(1, -128, 1, 6),
                BackgroundColor3 = T.SurfaceAlt,
                BorderSizePixel  = 0,
                Visible          = false,
                ZIndex           = 30,
                ClipsDescendants = true,
                Parent           = c,
            })
            Corner(list, 8)
            Stroke(list, T.Accent, 1.2, 0.3)
            New("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Parent = list})
            New("UIPadding", {PaddingTop = UDim.new(0,4), PaddingBottom = UDim.new(0,4), Parent = list})

            for i, v in ipairs(values) do
                local item = New("TextButton", {
                    Size             = UDim2.new(1, 0, 0, itemH),
                    BackgroundColor3 = T.SurfaceAlt,
                    BorderSizePixel  = 0,
                    Text             = v,
                    Font             = v == curVal and Enum.Font.GothamSemibold or Enum.Font.Gotham,
                    TextSize         = 12,
                    TextColor3       = v == curVal and T.Accent or T.Text,
                    TextXAlignment   = Enum.TextXAlignment.Left,
                    AutoButtonColor  = false,
                    ZIndex           = 31,
                    LayoutOrder      = i,
                    Parent           = list,
                })
                New("UIPadding", {PaddingLeft = UDim.new(0, 10), Parent = item})
                item.MouseEnter:Connect(function() Tween(item, {BackgroundColor3 = T.CardHover}, 0.1) end)
                item.MouseLeave:Connect(function() Tween(item, {BackgroundColor3 = T.SurfaceAlt}, 0.1) end)
                item.MouseButton1Click:Connect(function()
                    curVal = v
                    dropBtn.Val.Text = v
                    list.Visible = false
                    isOpen = false
                    arrow.Text = "▾"
                    c.Size = UDim2.new(1, 0, 0, 54)
                    -- Update colors
                    for _, ch in ipairs(list:GetChildren()) do
                        if ch:IsA("TextButton") then
                            ch.TextColor3 = ch.Text == v and T.Accent or T.Text
                            ch.Font = ch.Text == v and Enum.Font.GothamSemibold or Enum.Font.Gotham
                        end
                    end
                    if cfg.Callback then pcall(cfg.Callback, v) end
                end)
            end

            dropBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                list.Visible = isOpen
                arrow.Text   = isOpen and "▴" or "▾"
                Tween(c, {Size = UDim2.new(1, 0, 0, isOpen and (54 + listH + 10) or 54)}, 0.22)
            end)

            dropBtn.MouseEnter:Connect(function() Tween(dropBtn, {BackgroundColor3 = T.CardHover}, 0.15) end)
            dropBtn.MouseLeave:Connect(function() Tween(dropBtn, {BackgroundColor3 = T.SurfaceAlt}, 0.15) end)
        end

        -- Input ───────────────────────────────────────────────────────────────
        function Tab:Input(cfg)
            cfg = cfg or {}
            local isArea = cfg.Type == "Textarea"
            local c = Card(isArea and 104 or 54)
            Labels(c, cfg.Title or "Input", cfg.Desc or "")

            local box = New("TextBox", {
                BackgroundColor3  = T.SurfaceAlt,
                BorderSizePixel   = 0,
                PlaceholderText   = cfg.Placeholder or "",
                Text              = cfg.Value or "",
                Font              = Enum.Font.Gotham,
                TextSize          = 12,
                TextColor3        = T.Text,
                PlaceholderColor3 = T.TextDim,
                ClearTextOnFocus  = false,
                MultiLine         = isArea,
                TextWrapped       = isArea,
                TextXAlignment    = Enum.TextXAlignment.Left,
                TextYAlignment    = isArea and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
                ZIndex            = 7,
                Parent            = c,
            })

            if isArea then
                box.Size     = UDim2.new(1, -24, 0, 52)
                box.Position = UDim2.new(0, 12, 0, 46)
            else
                box.Size     = UDim2.new(0, 145, 0, 28)
                box.Position = UDim2.new(1, -155, 0.5, -14)
            end
            Corner(box, 7)
            local bStroke = Stroke(box, T.Border, 1, 0.3)
            New("UIPadding", {PaddingLeft = UDim.new(0,8), PaddingRight = UDim.new(0,8), Parent = box})

            box.Focused:Connect(function()
                Tween(bStroke, {Color = T.Accent, Transparency = 0}, 0.15)
            end)
            box.FocusLost:Connect(function()
                Tween(bStroke, {Color = T.Border, Transparency = 0.3}, 0.15)
                if cfg.Callback then pcall(cfg.Callback, box.Text) end
            end)
        end

        return Tab
    end -- :Tab()

    return Window
end -- :CreateWindow()

return SNUI
