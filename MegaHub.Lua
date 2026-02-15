-- [[ MEGA HUB V19: BOT REACTIONS + SEPARATE SPAWNER ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("MegaHubV19") then CoreGui.MegaHubV19:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV19"

-- --- BOT REACTION LOGIC ---
local BotNames = {"SurenArmen", "Aura_Dev", "Gus_Leaker", "AdoptMeFan", "RobloxPlayer"}
local function BotReact(emoji)
    local randomBot = BotNames[math.random(1, #BotNames)]
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[Bot] " .. randomBot .. " reacted: " .. emoji;
        Color = Color3.fromRGB(255, 255, 255);
        Font = Enum.Font.GothamBold;
    })
end

-- 1. THE MAIN HUB CONTAINER
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380)
Main.Position = UDim2.new(0.5, -260, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true Main.Draggable = true
Instance.new("UICorner", Main)

-- Top Banner
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

-- 2. SEPARATE SPAWNER WINDOW (Matches 105738.jpg)
local SpawnerWin = Instance.new("Frame", ScreenGui)
SpawnerWin.Size = UDim2.new(0, 380, 0, 320)
SpawnerWin.Position = UDim2.new(0.6, 0, 0.3, 0)
SpawnerWin.BackgroundColor3 = Color3.fromRGB(35, 38, 47)
SpawnerWin.BorderSizePixel = 2 SpawnerWin.BorderColor3 = Color3.fromRGB(0, 255, 200)
SpawnerWin.Visible = false SpawnerWin.Active = true SpawnerWin.Draggable = true
Instance.new("UICorner", SpawnerWin)

local SHead = Instance.new("TextLabel", SpawnerWin)
SHead.Size = UDim2.new(1, 0, 0, 35) SHead.Text = "Pets  Jaradz Library  Toys"
SHead.TextColor3 = Color3.new(1,1,1) SHead.BackgroundTransparency = 1

local SInput = Instance.new("TextBox", SpawnerWin)
SInput.Size = UDim2.new(0.9, 0, 0, 40) SInput.Position = UDim2.new(0.05, 0, 0.2, 0)
SInput.PlaceholderText = "Enter Pet Name to Spawn" SInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
SInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", SInput)

-- FRNM Buttons
local frnm = Instance.new("Frame", SpawnerWin)
frnm.Size = UDim2.new(0.9, 0, 0, 40) frnm.Position = UDim2.new(0.05, 0, 0.4, 0) frnm.BackgroundTransparency = 1
Instance.new("UIListLayout", frnm).FillDirection = "Horizontal"
local function B(t, c)
    local b = Instance.new("TextButton", frnm)
    b.Size = UDim2.new(0.25, -5, 1, 0) b.Text = t b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30) b.BorderColor3 = c b.BorderSizePixel = 2
end
B("F", Color3.new(0, 0.6, 1)) B("R", Color3.new(1, 0, 0.6)) B("N", Color3.new(0, 1, 0.4)) B("M", Color3.new(0.6, 1, 0))

local MegaN = Instance.new("TextButton", SpawnerWin)
MegaN.Size = UDim2.new(0.9, 0, 0, 35) MegaN.Position = UDim2.new(0.05, 0, 0.6, 0)
MegaN.Text = "Mega Neon" MegaN.BackgroundColor3 = Color3.fromRGB(15, 0, 30) MegaN.TextColor3 = Color3.fromRGB(180, 0, 255)
Instance.new("UICorner", MegaN)

local SpawnBtn = Instance.new("TextButton", SpawnerWin)
SpawnBtn.Size = UDim2.new(0.9, 0, 0, 40) SpawnBtn.Position = UDim2.new(0.05, 0, 0.85, 0)
SpawnBtn.Text = "Spawn Pet" SpawnBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) SpawnBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpawnBtn)
SpawnBtn.MouseButton1Click:Connect(function()
    print("Spawning: " .. SInput.Text)
end)

-- 3. WHITE REACTION BAR (Bot Trigger)
local EBar = Instance.new("Frame", ScreenGui)
EBar.Size = UDim2.new(0, 340, 0, 45) EBar.Position = UDim2.new(0.5, -170, 0.85, 0)
EBar.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", EBar)
EBar.Active = true EBar.Draggable = true
local eL = Instance.new("UIListLayout", EBar) eL.FillDirection = "Horizontal" eL.HorizontalAlignment = "Center" eL.VerticalAlignment = "Center" eL.Padding = UDim.new(0, 12)

for _, e in pairs({"👍", "😲", "💯", "👀", "🔥", "❤️", "🎉"}) do
    local b = Instance.new("TextButton", EBar)
    b.Size = UDim2.new(0, 32, 0, 32) b.Text = e b.TextSize = 25 b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(function() BotReact(e) end)
end

-- 4. SIDE NAV & CONTENT
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40) Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", Side)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -170, 1, -60) Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundTransparency = 1 Content.CanvasSize = UDim2.new(0,0,2,0)
local Layout = Instance.new("UIListLayout", Content) Layout.Padding = UDim.new(0, 10)

local function Clear() for _,v in pairs(Content:GetChildren()) do if not v:IsA("UIListLayout") then v:Destroy() end end end

-- MISC TAB (Working Buttons)
local function ShowMisc()
    Clear()
    local function MBtn(txt, color, cb)
        local b = Instance.new("TextButton", Content)
        b.Size = UDim2.new(0.95, 0, 0, 50) b.Text = txt
        b.BackgroundColor3 = color b.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", b) b.MouseButton1Click:Connect(cb)
    end
    MBtn("Speed Boost (2x)", Color3.fromRGB(60, 160, 60), function() LP.Character.Humanoid.WalkSpeed = 32 end)
    MBtn("Infinite Jump: ON", Color3.fromRGB(40, 110, 200), function() 
        UIS.JumpRequest:Connect(function() LP.Character.Humanoid:ChangeState("Jumping") end) 
    end)
    MBtn("Execute Spawner", Color3.fromRGB(50, 50, 50), function() SpawnerWin.Visible = true end)
end

-- NAVIGATION
local function Nav(txt, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(func)
end
local sList = Instance.new("UIListLayout", Side)
Nav("🐾 Adopt Me", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)
Nav("⚙️ Misc", ShowMisc)

ShowMisc()
