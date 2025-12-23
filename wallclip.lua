-- Wall Clip Script - نسخة بسيطة ومضمونة
-- ✅ يشتغل على أضعف Executor

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- حذف أي GUI قديم
for _, gui in pairs(player.PlayerGui:GetChildren()) do
    if gui.Name == "WallClipGUI" then
        gui:Destroy()
    end
end

wait(0.2)

-- إنشاء الـ GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WallClipGUI"
ScreenGui.ResetOnSpawn = false

-- رسالة التحميل
local Notification = Instance.new("TextLabel")
Notification.Size = UDim2.new(0, 300, 0, 60)
Notification.Position = UDim2.new(0.5, -150, 0.1, 0)
Notification.BackgroundColor3 = Color3.new(0, 1, 0)
Notification.BorderSizePixel = 0
Notification.Text = "✅ Wall Clip تم التحميل!"
Notification.TextColor3 = Color3.new(1, 1, 1)
Notification.TextSize = 20
Notification.Font = Enum.Font.SourceSansBold
Notification.Parent = ScreenGui

-- إخفاء الرسالة
spawn(function()
    wait(3)
    Notification:Destroy()
end)

-- زر التحكم
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 150, 0, 60)
Button.Position = UDim2.new(0.5, -75, 0.85, 0)
Button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Button.BorderSizePixel = 3
Button.BorderColor3 = Color3.new(0, 1, 0.4)
Button.Text = "⚡ تخطي\n(3 studs)"
Button.TextColor3 = Color3.new(1, 1, 1)
Button.TextSize = 18
Button.Font = Enum.Font.SourceSansBold
Button.Parent = ScreenGui

-- دالة التليبورت
local function Teleport()
    local Char = player.Character
    if Char then
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if HRP then
            local LookVector = HRP.CFrame.LookVector
            HRP.CFrame = HRP.CFrame + (LookVector * 3)
            
            -- تأثير بصري
            Button.BackgroundColor3 = Color3.new(0, 1, 0)
            wait(0.1)
            Button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        end
    end
end

-- ربط الزر
Button.MouseButton1Click:Connect(Teleport)

-- وضع الـ GUI
ScreenGui.Parent = player.PlayerGui

print("✅ Wall Clip Loaded!")
print("⚡ Button Location: Bottom Center")

-- تأثير دخول
Button.Position = UDim2.new(0.5, -75, 1.2, 0)
Button:TweenPosition(
    UDim2.new(0.5, -75, 0.85, 0),
    "Out",
    "Bounce",
    0.8,
    true
)
