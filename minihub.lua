-- ======================================
-- XHARDXS2 HUB | STEAL A BRAINROT (FIXED)
-- ======================================

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- VARIÁVEIS
local espPlayers = false
local espBase = false
local autoTpBase = false
local savedBaseCFrame

-- ======================================
-- GUI
-- ======================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XHARDXS2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,260,0,340)
Main.Position = UDim2.new(0,20,0.3,0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1,0,0,40)
TopBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "XHARDXS2"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextColor3 = Color3.new(1,1,1)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0,30,0,30)
MinBtn.Position = UDim2.new(1,-35,0.5,-15)
MinBtn.Text = "-"
MinBtn.TextScaled = true
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0,8)

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,0,0,40)
Content.Size = UDim2.new(1,0,1,-40)
Content.BackgroundTransparency = 1

-- BOTÕES
local function Button(text,y,callback)
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(1,-20,0,35)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

-- MINIMIZAR
local minimized = false
local normalSize = Main.Size
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.new(0,260,0,40) or normalSize
    MinBtn.Text = minimized and "+" or "-"
end)

-- ======================================
-- ESP PLAYERS (ATUALIZA SOZINHO)
-- ======================================

local function applyPlayerESP(char)
    if not espPlayers then return end
    if not char:FindFirstChild("XHARDXS2_PLAYER") then
        local h = Instance.new("Highlight")
        h.Name = "XHARDXS2_PLAYER"
        h.FillColor = Color3.fromRGB(0,255,0)
        h.OutlineColor = Color3.new(0,0,0)
        h.Parent = char
    end
end

local function removePlayerESP(char)
    local h = char:FindFirstChild("XHARDXS2_PLAYER")
    if h then h:Destroy() end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(applyPlayerESP)
end)

Button("ESP Players: OFF",10,function(b)
    espPlayers = not espPlayers
    b.Text = espPlayers and "ESP Players: ON" or "ESP Players: OFF"
    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            if espPlayers then
                applyPlayerESP(plr.Character)
            else
                removePlayerESP(plr.Character)
            end
        end
    end
end)

-- ======================================
-- ESP BASE / OBJETOS (TEMPO REAL)
-- ======================================

local function applyBaseESP(obj)
    if not espBase then return end
    if (obj:IsA("Model") or obj:IsA("Part")) and not obj:FindFirstChild("XHARDXS2_BASE") then
        local h = Instance.new("Highlight")
        h.Name = "XHARDXS2_BASE"
        h.FillColor = Color3.fromRGB(0,150,255)
        h.OutlineColor = Color3.new(0,0,0)
        h.Parent = obj
    end
end

local function removeBaseESP(obj)
    local h = obj:FindFirstChild("XHARDXS2_BASE")
    if h then h:Destroy() end
end

workspace.DescendantAdded:Connect(function(obj)
    if espBase then
        applyBaseESP(obj)
    end
end)

Button("ESP Base/Objetos: OFF",55,function(b)
    espBase = not espBase
    b.Text = espBase and "ESP Base/Objetos: ON" or "ESP Base/Objetos: OFF"
    for _,obj in pairs(workspace:GetDescendants()) do
        if espBase then
            applyBaseESP(obj)
        else
            removeBaseESP(obj)
        end
    end
end)

-- ======================================
-- SALVAR BASE
-- ======================================

Button("Salvar Base",100,function()
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        savedBaseCFrame = hrp.CFrame
    end
end)

-- ======================================
-- AUTO TP BASE ON / OFF
-- ======================================

Button("Auto TP Base: OFF",145,function(b)
    autoTpBase = not autoTpBase
    b.Text = autoTpBase and "Auto TP Base: ON" or "Auto TP Base: OFF"
end)

-- ======================================
-- RESET
-- ======================================

Button("Reset Character",190,function()
    if Player.Character then
        Player.Character:BreakJoints()
    end
end)

print("XHARDXS2 carregado e ESPs atualizando corretamente")
