-- WALL CLIP - أبسط نسخة ممكنة
-- Copy و Execute

wait(0.5) -- انتظار للتأكد

local player = game.Players.LocalPlayer

-- حذف GUI قديم
pcall(function()
    player.PlayerGui.WallClipGUI:Destroy()
end)

wait(0.3)

-- GUI جديد
local gui = Instance.new("ScreenGui")
gui.Name = "WallClipGUI"
gui.Parent = player.PlayerGui

-- رسالة
local msg = Instance.new("TextLabel")
msg.Size = UDim2.new(0, 250, 0, 50)
msg.Position = UDim2.new(0.5, -125, 0.1, 0)
msg.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
msg.Text = "✅ LOADED!"
msg.TextSize = 24
msg.TextColor3 = Color3.fromRGB(255, 255, 255)
msg.Font = Enum.Font.SourceSansBold
msg.Parent = gui

task.wait(2)
msg:Destroy()

-- الزر
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 120, 0, 50)
btn.Position = UDim2.new(0.5, -60, 0.9, -25)
btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btn.Text = "CLIP"
btn.TextSize = 20
btn.TextColor3 = Color3.fromRGB(0, 255, 0)
btn.Font = Enum.Font.SourceSansBold
btn.BorderSizePixel = 2
btn.BorderColor3 = Color3.fromRGB(0, 255, 0)
btn.Parent = gui

-- Function
btn.MouseButton1Click:Connect(function()
    local c = player.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        local hrp = c.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 3
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)

print("=== WALL CLIP READY ===")
print("Button at bottom of screen")
print("=======================")

-- Animation
btn.Position = UDim2.new(0.5, -60, 1.5, 0)
btn:TweenPosition(UDim2.new(0.5, -60, 0.9, -25), "Out", "Bounce", 0.7)
