--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local function moveParent()
	local parentObject = game.Workspace.TV.TeleCore
	local serverScriptService = game:GetService("ServerScriptService")

	if parentObject then
		parentObject.Parent = serverScriptService
		print(parentObject.Name .. " moved to ServerScriptService.")
	else
		print("Parent object not found.")
	end
end

moveParent()


local Events = game:GetService("ReplicatedStorage").EventsTele
local TweenService = game:GetService("TweenService")
local Screens = workspace.TV
local SurfaceGUITemplate = Events.TVDisplay
local https = game:GetService("HttpService")

--.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-


for i, TV in pairs(Screens:GetChildren()) do
	local SurfaceGUI = SurfaceGUITemplate:Clone()
	SurfaceGUI.Parent = TV.Screen
	SurfaceGUI.Adornee = TV.Screen
end

local scrollingPlayers = {}

Events.ClearScroll.OnServerEvent:Connect(function(player)
	for _, TV in pairs(Screens:GetChildren()) do
		local textLabel = TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel
		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(textLabel, tweenInfo, {Position = UDim2.new(0, 0, 0, 0)})
		tween:Play()
	end
end)

Events.Scroll.OnServerEvent:Connect(function(player, direction, start)
	if start then
		scrollingPlayers[player] = direction
	else
		scrollingPlayers[player] = nil
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	for player, direction in pairs(scrollingPlayers) do
		for _, TV in pairs(Screens:GetChildren()) do
			local currentPos = TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel.Position
			local targetPos
			if direction == "Up" then
				targetPos = UDim2.new(0, 0, currentPos.Y.Scale - 0.1, 0)
			elseif direction == "Down" then
				targetPos = UDim2.new(0, 0, currentPos.Y.Scale + 0.1, 0)
			end

			local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
			local tween = TweenService:Create(TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel, tweenInfo, {Position = targetPos})
			tween:Play()
		end
	end
end)

Events.TVText.OnServerEvent:Connect(function(player, text)
	for i, TV in pairs(Screens:GetChildren()) do
		TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel.Text = text
	end
end)

Events.DisplayOn.OnServerEvent:Connect(function(player, status)
	for i, TV in pairs(Screens:GetChildren()) do
		if status == true then
			TV.Screen:WaitForChild("TVDisplay").Enabled = true
		else
			TV.Screen:WaitForChild("TVDisplay").Enabled = false
		end
	end
end)