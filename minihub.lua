-- ======================================
-- XHARDXS2 HUB | STEAL A BRAINROT
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
local savedBaseCFrame = nil

-- ======================================
-- GUI
-- ======================================

local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "XHARDXS2"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 260, 0, 340)
Main.Position = UDim2.new(0, 20, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- TOP BAR
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "XHARDXS2"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextColor3 = Color3.new(1,1,1)

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0.5, -15)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextScaled = true
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,0,0,40)
Content.Size = UDim2.new(1,0,1,-40)
Content.BackgroundTransparency = 1

-- BUTTON CREATOR
local function CreateButton(text, y, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(1,-20,0,35)
    btn.Position = UDim2.new(0,10,0,y)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- MINIMIZE
local minimized = false
local normalSize = Main.Size
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.new(0,260,0,40) or normalSize
    MinBtn.Text = minimized and "+" or "-"
end)

-- ======================================
-- ESP PLAYERS
-- ======================================

CreateButton("ESP Players: OFF", 10, function(btn)
    espPlayers = not espPlayers
    btn.Text = espPlayers and "ESP Players: ON" or "ESP Players: OFF"

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            local h = plr.Character:FindFirstChild("XHARDXS2_ESP_PLAYER")
            if espPlayers and not h then
                h = Instance.new("Highlight")
                h.Name = "XHARDXS2_ESP_PLAYER"
                h.FillColor = Color3.fromRGB(0,255,0)
                h.Parent = plr.Character
            elseif not espPlayers and h then
                h:Destroy()
            end
        end
    end
end)

-- ======================================
-- ESP BASE / OBJETOS (CORRIGIDO)
-- ======================================

local function applyBaseESP()
    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            local name = obj.Name:lower()

            if name:find("base") or name:find("brainrot") then
                if espBase and not obj:FindFirstChild("XHARDXS2_ESP_BASE") then
                    local h = Instance.new("Highlight")
                    h.Name = "XHARDXS2_ESP_BASE"
                    h.FillColor = Color3.fromRGB(0,150,255)
                    h.OutlineColor = Color3.new(0,0,0)
                    h.Parent = obj
                end
            end
        end
    end
end

CreateButton("ESP Base/Objetos: OFF", 55, function(btn)
    espBase = not espBase
    btn.Text = espBase and "ESP Base/Objetos: ON" or "ESP Base/Objetos: OFF"

    if espBase then
        applyBaseESP()
    else
        for _,obj in ipairs(workspace:GetDescendants()) do
            local h = obj:FindFirstChild("XHARDXS2_ESP_BASE")
            if h then h:Destroy() end
        end
    end
end)

-- ======================================
-- SALVAR BASE
-- ======================================

CreateButton("Salvar Base", 100, function()
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        savedBaseCFrame = hrp.CFrame
    end
end)

-- ======================================
-- AUTO TP BASE ON / OFF
-- ======================================

CreateButton("Auto TP Base: OFF", 145, function(btn)
    autoTpBase = not autoTpBase
    btn.Text = autoTpBase and "Auto TP Base: ON" or "Auto TP Base: OFF"
end)

local function teleportWithCarpet()
    if not autoTpBase or not savedBaseCFrame then return end

    local char = Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local carpet = Instance.new("Part")
    carpet.Size = Vector3.new(6,0.4,6)
    carpet.Anchored = true
    carpet.CanCollide = true
    carpet.Material = Enum.Material.Neon
    carpet.Color = Color3.fromRGB(0,150,255)
    carpet.CFrame = hrp.CFrame * CFrame.new(0,-3,0)
    carpet.Parent = workspace

    hrp.Anchored = true

    TweenService:Create(
        carpet,
        TweenInfo.new(1.6, Enum.EasingStyle.Linear),
        {CFrame = savedBaseCFrame * CFrame.new(0,-3,0)}
    ):Play()

    task.wait(1.6)

    hrp.CFrame = savedBaseCFrame
    hrp.Anchored = false
    carpet:Destroy()
end

-- DETECTA BRAINROT INVISÍVEL
local function watchBrainrot(char)
    char.DescendantAdded:Connect(function(obj)
        if autoTpBase and (obj:IsA("Weld") or obj:IsA("WeldConstraint") or obj:IsA("Motor6D")) then
            task.wait(0.15)
            teleportWithCarpet()
        end
    end)
end

if Player.Character then
    watchBrainrot(Player.Character)
end
Player.CharacterAdded:Connect(watchBrainrot)

-- ======================================
-- RESET
-- ======================================

CreateButton("Reset Character", 190, function()
    if Player.Character then
        Player.Character:BreakJoints()
    end
end)

print("XHARDXS2 carregado com sucesso")
