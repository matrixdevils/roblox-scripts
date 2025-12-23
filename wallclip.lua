-- Wall Clip Script - اضغط O للتحرك للأمام
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TELEPORT_DISTANCE = 3

local function teleportForward()
    if humanoidRootPart then
        local lookVector = humanoidRootPart.CFrame.LookVector
        local newPosition = humanoidRootPart.Position + (lookVector * TELEPORT_DISTANCE)
        humanoidRootPart.CFrame = CFrame.new(newPosition) * (humanoidRootPart.CFrame - humanoidRootPart.Position)
        print("✅ تم الانتقال للأمام!")
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.O then
        teleportForward()
    end
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

print("Wall Clip Script محمّل - اضغط O")
