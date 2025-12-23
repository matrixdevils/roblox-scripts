-- Wall Clip Script مع زر على الشاشة
-- يشتغل على أي Executor (داخلي أو خارجي)
-- متوافق مع: Synapse, Krnl, Fluxus, Script-Ware, Delta, وكل الـ executors

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- دالة إظهار رسالة
local function showNotification(message, duration)
    local notif = Instance.new("ScreenGui")
    notif.Name = "Notification"
    notif.ResetOnSpawn = false
    notif.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 60)
    frame.Position = UDim2.new(0.5, -150, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    frame.BorderSizePixel = 0
    frame.Parent = notif
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = message
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 18
    label.Font = Enum.Font.GothamBold
    label.Parent = frame
    
    task.wait(duration or 3)
    notif:Destroy()
end

-- إعدادات
local TELEPORT_DISTANCE = 3

-- إنشاء الـ GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WallClipGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- إنشاء الزر
local button = Instance.new("TextButton")
button.Name = "ClipButton"
button.Size = UDim2.new(0, 120, 0, 50)
button.Position = UDim2.new(0.5, -60, 0.85, 0) -- في النص تحت شوية
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.BorderSizePixel = 2
button.BorderColor3 = Color3.fromRGB(0, 255, 0)
button.Text = "⚡ تخطي جدار"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.GothamBold
button.Parent = screenGui

-- إضافة تأثير rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = button

-- دالة التليبورت
local function teleportForward()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- احسب الاتجاه الأمامي
    local lookVector = humanoidRootPart.CFrame.LookVector
    local newPosition = humanoidRootPart.Position + (lookVector * TELEPORT_DISTANCE)
    
    -- حرك الشخصية
    humanoidRootPart.CFrame = CFrame.new(newPosition) * (humanoidRootPart.CFrame - humanoidRootPart.Position)
    
    -- تأثير بصري على الزر
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    task.wait(0.1)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end

-- ربط الزر بالدالة
button.MouseButton1Click:Connect(teleportForward)

-- دعم اللمس للموبايل
button.TouchTap:Connect(teleportForward)

-- إظهار رسالة التحميل
showNotification("✅ Wall Clip تم التحميل بنجاح!", 4)
print("✅ Wall Clip GUI محمّل - اضغط الزر للتحرك!")
