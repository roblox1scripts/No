-- [[ MEGA HUB V4: FULL RESTORATION ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. MAIN UI
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV4"

-- 2. DUAL REACTION BARS
local function CreateBars()
    local SBar = Instance.new("Frame", ScreenGui)
    SBar.Size = UDim2.new(0, 280, 0, 45)
    SBar.Position = UDim2.new(0.5, -140, 0.78, 0)
    SBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", SBar)
    local sL = Instance.new("UIListLayout", SBar)
    sL.FillDirection = "Horizontal" sL.HorizontalAlignment = "Center" sL.VerticalAlignment = "Center" sL.Padding = UDim.new(0, 10)

    for _, e in pairs({"👋", "🤔", "🤝", "➕", "➖", "❌"}) do
        local b = Instance.new("TextButton", SBar)
        b.Size = UDim2.new(0, 32, 0, 32)
        b.Text = e b.TextSize = 22 b.BackgroundTransparency = 1
    end

    local EBar = Instance.new("Frame", ScreenGui)
    EBar.Size = UDim2.new(0, 320, 0, 40)
    EBar.Position = UDim2.new(0.5, -160, 0.85, 0)
    EBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", EBar)
    local eL = Instance.new("UIListLayout", EBar)
    eL.FillDirection = "Horizontal" eL.HorizontalAlignment = "Center" eL.VerticalAlignment = "Center" eL.Padding = UDim.new(0, 12)

    for _, e in pairs({"👍", "😲", "💯", "👀", "🔥", "❤️", "🎉"}) do
        local b = Instance.new("TextButton", EBar)
        b.Size = UDim2.new(0, 30, 0, 30)
        b.Text = e b.TextSize = 22 b.BackgroundTransparency = 1
    end
end
CreateBars()

-- 3. THE HUB MENU
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 360)
Main.Position = UDim2.new(0.5, -250, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
Main.Active = true Main.Draggable = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, 0)
Side.BackgroundColor3 = Color3.fromRGB(15, 17, 20)
Instance.new("UICorner", Side)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -165, 1, -20)
Content.Position = UDim2.new(0, 155, 0, 10)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0,0,1.5,0)
Content.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

local function Clear() for _,v in pairs(Content:GetChildren()) do if not v:IsA("UIListLayout") then v:Destroy() end end end

-- --- DASHBOARD (Stats) ---
local function ShowDashboard()
    Clear()
    local function Stat(title, desc, color)
        local f = Instance.new("Frame", Content)
        f.Size = UDim2.new(0.95, 0, 0, 60)
        f.BackgroundColor3 = color
        Instance.new("UICorner", f)
        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1,-20,1,0) t.Position = UDim2.new(0,10,0,0)
        t.Text = "<b>"..title.."</b>\n"..desc
        t.RichText = true t.TextColor3 = Color3.new(1,1,1) t.BackgroundTransparency = 1 t.TextXAlignment = "Left"
    end
    Stat("SERVER INFO", "Players: "..#Players:GetPlayers().."\nJobId: "..game.JobId, Color3.fromRGB(0, 120, 215))
end

-- --- SPAWNER (Restored Functional Spawner) ---
local function ShowSpawner()
    Clear()
    local i = Instance.new("TextBox", Content)
    i.Size = UDim2.new(0.95, 0, 0, 40) i.PlaceholderText = "Enter Pet/Toy Name..."
    i.BackgroundColor3 = Color3.fromRGB(40,40,40) i.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", i)

    -- FRNM Bar
    local btnF = Instance.new("Frame", Content)
    btnF.Size = UDim2.new(0.95, 0, 0, 40) btnF.BackgroundTransparency = 1
    Instance.new("UIListLayout", btnF).FillDirection = "Horizontal"
    local function Prop(txt, color)
        local b = Instance.new("TextButton", btnF)
        b.Size = UDim2.new(0.25, -5, 1, 0) b.Text = txt
        b.BackgroundColor3 = Color3.fromRGB(30,30,30) b.BorderColor3 = color b.BorderSizePixel = 2
        b.TextColor3 = Color3.new(1,1,1)
    end
    Prop("F", Color3.new(0,0.5,1)) Prop("R", Color3.new(1,0,0.5)) Prop("N", Color3.new(0,1,0)) Prop("M", Color3.new(0.5,1,0))

    local spawn = Instance.new("TextButton", Content)
    spawn.Size = UDim2.new(0.95, 0, 0, 40) spawn.Text = "Spawn Pet (Local Only)"
    spawn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) spawn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", spawn)
    
    spawn.MouseButton1Click:Connect(function()
        local name = i.Text
        local found = game:GetService("ReplicatedStorage"):FindFirstChild(name, true)
        if found and found:IsA("Model") then
            local clone = found:Clone()
            clone.Parent = workspace
            clone:MoveTo(LP.Character.HumanoidRootPart.Position + (LP.Character.HumanoidRootPart.CFrame.LookVector * 5))
        end
    end)
end

-- --- ADOPT ME (Launcher) ---
local function ShowAdoptMe()
    Clear()
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(0.95, 0, 0, 50) b.Text = "▶ Launch Fake Trade Script"
    b.BackgroundColor3 = Color3.fromRGB(0, 180, 100) b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))()
    end)
end

-- SIDEBAR NAV
local function Nav(txt, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(func)
end
local sL = Instance.new("UIListLayout", Side)
Nav("📊 Dashboard", ShowDashboard)
Nav("🐾 Adopt Me", ShowAdoptMe)
Nav("🎁 Spawner", ShowSpawner)
Nav("⚙️ Misc", function() end)

ShowDashboard()
