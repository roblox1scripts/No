-- [[ MEGA HUB V26: SEPARATE SIDEBAR BUTTONS ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

if CoreGui:FindFirstChild("MegaHubV26") then CoreGui.MegaHubV26:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV26"

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

-- --- PET SPAWNER WINDOW ---
local PetWin = Instance.new("Frame", ScreenGui)
PetWin.Size = UDim2.new(0, 380, 0, 340) PetWin.Position = UDim2.new(0.6, 0, 0.3, 0)
PetWin.BackgroundColor3 = Color3.fromRGB(35, 38, 47) PetWin.BorderSizePixel = 2
PetWin.BorderColor3 = Color3.fromRGB(0, 255, 200) PetWin.Visible = false PetWin.Active = true PetWin.Draggable = true
Instance.new("UICorner", PetWin)

local PHead = Instance.new("TextLabel", PetWin)
PHead.Size = UDim2.new(1, 0, 0, 35) PHead.Text = "Pets Spawner" PHead.TextColor3 = Color3.new(1,1,1) PHead.BackgroundTransparency = 1

local PInput = Instance.new("TextBox", PetWin)
PInput.Size = UDim2.new(0.9, 0, 0, 40) PInput.Position = UDim2.new(0.05, 0, 0.15, 0)
PInput.PlaceholderText = "Enter Pet Name" PInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
PInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", PInput)

-- PET TOGGLES (F,R,N,M)
local Selected = {F = false, R = false, N = false, M = false}
local PBtns = {}
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
        for txt, btn in pairs(PBtns) do btn.BackgroundColor3 = Selected[txt] and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(30, 30, 30) end
    end)
end
CreatePToggle("F", Color3.new(0, 0.6, 1)) CreatePToggle("R", Color3.new(1, 0, 0.6)) 
CreatePToggle("N", Color3.new(0, 1, 0.4)) CreatePToggle("M", Color3.new(0.6, 1, 0))

local PSpawn = Instance.new("TextButton", PetWin)
PSpawn.Size = UDim2.new(0.9, 0, 0, 40) PSpawn.Position = UDim2.new(0.05, 0, 0.75, 0)
PSpawn.Text = "Spawn Pet" PSpawn.BackgroundColor3 = Color3.fromRGB(0, 100, 200) PSpawn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", PSpawn)

-- --- TOY SPAWNER WINDOW ---
local ToyWin = Instance.new("Frame", ScreenGui)
ToyWin.Size = UDim2.new(0, 380, 0, 220) ToyWin.Position = UDim2.new(0.6, 0, 0.4, 0)
ToyWin.BackgroundColor3 = Color3.fromRGB(35, 38, 47) ToyWin.BorderSizePixel = 2
ToyWin.BorderColor3 = Color3.fromRGB(0, 255, 200) ToyWin.Visible = false ToyWin.Active = true ToyWin.Draggable = true
Instance.new("UICorner", ToyWin)

local THead = Instance.new("TextLabel", ToyWin)
THead.Size = UDim2.new(1, 0, 0, 35) THead.Text = "Toy Spawner" THead.TextColor3 = Color3.new(1,1,1) THead.BackgroundTransparency = 1

local TInput = Instance.new("TextBox", ToyWin)
TInput.Size = UDim2.new(0.9, 0, 0, 40) TInput.Position = UDim2.new(0.05, 0, 0.25, 0)
TInput.PlaceholderText = "Enter Toy Name" TInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
TInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", TInput)

local TSpawn = Instance.new("TextButton", ToyWin)
TSpawn.Size = UDim2.new(0.9, 0, 0, 40) TSpawn.Position = UDim2.new(0.05, 0, 0.6, 0)
TSpawn.Text = "Spawn Toy" TSpawn.BackgroundColor3 = Color3.fromRGB(200, 100, 0) TSpawn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", TSpawn)

-- --- MAIN HUB (SIDEBAR SEPARATION) ---
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 380) Main.Position = UDim2.new(0.5, -260, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25) Main.Draggable = true Main.Active = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, -40) Side.Position = UDim2.new(0, 0, 0, 40)
Side.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", Side)
local SideLayout = Instance.new("UIListLayout", Side) SideLayout.Padding = UDim.new(0, 10)

local function Nav(txt, icon, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = "  " .. icon .. " " .. txt
    b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.TextXAlignment = Enum.TextXAlignment.Left b.Font = "Gotham"
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
