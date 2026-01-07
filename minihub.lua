-- XHARDXS2 Hub | Sem Speed / Sem Jump | Com minimizar
repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XHARDXS2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 240, 0, 200)
Main.Position = UDim2.new(0, 20, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Parent = Main
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "XHARDXS2"
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

-- CONTENT
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

-- MINIMIZE FUNCTION
local minimized = false
local normalSize = Main.Size

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

-- RESET BUTTON
local ResetBtn = CreateButton("Reset Character", 20)
ResetBtn.MouseButton1Click:Connect(function()
    if Player.Character then
        Player.Character:BreakJoints()
    end
end)

print("XHARDXS2 carregado com sucesso")
