-- TEST SCRIPT - اختبار الـ Executor
print("========================================")
print("🔥 SCRIPT STARTED!")
print("✅ Executor is working!")
print("========================================")

wait(1)

-- إنشاء GUI للاختبار
local player = game.Players.LocalPlayer

-- حذف قديم
for _, v in pairs(player.PlayerGui:GetChildren()) do
    if v.Name == "TestGUI" or v.Name == "WallClipGUI" then
        v:Destroy()
    end
end

wait(0.5)

-- GUI جديد
local gui = Instance.new("ScreenGui")
gui.Name = "WallClipGUI"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

print("✅ GUI Created")

-- رسالة كبيرة
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 400, 0, 100)
label.Position = UDim2.new(0.5, -200, 0.5, -50)
label.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
label.Text = "✅ السكربت شغال!\nشوف الزر بالأسفل"
label.TextSize = 28
label.TextColor3 = Color3.fromRGB(0, 0, 0)
label.Font = Enum.Font.SourceSansBold
label.BorderSizePixel = 3
label.BorderColor3 = Color3.fromRGB(0, 0, 0)
label.Parent = gui

print("✅ Label Created")

-- إخفاء الرسالة بعد 3 ثواني
spawn(function()
    wait(3)
    label:Destroy()
    print("✅ Notification Removed")
end)

-- زر التحكم
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 60)
button.Position = UDim2.new(0.5, -75, 0.85, 0)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.Text = "🔥 CLIP\n(اضغط هنا)"
button.TextSize = 22
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.BorderSizePixel = 3
button.BorderColor3 = Color3.fromRGB(255, 255, 255)
button.Parent = gui

print("✅ Button Created")

-- وظيفة الزر
local canTeleport = true

button.MouseButton1Click:Connect(function()
    if not canTeleport then return end
    canTeleport = false
    
    print("🔥 Button Clicked!")
    
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local newPos = hrp.CFrame + hrp.CFrame.LookVector * 3
        hrp.CFrame = newPos
        
        print("✅ Teleported Forward!")
        
        -- تأثير بصري
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        button.Text = "✅ نجح!"
        wait(0.2)
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        button.Text = "🔥 CLIP\n(اضغط هنا)"
    else
        print("❌ Character not found!")
    end
    
    wait(0.3)
    canTeleport = true
end)

print("========================================")
print("✅ WALL CLIP LOADED SUCCESSFULLY!")
print("📍 Button Position: Bottom Center")
print("🎮 Click the RED button to teleport")
print("========================================")
