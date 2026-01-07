--==================================================
-- MINI HUB FINAL | DELTA / MOBILE
-- AntiKick + AntiAFK + ESP + Auto TP Brainrot
--==================================================

repeat task.wait() until game:IsLoaded()

--==================== ANTI KICK ====================
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall

    mt.__namecall = newcclosure(function(self, ...)
        if getnamecallmethod() == "Kick" then
            warn("[ANTI-KICK] Kick bloqueado")
            return
        end
        return old(self, ...)
    end)

    setreadonly(mt, true)
    game.Players.LocalPlayer.Kick = function()
        warn("[ANTI-KICK] Kick direto bloqueado")
    end
end)

--==================== ANTI AFK =====================
pcall(function()
    local Players = game:GetService("Players")
    local VirtualUser = game:GetService("VirtualUser")
    local Player = Players.LocalPlayer

    Player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

--==================== SERVICES =====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

--==================== CONFIG =======================
local BRAINROT_KEYWORD = "brain"

--==================== STATES =======================
local speedOn = false
local jumpOn = false
local autoTpOn = false

local espBrainrotOn = false
local espPlayersOn = false
local espBaseOn = false

local savedBaseCFrame = nil

--==================== GUI ==========================
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "MiniHub"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 260, 0, 460)
Main.Position = UDim2.new(0, 20, 0.25, 0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,40)
Top.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.Text = "MiniHub"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0,30,0,30)
MinBtn.Position = UDim2.new(1,-35,0.5,-15)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextScaled = true
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MinBtn)

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,0,0,40)
Content.Size = UDim2.new(1,0,1,-40)
Content.BackgroundTransparency = 1

local minimized = false
local normalSize = Main.Size

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Main.Size = minimized and UDim2.new(0,260,0,40) or normalSize
    MinBtn.Text = minimized and "+" or "-"
end)

local function Button(text, y)
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(1,-20,0,34)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b)
    return b
end

--==================== SPEED 20 =====================
local SpeedBtn = Button("Speed 20: OFF", 10)
SpeedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    SpeedBtn.Text = "Speed 20: "..(speedOn and "ON" or "OFF")
end)

RunService.Heartbeat:Connect(function()
    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if hum and speedOn then
        hum.WalkSpeed = 20
    end
end)

--==================== INFINITE JUMP =================
local JumpBtn = Button("Infinite Jump: OFF", 50)
JumpBtn.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    JumpBtn.Text = "Infinite Jump: "..(jumpOn and "ON" or "OFF")
end)

UserInputService.JumpRequest:Connect(function()
    if jumpOn then
        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

--==================== SAVE BASE ====================
Button("Salvar Base", 90).MouseButton1Click:Connect(function()
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        savedBaseCFrame = hrp.CFrame
        warn("Base salva")
    end
end)

--==================== AUTO TP ======================
local AutoTpBtn = Button("Auto TP Brainrot: OFF", 130)
AutoTpBtn.MouseButton1Click:Connect(function()
    autoTpOn = not autoTpOn
    AutoTpBtn.Text = "Auto TP Brainrot: "..(autoTpOn and "ON" or "OFF")
end)

local function checkBrainrot(tool)
    if tool:IsA("Tool") and tool.Name:lower():find(BRAINROT_KEYWORD) then
        if autoTpOn and savedBaseCFrame then
            task.wait(0.15)
            local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = savedBaseCFrame
            end
        end
    end
end

Player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(checkBrainrot)
end)
if Player.Character then
    Player.Character.ChildAdded:Connect(checkBrainrot)
end

--==================== ESP BRAINROT =================
local EspBrainBtn = Button("ESP Brainrot: OFF", 170)
EspBrainBtn.MouseButton1Click:Connect(function()
    espBrainrotOn = not espBrainrotOn
    EspBrainBtn.Text = "ESP Brainrot: "..(espBrainrotOn and "ON" or "OFF")

    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find(BRAINROT_KEYWORD) then
            v.Material = espBrainrotOn and Enum.Material.Neon or Enum.Material.Plastic
            v.Color = Color3.fromRGB(255,0,0)
        end
    end
end)

--==================== ESP PLAYERS ==================
local EspPlayerBtn = Button("ESP Players: OFF", 210)
EspPlayerBtn.MouseButton1Click:Connect(function()
    espPlayersOn = not espPlayersOn
    EspPlayerBtn.Text = "ESP Players: "..(espPlayersOn and "ON" or "OFF")

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            if espPlayersOn then
                if not hrp:FindFirstChild("ESP_BOX") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "ESP_BOX"
                    box.Adornee = hrp
                    box.Size = Vector3.new(4,6,4)
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Transparency = 0.5
                    box.Color3 = Color3.fromRGB(0,255,0)
                    box.Parent = hrp
                end
            else
                if hrp:FindFirstChild("ESP_BOX") then
                    hrp.ESP_BOX:Destroy()
                end
            end
        end
    end
end)

--==================== ESP BASE =====================
local EspBaseBtn = Button("ESP Base Timer: OFF", 250)
EspBaseBtn.MouseButton1Click:Connect(function()
    espBaseOn = not espBaseOn
    EspBaseBtn.Text = "ESP Base Timer: "..(espBaseOn and "ON" or "OFF")

    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            if espBaseOn then
                v.RequiresLineOfSight = false
                v.Enabled = true
            end
        end
    end
end)

print("MiniHub FINAL carregado com sucesso")
