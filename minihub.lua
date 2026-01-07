-- MiniHub base funcional (Delta / Mobile)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

print("MiniHub carregado com sucesso")

Player.CharacterAdded:Connect(function()
    print("Personagem carregado")
end)

-- GUI teste
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiniHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = ScreenGui
TextLabel.Size = UDim2.new(0, 300, 0, 50)
TextLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
TextLabel.Text = "MiniHub Funcionando ✅"
TextLabel.BackgroundColor3 = Color3.fromRGB(30,30,30)
TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
TextLabel.TextScaled = true
