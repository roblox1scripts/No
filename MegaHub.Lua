-- [[ MEGA HUB V10: FULL RESTORATION ]] --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")

if CoreGui:FindFirstChild("MegaHubV10") then CoreGui.MegaHubV10:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV10"

-- --- DRAGGABLE ENGINE ---
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true dragStart = input.Position startPos = frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
end

-- --- 1. THE SPAWNER (RESTORED LOGIC) ---
local Spawner = Instance.new("Frame", ScreenGui)
Spawner.Size = UDim2.new(0, 420, 0, 320)
Spawner.Position = UDim2.new(0.5, -210, 0.3, 0)
Spawner.BackgroundColor3 = Color3.fromRGB(35, 37, 45)
Spawner.BorderSizePixel = 2
Spawner.BorderColor3 = Color3.fromRGB(0, 255, 200)
Spawner.Visible = false
Instance.new("UICorner", Spawner)
MakeDraggable(Spawner)

local SBox = Instance.new("TextBox", Spawner)
SBox.Size = UDim2.new(0.9, 0, 0, 45) SBox.Position = UDim2.new(0.05, 0, 0.2, 0)
SBox.PlaceholderText = "Enter Name to Spawn..." SBox.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
SBox.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", SBox)

local function SpawnLogic()
    local name = SBox.Text
    local found = RS:FindFirstChild(name, true)
    if found and found:IsA("Model") then
        local clone = found:Clone()
        clone.Parent = workspace
        clone:MoveTo(LP.Character.HumanoidRootPart.Position + (LP.Character.HumanoidRootPart.CFrame.LookVector * 5))
    end
end

local SpawnBtn = Instance.new("TextButton", Spawner)
SpawnBtn.Size = UDim2.new(0.9, 0, 0, 45) SpawnBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
SpawnBtn.Text = "Spawn Pet/Toy" SpawnBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SpawnBtn.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", SpawnBtn)
SpawnBtn.MouseButton1Click:Connect(SpawnLogic)

-- --- 2. THE MAIN HUB (Left Side) ---
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 480, 0, 350)
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 22, 25)
Instance.new("UICorner", Main)
MakeDraggable(Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 140, 1, 0)
Side.BackgroundColor3 = Color3.fromRGB(15, 17, 20)
Instance.new("UICorner", Side)
Instance.new("UIListLayout", Side)

local function Nav(txt, cb)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1, 0, 0, 50) b.Text = txt b.TextColor3 = Color3.new(1,1,1) b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(cb)
end

Nav("🐾 Adopt Me", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))()
end)
Nav("🎁 Spawner", function() Spawner.Visible = not Spawner.Visible end)

-- --- 3. MISC MENU (DAISY PRO V2) ---
local Misc = Instance.new("Frame", ScreenGui)
Misc.Size = UDim2.new(0, 220, 0, 280)
Misc.Position = UDim2.new(0.75, 0, 0.2, 0)
Misc.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Misc)
MakeDraggable(Misc)
local mList = Instance.new("UIListLayout", Misc)
mList.Padding = UDim.new(0, 8) mList.HorizontalAlignment = "Center"

local function MBtn(txt, color, cb)
    local b = Instance.new("TextButton", Misc)
    b.Size = UDim2.new(0.9, 0, 0, 40) b.Text = txt
    b.BackgroundColor3 = color b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b) b.MouseButton1Click:Connect(cb)
end
MBtn("Speed Boost (2x)", Color3.fromRGB(50, 150, 50), function() LP.Character.Humanoid.WalkSpeed = 32 end)
MBtn("Infinite Jump: ON", Color3.fromRGB(40, 100, 180), function() 
    UIS.JumpRequest:Connect(function() LP.Character.Humanoid:ChangeState("Jumping") end)
end)
