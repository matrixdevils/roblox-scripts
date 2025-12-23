-- ULTIMATE HACK MENU V1
-- ESP, Speed, Fly, Noclip, Teleport

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- حذف GUI قديم
for _, gui in pairs(player.PlayerGui:GetChildren()) do
    if gui.Name == "HackMenu" then
        gui:Destroy()
    end
end

wait(0.2)

-- Settings
local settings = {
    speed = false,
    speedValue = 50,
    fly = false,
    flySpeed = 50,
    noclip = false,
    esp = false,
    infiniteJump = false
}

-- إنشاء GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 400)
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Border
local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(0, 255, 150)
Border.Thickness = 2
Border.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local HeaderCover = Instance.new("Frame")
HeaderCover.Size = UDim2.new(1, 0, 0, 10)
HeaderCover.Position = UDim2.new(0, 0, 1, -10)
HeaderCover.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
HeaderCover.BorderSizePixel = 0
HeaderCover.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔥 HACK MENU"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Content Frame
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -50)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
Content.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.Parent = Content

-- دالة إنشاء Toggle
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = Content
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 50, 0, 25)
    Button.Position = UDim2.new(1, -55, 0.5, -12.5)
    Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamBold
    Button.Parent = ToggleFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button
    
    local enabled = false
    
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Button.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            Button.Text = "ON"
        else
            Button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Button.Text = "OFF"
        end
        callback(enabled)
    end)
    
    return ToggleFrame
end

-- دالة إنشاء Button
local function CreateButton(name, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Parent = Content
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ButtonFrame
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 1, -10)
    Button.Position = UDim2.new(0, 5, 0, 5)
    Button.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(0, 0, 0)
    Button.TextSize = 16
    Button.Font = Enum.Font.GothamBold
    Button.Parent = ButtonFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    
    return ButtonFrame
end

-- Speed Hack
CreateToggle("⚡ Speed Hack", function(enabled)
    settings.speed = enabled
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        if enabled then
            char.Humanoid.WalkSpeed = settings.speedValue
        else
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Fly Hack
CreateToggle("🚀 Fly", function(enabled)
    settings.fly = enabled
end)

-- Noclip
CreateToggle("👻 Noclip (Walk Through Walls)", function(enabled)
    settings.noclip = enabled
end)

-- ESP
CreateToggle("👁️ ESP (See Players)", function(enabled)
    settings.esp = enabled
end)

-- Infinite Jump
CreateToggle("🦘 Infinite Jump", function(enabled)
    settings.infiniteJump = enabled
end)

-- Teleport Button
CreateButton("📍 Teleport Forward (3 studs)", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 3
    end
end)

-- Update Content Size
Content.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- Fly System
local flying = false
local flyConnection

spawn(function()
    while wait() do
        if settings.fly then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local hum = char:FindFirstChild("Humanoid")
                
                if not flying then
                    flying = true
                    local bg = Instance.new("BodyGyro")
                    bg.P = 9e4
                    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                    bg.cframe = hrp.CFrame
                    bg.Parent = hrp
                    
                    local bv = Instance.new("BodyVelocity")
                    bv.velocity = Vector3.new(0, 0, 0)
                    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
                    bv.Parent = hrp
                    
                    flyConnection = RunService.Heartbeat:Connect(function()
                        if not settings.fly then
                            flying = false
                            bg:Destroy()
                            bv:Destroy()
                            if flyConnection then
                                flyConnection:Disconnect()
                            end
                            return
                        end
                        
                        local cam = workspace.CurrentCamera
                        local speed = settings.flySpeed
                        
                        bg.cframe = cam.CFrame
                        
                        local moveDir = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            moveDir = moveDir + cam.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            moveDir = moveDir - cam.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            moveDir = moveDir - cam.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            moveDir = moveDir + cam.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            moveDir = moveDir + Vector3.new(0, 1, 0)
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                            moveDir = moveDir - Vector3.new(0, 1, 0)
                        end
                        
                        bv.velocity = moveDir * speed
                    end)
                end
            end
        else
            if flying then
                flying = false
            end
        end
    end
end)

-- Noclip System
RunService.Stepped:Connect(function()
    if settings.noclip then
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Speed System
spawn(function()
    while wait(0.1) do
        if settings.speed then
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = settings.speedValue
            end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if settings.infiniteJump then
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ESP System
local espObjects = {}

local function createESP(target)
    if target == player then return end
    
    local esp = Instance.new("Highlight")
    esp.Adornee = target.Character
    esp.FillColor = Color3.fromRGB(255, 0, 0)
    esp.OutlineColor = Color3.fromRGB(255, 255, 255)
    esp.FillTransparency = 0.5
    esp.OutlineTransparency = 0
    esp.Parent = target.Character
    
    table.insert(espObjects, esp)
end

local function clearESP()
    for _, esp in pairs(espObjects) do
        esp:Destroy()
    end
    espObjects = {}
end

spawn(function()
    while wait(1) do
        if settings.esp then
            clearESP()
            for _, target in pairs(Players:GetPlayers()) do
                if target.Character and target ~= player then
                    createESP(target)
                end
            end
        else
            clearESP()
        end
    end
end)

-- Notification
local Notif = Instance.new("Frame")
Notif.Size = UDim2.new(0, 300, 0, 60)
Notif.Position = UDim2.new(0.5, -150, 0.05, 0)
Notif.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Notif.BorderSizePixel = 0
Notif.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 10)
NotifCorner.Parent = Notif

local NotifText = Instance.new("TextLabel")
NotifText.Size = UDim2.new(1, 0, 1, 0)
NotifText.BackgroundTransparency = 1
NotifText.Text = "✅ HACK MENU LOADED!\nPress and drag to move"
NotifText.TextColor3 = Color3.fromRGB(0, 0, 0)
NotifText.TextSize = 16
NotifText.Font = Enum.Font.GothamBold
NotifText.Parent = Notif

spawn(function()
    wait(3)
    Notif:TweenPosition(UDim2.new(0.5, -150, -0.2, 0), "In", "Back", 0.5, true)
    wait(0.5)
    Notif:Destroy()
end)

-- Animation
MainFrame.Position = UDim2.new(0.02, 0, 1.2, 0)
MainFrame:TweenPosition(UDim2.new(0.02, 0, 0.3, 0), "Out", "Back", 0.8, true)

print("========================================")
print("✅ HACK MENU LOADED!")
print("🔥 Features: Speed, Fly, Noclip, ESP, Infinite Jump")
print("========================================")
