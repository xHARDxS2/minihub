-- MiniHub v1 | Delta / Mobile | Com botão minimizar

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiniHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 240, 0, 260)
Main.Position = UDim2.new(0, 20, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- TITLE BAR
local TopBar = Instance.new("Frame")
TopBar.Parent = Main
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MiniHub v1"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- MINIMIZE BUTTON
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TopBar
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0.5, -15)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextScaled = true
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- CONTENT FRAME
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.new(0, 0, 0, 40)
Content.Size = UDim2.new(1, 0, 1, -40)
Content.BackgroundTransparency = 1

-- BUTTON CREATOR
local function CreateButton(text, y)
    local btn = Instance.new("TextButton")
    btn.Parent = Content
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- VARIABLES
local speedOn = false
local jumpOn = false
local minimized = false
local normalSize = Main.Size

-- MINIMIZE FUNCTION
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Content.Visible = false
        Main.Size = UDim2.new(0, 240, 0, 40)
        MinBtn.Text = "+"
    else
        Content.Visible = true
        Main.Size = normalSize
        MinBtn.Text = "-"
    end
end)

-- SPEED BUTTON
local SpeedBtn = CreateButton("Speed: OFF", 10)
SpeedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    SpeedBtn.Text = "Speed: "..(speedOn and "ON" or "OFF")
    local hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = speedOn and 28 or 16
    end
end)

-- JUMP BUTTON
local JumpBtn = CreateButton("Jump: OFF", 55)
JumpBtn.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    JumpBtn.Text = "Jump: "..(jumpOn and "ON" or "OFF")
    local hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if hum then
        hum.JumpPower = jumpOn and 65 or 50
    end
end)

-- RESET BUTTON
local ResetBtn = CreateButton("Reset Character", 100)
ResetBtn.MouseButton1Click:Connect(function()
    Player.Character:BreakJoints()
end)

print("MiniHub v1 carregado com botão minimizar")
