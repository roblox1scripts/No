-- [[ MEGA HUB V25: UNIFIED SPAWNER (PETS + TOYS) ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("MegaHubV25") then CoreGui.MegaHubV25:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV25"

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

-- --- UNIFIED SPAWNER WINDOW (Pets & Toys) ---
local SpawnerWin = Instance.new("Frame", ScreenGui)
SpawnerWin.Size = UDim2.new(0, 380, 0, 340)
SpawnerWin.Position = UDim2.new(0.6, 0, 0.3, 0)
SpawnerWin.BackgroundColor3 = Color3.fromRGB(35, 38, 47)
SpawnerWin.BorderSizePixel = 2 SpawnerWin.BorderColor3 = Color3.fromRGB(0, 255, 200)
SpawnerWin.Visible = false SpawnerWin.Active = true SpawnerWin.Draggable = true
Instance.new("UICorner", SpawnerWin)

-- Tab Headers
local TabContainer = Instance.new("Frame", SpawnerWin)
TabContainer.Size = UDim2.new(1, 0, 0, 35) TabContainer.BackgroundTransparency = 1
local TabLayout = Instance.new("UIListLayout", TabContainer) TabLayout.FillDirection = "Horizontal"

local function CreateHeader(txt)
    local l = Instance.new("TextButton", TabContainer)
    l.Size = UDim2.new(0.33, 0, 1, 0) l.Text = txt
    l.TextColor3 = Color3.new(1,1,1) l.BackgroundTransparency = 1
    l.Font = "GothamBold" l.TextSize = 14
    return l
end

local PetTabBtn = CreateHeader("Pets")
local LibraryTabBtn = CreateHeader("Library")
local ToyTabBtn = CreateHeader("Toys")

-- Content Areas
local PetContent = Instance.new("Frame", SpawnerWin)
PetContent.Size = UDim2.new(1, 0, 1, -35) PetContent.Position = UDim2.new(0, 0, 0, 35)
PetContent.BackgroundTransparency = 1

local ToyContent = Instance.new("Frame", SpawnerWin)
ToyContent.Size = UDim2.new(1, 0, 1, -35) ToyContent.Position = UDim2.new(0, 0, 0, 35)
ToyContent.BackgroundTransparency = 1 ToyContent.Visible = false

-- --- PET TAB SETUP ---
local SInput = Instance.new("TextBox", PetContent)
SInput.Size = UDim2.new(0.9, 0, 0, 40) SInput.Position = UDim2.new(0.05, 0, 0.1, 0)
SInput.PlaceholderText = "Enter Pet Name to Spawn" SInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
SInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", SInput)

local Selected = {F = false, R = false, N = false, M = false}
local Btns = {}
local frnm = Instance.new("Frame", PetContent)
frnm.Size = UDim2.new(0, 340, 0, 40) frnm.Position = UDim2.new(0.05, 0, 0.3, 0) frnm.BackgroundTransparency = 1
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
        for txt, btn in pairs(Btns) do btn.BackgroundColor3 = Selected[txt] and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(30, 30, 30) end
    end)
end
CreateToggle("F", Color3.new(0, 0.6, 1)) CreateToggle("R", Color3.new(1, 0, 0.6)) 
CreateToggle("N", Color3.new(0, 1, 0.4)) CreateToggle("M", Color3.new(0.6, 1, 0))

local SpawnPetBtn = Instance.new("TextButton", PetContent)
SpawnPetBtn.Size = UDim2.new(0.9, 0, 0, 40) SpawnPetBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
SpawnPetBtn.Text = "Spawn Pet" SpawnPetBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) SpawnPetBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpawnPetBtn)

-- --- TOY TAB SETUP ---
local TInput = Instance.new("TextBox", ToyContent)
TInput.Size = UDim2.new(0.9, 0, 0, 40) TInput.Position = UDim2.new(0.05, 0, 0.1, 0)
TInput.PlaceholderText = "Enter Toy Name to Spawn" TInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
TInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", TInput)

local SpawnToyBtn = Instance.new("TextButton", ToyContent)
SpawnToyBtn.Size = UDim2.new(0.9, 0, 0, 40) SpawnToyBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
SpawnToyBtn.Text = "Spawn Toy" SpawnToyBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0) SpawnToyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpawnToyBtn)

-- Tab Switching Logic
PetTabBtn.MouseButton1Click:Connect(function() PetContent.Visible = true ToyContent.Visible = false end)
ToyTabBtn.MouseButton1Click:Connect(function() PetContent.Visible = false ToyContent.Visible = true end)

-- --- MAIN HUB (SIDEBAR FIX) ---
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380) Main.Position = UDim2.new(0.5, -260, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25) Main.Draggable = true Main.Active = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40) Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", Side)
local SideLayout = Instance.new("UIListLayout", Side) SideLayout.Padding = UDim.new(0, 10)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -170, 1, -60) Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundTransparency = 1 Instance.new("UIListLayout", Content).Padding = UDim.new(0,10)

local function Nav(txt, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = "  " .. txt
    b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.MouseButton1Click:Connect(func)
end

Nav("🐾 Adopt Me", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)
Nav("⚙️ Misc", function() 
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
