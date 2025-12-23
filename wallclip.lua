-- Wall Clip Script - نسخة محسّنة ومضمونة
-- ✅ يشتغل على كل الـ Executors

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🔄 Starting Wall Clip Script...")

-- اختيار أفضل مكان للـ GUI
local function getParent()
    local success, result = pcall(function()
        if gethui then
            return gethui()
        end
    end)
    if success and result then
        print("✅ Using gethui()")
        return result
    end
    
    success, result = pcall(function()
        if syn and syn.protect_gui then
            return syn.protect_gui(game:GetService("CoreGui"))
        end
    end)
    if success and result then
        print("✅ Using Synapse protect_gui")
        return result
    end
    
    print("✅ Using PlayerGui")
    return player:WaitForChild("PlayerGui")
end

local parent = getParent()

-- إعدادات
local TELEPORT_DISTANCE = 3

-- حذف أي GUI قديم
pcall(function()
    if parent:FindFirstChild("WallClipGUI") then
        parent:FindFirstChild("WallClipGUI"):Destroy()
        print("🗑️ Removed old GUI")
    end
end)

-- انتظر شوية للتأكد
task.wait(0.1)

-- إنشاء الـ GUI الرئيسي
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WallClipGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Enabled = true
screenGui.IgnoreGuiInset = false

print("📱 Creating GUI...")

-- رسالة التحميل (في الأعلى)
local notification = Instance.new("Frame")
notification.Name = "LoadNotification"
notification.Size = UDim2.new(0, 380, 0, 80)
notification.Position = UDim2.new(0.5, -190, 0.08, 0)
notification.BackgroundColor3 = Color3.fromRGB(40, 200, 80)
notification.BorderSizePixel = 0
notification.Visible = true
notification.Parent = screenGui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 15)
notifCorner.Parent = notification

-- Gradient للـ notification
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 200, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 150, 50))
}
gradient.Rotation = 45
gradient.Parent = notification

local notifLabel = Instance.new("TextLabel")
notifLabel.Size = UDim2.new(1, -30, 1, -30)
notifLabel.Position = UDim2.new(0, 15, 0, 15)
notifLabel.BackgroundTransparency = 1
notifLabel.Text = "✅ Wall Clip Script تم التحميل بنجاح!\n⚡ استخدم الزر بالأسفل للتخطي عبر الجدران"
notifLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
notifLabel.TextSize = 18
notifLabel.Font = Enum.Font.GothamBold
notifLabel.TextWrapped = true
notifLabel.TextYAlignment = Enum.TextYAlignment.Center
notifLabel.Parent = notification

-- Stroke للنص
local textStroke = Instance.new("UIStroke")
textStroke.Color = Color3.fromRGB(0, 0, 0)
textStroke.Thickness = 2
textStroke.Parent = notifLabel

-- إخفاء الرسالة بعد 5 ثواني
task.spawn(function()
    task.wait(5)
    notification:TweenPosition(
        UDim2.new(0.5, -190, -0.2, 0),
        Enum.EasingDirection.In,
        Enum.EasingStyle.Back,
        0.6,
        true
    )
    task.wait(0.7)
    notification:Destroy()
end)

-- إنشاء Container للزر
local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(0, 170, 0, 80)
buttonContainer.Position = UDim2.new(0.5, -85, 0.85, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = screenGui

-- إنشاء زر التحكم
local button = Instance.new("TextButton")
button.Name = "ClipButton"
button.Size = UDim2.new(1, 0, 1, 0)
button.Position = UDim2.new(0, 0, 0, 0)
button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
button.BorderSizePixel = 4
button.BorderColor3 = Color3.fromRGB(0, 255, 150)
button.Text = "⚡ تخطي جدار\n🔥 3 Studs"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.GothamBold
button.TextWrapped = true
button.AutoButtonColor = true
button.Modal = false
button.Parent = buttonContainer

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 15)
buttonCorner.Parent = button

-- Gradient للزر
local buttonGradient = Instance.new("UIGradient")
buttonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
buttonGradient.Rotation = 90
buttonGradient.Parent = button

-- Stroke للزر
local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(0, 255, 150)
buttonStroke.Thickness = 3
buttonStroke.Transparency = 0.3
buttonStroke.Parent = button

-- متغير لمنع الضغط المتكرر
local canClick = true
local clickCooldown = 0.2

-- دالة التليبورت
local function teleportForward()
    if not canClick then
        return
    end
    
    canClick = false
    
    local success, err = pcall(function()
        local character = player.Character
        if not character then
            warn("⚠️ No character found!")
            return
        end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then
            warn("⚠️ HumanoidRootPart not found!")
            return
        end
        
        -- احسب الموقع الجديد
        local lookVector = hrp.CFrame.LookVector
        local newPos = hrp.Position + (lookVector * TELEPORT_DISTANCE)
        
        -- تليبورت
        hrp.CFrame = CFrame.new(newPos) * (hrp.CFrame - hrp.CFrame.Position)
        
        print("✅ Teleported forward " .. TELEPORT_DISTANCE .. " studs")
        
        -- تأثير بصري للنجاح
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        buttonStroke.Color = Color3.fromRGB(255, 255, 255)
        button.BorderColor3 = Color3.fromRGB(255, 255, 255)
        button.Size = UDim2.new(1, 10, 1, 10)
        
        task.wait(0.15)
        
        button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        buttonStroke.Color = Color3.fromRGB(0, 255, 150)
        button.BorderColor3 = Color3.fromRGB(0, 255, 150)
        button.Size = UDim2.new(1, 0, 1, 0)
    end)
    
    if not success then
        warn("❌ Teleport error:", err)
        -- تأثير بصري للخطأ
        button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(0.2)
        button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end
    
    task.wait(clickCooldown)
    canClick = true
end

-- ربط الزر - للكمبيوتر
button.MouseButton1Click:Connect(function()
    print("🖱️ Button clicked!")
    teleportForward()
end)

-- ربط الزر - للموبايل
button.TouchTap:Connect(function()
    print("📱 Button tapped!")
    teleportForward()
end)

-- تأثير Hover
button.MouseEnter:Connect(function()
    button:TweenSize(
        UDim2.new(1, 5, 1, 5),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.2,
        true
    )
    buttonStroke.Transparency = 0
end)

button.MouseLeave:Connect(function()
    button:TweenSize(
        UDim2.new(1, 0, 1, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.2,
        true
    )
    buttonStroke.Transparency = 0.3
end)

-- وضع الـ GUI في المكان الصحيح
screenGui.Parent = parent

print("✅ GUI added to parent:", parent.Name)

-- رسالة نجاح في الـ console
print("=================================")
print("✅ Wall Clip Script Loaded Successfully!")
print("⚡ Press the button to clip through walls")
print("📱 Works on PC & Mobile")
print("🎮 Teleport Distance: " .. TELEPORT_DISTANCE .. " studs")
print("=================================")

-- تأثير دخول الزر (animation)
buttonContainer.Position = UDim2.new(0.5, -85, 1.2, 0)
buttonContainer:TweenPosition(
    UDim2.new(0.5, -85, 0.85, 0),
    Enum.EasingDirection.Out,
    Enum.EasingStyle.Bounce,
    1,
    true
)

-- تأكيد إظهار الـ GUI
task.wait(0.5)
if screenGui.Parent then
    print("✅ GUI is visible and ready!")
else
    warn("⚠️ GUI parent was removed!")
end
