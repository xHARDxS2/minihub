-- ==============================
-- MINI HUB FINAL
-- ==============================

-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer

-- ==============================
-- VARIÁVEIS
-- ==============================

local espPlayersOn = false
local espBrainrotOn = false
local espBaseOn = false

local jumpOn = false
local autoTpOn = false

local savedBaseCFrame = nil
local baseMarker
local baseBeam

-- ==============================
-- ANTI AFK
-- ==============================

Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ==============================
-- GUI
-- ==============================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiniHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 260, 0, 360)
Main.Position = UDim2.new(0.5, -130, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(30,30,30)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "MiniHub Final"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.TextScaled = true

-- Função botão
local function createButton(text, posY, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- ==============================
-- INFINITE JUMP SEGURO
-- ==============================

createButton("Infinite Jump: OFF", 50, function(btn)
    jumpOn = not jumpOn
    btn.Text = jumpOn and "Infinite Jump: ON" or "Infinite Jump: OFF"
end)

UserInputService.JumpRequest:Connect(function()
    if jumpOn then
        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Landed)
        end
    end
end)

-- ==============================
-- SALVAR BASE + MARCADOR
-- ==============================

createButton("Salvar Base", 90, function()
    local char = Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    savedBaseCFrame = hrp.CFrame

    if baseMarker then baseMarker:Destroy() end

    local sphere = Instance.new("Part")
    sphere.Shape = Enum.PartType.Ball
    sphere.Size = Vector3.new(1,1,1)
    sphere.Position = hrp.Position - Vector3.new(0,2.5,0)
    sphere.Anchored = true
    sphere.CanCollide = false
    sphere.Material = Enum.Material.Neon
    sphere.Color = Color3.fromRGB(0,150,255)
    sphere.Name = "BaseMarker"
    sphere.Parent = workspace

    local att0 = Instance.new("Attachment", sphere)
    local att1 = Instance.new("Attachment", sphere)
    att1.Position = Vector3.new(0,6,0)

    local beam = Instance.new("Beam")
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam.Width0 = 0.1
    beam.Width1 = 0.1
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(Color3.fromRGB(0,150,255))
    beam.Parent = sphere

    baseMarker = sphere
    baseBeam = beam
end)

-- ==============================
-- AUTO TP BRAINROT (INVISÍVEL)
-- ==============================

createButton("Auto TP Brainrot: OFF", 130, function(btn)
    autoTpOn = not autoTpOn
    btn.Text = autoTpOn and "Auto TP Brainrot: ON" or "Auto TP Brainrot: OFF"
end)

local function tryTeleportBrainrot()
    if not autoTpOn or not savedBaseCFrame then return end
    task.wait(0.1)
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = savedBaseCFrame
    end
end

local function watchBrainrot(char)
    local rightHand = char:FindFirstChild("RightHand", true)
    local leftHand  = char:FindFirstChild("LeftHand", true)

    char.DescendantAdded:Connect(function(obj)
        if obj:IsA("Weld") or obj:IsA("WeldConstraint") or obj:IsA("Motor6D") then
            if (rightHand and (obj.Part0 == rightHand or obj.Part1 == rightHand))
            or (leftHand and (obj.Part0 == leftHand or obj.Part1 == leftHand)) then
                tryTeleportBrainrot()
            end
        end
    end)
end

if Player.Character then
    watchBrainrot(Player.Character)
end
Player.CharacterAdded:Connect(watchBrainrot)

-- ==============================
-- ESP PLAYERS
-- ==============================

createButton("ESP Players: OFF", 170, function(btn)
    espPlayersOn = not espPlayersOn
    btn.Text = espPlayersOn and "ESP Players: ON" or "ESP Players: OFF"

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            local h = plr.Character:FindFirstChildOfClass("Highlight")
            if espPlayersOn and not h then
                h = Instance.new("Highlight", plr.Character)
                h.FillColor = Color3.fromRGB(0,255,0)
            elseif not espPlayersOn and h then
                h:Destroy()
            end
        end
    end
end)

-- ==============================
-- ESP BRAINROT
-- ==============================

createButton("ESP Brainrot: OFF", 210, function(btn)
    espBrainrotOn = not espBrainrotOn
    btn.Text = espBrainrotOn and "ESP Brainrot: ON" or "ESP Brainrot: OFF"

    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency > 0.8 then
            v.Material = espBrainrotOn and Enum.Material.Neon or Enum.Material.Plastic
            v.Color = Color3.fromRGB(255,0,0)
        end
    end
end)

-- ==============================
-- ESP BASE TIMER
-- ==============================

createButton("ESP Base Timer: OFF", 250, function(btn)
    espBaseOn = not espBaseOn
    btn.Text = espBaseOn and "ESP Base Timer: ON" or "ESP Base Timer: OFF"

    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("TextLabel") and v.Text:match("%d") then
            v.Visible = espBaseOn
            v.TextColor3 = Color3.fromRGB(255,255,0)
            v.TextStrokeTransparency = 0
        end
    end
end)

print("MiniHub carregado com sucesso")
