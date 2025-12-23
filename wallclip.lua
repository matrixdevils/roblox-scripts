-- Wall Clip Script - يشتغل على كل الـ Executors
-- متوافق مع أي executor خارجي

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- اختيار المكان المناسب للـ GUI حسب الـ Executor
local parent
if gethui then
    parent = gethui()
elseif syn and syn.protect_gui then
    parent = syn.protect_gui(game:GetService("CoreGui"))
else
    parent = player:WaitForChild("PlayerGui")
end

-- إعدادات
local TELEPORT_DISTANCE = 3

-- حذف أي GUI قديم
if parent:FindFirstChild("WallClipGUI") then
    parent:FindFirstChild("WallClipGUI"):Destroy()
end

-- إنشاء الـ GUI الرئيسي
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WallClipGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- رسالة التحميل (في الأعلى)
local notification = Instance.new("Frame")
notification.Name = "LoadNotification"
notification.Size = UDim2.new(0, 350, 0, 70)
notification.Position = UDim2.new(0.5, -175, 0.05, 0)
notification.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
notification.BorderSizePixel = 0
notification.Parent = screenGui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 12)
notifCorner.Parent = notification

local notifLabel = Instance.new("TextLabel")
notifLabel.Size = UDim2.new(1, -20, 1, -20)
notifLabel.Position = UDim2.new(0, 10, 0, 10)
notifLabel.BackgroundTransparency = 1
notifLabel.Text = "✅ Wall Clip تم التحميل بنجاح!\n⚡ اضغط الزر للتخطي"
notifLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
notifLabel.TextSize = 16
notifLabel.Font = Enum.Font.GothamBold
notifLabel.TextWrapped = true
notifLabel.Parent = notification

-- إخفاء الرسالة بعد 5 ثواني
task.spawn(function()
    task.wait(5)
    notification:TweenPosition(
        UDim2.new(0.5, -175, -0.15, 0),
        Enum.EasingDirection.In,
        Enum.EasingStyle.Back,
        0.5,
        true
    )
    task.wait(0.5)
    notification:Destroy()
end)

-- إنشاء زر التحكم
local button = Instance.new("TextButton")
button.Name = "ClipButton"
button.Size = UDim2.new(0, 140, 0, 60)
button.Position = UDim2.new(0.5, -70, 0.85, 0)
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.BorderSizePixel = 3
button.BorderColor3 = Color3.fromRGB(0, 255, 100)
button.Text = "⚡ تخطي جدار\n(3 studs)"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.Parent = screenGui

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 12)
buttonCorner.Parent = button

-- إضافة shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 4, 1, 4)
shadow.Position = UDim2.new(0, -2, 0, -2)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ZIndex = button.ZIndex - 1
shadow.Parent = button

-- دالة التليبورت
local function teleportForward()
    local success, err = pcall(function()
        local character = player.Character
        if not character then return end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- احسب الموقع الجديد
        local lookVector = hrp.CFrame.LookVector
        local newPos = hrp.Position + (lookVector * TELEPORT_DISTANCE)
        
        -- تليبورت
        hrp.CFrame = CFrame.new(newPos) * (hrp.CFrame - hrp.CFrame.Position)
        
        -- تأثير بصري
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        button.BorderColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(0.15)
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.BorderColor3 = Color3.fromRGB(0, 255, 100)
    end)
    
    if not success then
        warn("Teleport error:", err)
    end
end

-- ربط الزر
button.MouseButton1Click:Connect(teleportForward)
button.TouchTap:Connect(teleportForward)

-- وضع الـ GUI في المكان الصحيح
screenGui.Parent = parent

-- رسالة في الـ console
print("=================================")
print("✅ Wall Clip Script Loaded!")
print("⚡ Press the button to clip through walls")
print("📱 Works on PC & Mobile")
print("=================================")

-- تأثير دخول الزر
button.Position = UDim2.new(0.5, -70, 1.2, 0)
button:TweenPosition(
    UDim2.new(0.5, -70, 0.85, 0),
    Enum.EasingDirection.Out,
    Enum.EasingStyle.Bounce,
    0.8,
    true
)
