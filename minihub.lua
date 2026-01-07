# minihub
By xHARDxS2 
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MiniHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 200)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local function makeBtn(text, y)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -20, 0, 30)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.BorderSizePixel = 0
    return b
end

local speedOn = false
local speedBtn = makeBtn("Speed: OFF", 10)
speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedBtn.Text = "Speed: "..(speedOn and "ON" or "OFF")
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedOn and 28 or 16
    end
end)

local jumpOn = false
local jumpBtn = makeBtn("Jump: OFF", 50)
jumpBtn.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    jumpBtn.Text = "Jump: "..(jumpOn and "ON" or "OFF")
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = jumpOn and 65 or 50
    end
end)

local espBtn = makeBtn("ESP Brainrot", 90)
espBtn.MouseButton1Click:Connect(function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("brain") then
            v.Material = Enum.Material.Neon
            v.Color = Color3.fromRGB(255,0,0)
            v.Transparency = 0
        end
    end
end)

local resetBtn = makeBtn("Reset", 130)
resetBtn.MouseButton1Click:Connect(function()
    LocalPlayer.Character:BreakJoints()
end)
