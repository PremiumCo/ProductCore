--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ControlPanel = script.Parent
local UI = ControlPanel:WaitForChild("UI")
local Open = UI:WaitForChild("BG"):WaitForChild("ButtonRow1"):WaitForChild("Open")
local Open75 = UI:WaitForChild("BG"):WaitForChild("ButtonRow1"):WaitForChild("Open75")
local Open50 = UI:WaitForChild("BG"):WaitForChild("ButtonRow1"):WaitForChild("Open50")
local Open25 = UI:WaitForChild("BG"):WaitForChild("ButtonRow1"):WaitForChild("Open25")
local Close = UI:WaitForChild("BG"):WaitForChild("ButtonRow1"):WaitForChild("Close")
local PlusSpeed = UI:WaitForChild("BG"):WaitForChild("ButtonRow2"):WaitForChild("+1")
local MinusSpeed = UI:WaitForChild("BG"):WaitForChild("ButtonRow2"):WaitForChild("-1")
local LinearStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Linear")
local SineStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Sine")
local QuadStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Quad")
local CubicStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Cubic")
local QuartStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Quart")
local QuintStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Quint")
local BackStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Back")
local ElasticStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Elastic")
local BounceStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Bounce")
local ExponentialStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Exponential")
local CircularStyleButton = UI:WaitForChild("BG"):WaitForChild("ButtonRow3"):WaitForChild("Circular")
local Status = UI:WaitForChild("BG"):WaitForChild("Status")
local Status2 = UI:WaitForChild("BG"):WaitForChild("Status2")
local Status3 = UI:WaitForChild("BG"):WaitForChild("Status3")

local doorModel1 = ControlPanel.Parent:WaitForChild("Platform")

local goal1 = ControlPanel.Parent:WaitForChild("Goal")

local Primary1 = doorModel1:WaitForChild("Door"):WaitForChild("Primary")

local OpenPosition1 = Primary1.CFrame

local Opened = false
local cooldown = false
local Speed = 0.3
local Style = Enum.EasingStyle.Linear

local function tweenModel(model, target, info)
	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = model:GetPrimaryPartCFrame()

	CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:SetPrimaryPartCFrame(CFrameValue.Value)
	end)

	local tween

	if typeof(target) == "CFrame" then
		tween = TweenService:Create(CFrameValue, info, {Value = target})
	elseif typeof(target) == "Vector3" then
		local startPosition = model:GetPrimaryPartCFrame().Position
		local endPosition = startPosition + target
		tween = TweenService:Create(CFrameValue, info, {Value = CFrame.new(endPosition)})
	else
		error("Invalid target type")
	end

	tween:Play()

	tween.Completed:Connect(function()
		CFrameValue:Destroy()
	end)
end

local function SetEasingStyle(newStyle)
	Style = newStyle
	local Styleword = string.match(tostring(newStyle), "%.([^%.]+)$")
	Status3.Text = Styleword
end

PlusSpeed.MouseButton1Click:Connect(function()
	Speed = Speed + 0.1
	Status2.Text = tostring(Speed)
end)

MinusSpeed.MouseButton1Click:Connect(function()
	Speed = math.max(Speed - 0.1, 0)
	Status2.Text = tostring(Speed)
end)

LinearStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Linear)
end)

SineStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Sine)
end)

QuadStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Quad)
end)

CubicStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Cubic)
end)

QuartStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Quart)
end)

QuintStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Quint)
end)

BackStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Back)
end)

ElasticStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Elastic)
end)

BounceStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Bounce)
end)

ExponentialStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Exponential)
end)

CircularStyleButton.MouseButton1Click:Connect(function()
	SetEasingStyle(Enum.EasingStyle.Circular)
end)





local hitbox = ControlPanel.Parent:WaitForChild("Hitbox")
local UserInHitbox = {}

local function findIndex(tbl, value)
	for i, v in ipairs(tbl) do
		if v == value then
			return i
		end
	end
	return nil
end

hitbox.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and not findIndex(UserInHitbox, player) then
		table.insert(UserInHitbox, player)
		print(UserInHitbox)
	end
end)

hitbox.TouchEnded:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player then
		local index = findIndex(UserInHitbox, player)
		if index then
			table.remove(UserInHitbox, index)
			print(UserInHitbox)
		end
	end
end)






Open.MouseButton1Click:Connect(function(plr)
	if  cooldown == false then
		cooldown = true
		local duration = Speed or 6
		tweenModel(doorModel1, goal1.CFrame,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		Opened = true
		Status.Text = "Moving"
		Status.TextColor3 = Color3.new(1,1,0)
		task.wait(Speed - (duration*.15))
		for _, player in pairs(UserInHitbox) do
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				local OldJumpHeight = player.Character:WaitForChild("Humanoid").JumpHeight
				task.wait()
				player.Character:WaitForChild("Humanoid").JumpHeight = 30/(duration*10)
				player.Character:WaitForChild("Humanoid").Jump = true
				repeat
					task.wait(.1)
					player.Character:WaitForChild("Humanoid").JumpHeight = OldJumpHeight
				until player.Character:WaitForChild("Humanoid").Jump == false

			end
		end
		task.wait(.2)
		Status.Text = "Standing"
		Status.TextColor3 = Color3.new(1,0,0)
		cooldown = false
	end
end)

Open75.MouseButton1Click:Connect(function(plr)
	if  cooldown == false then
		cooldown = true
		local duration = Speed or 6
		local targetPosition = goal1.CFrame:lerp(OpenPosition1, 0.25)
		tweenModel(doorModel1, targetPosition, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		Opened = true
		Status.Text = "Moving"
		Status.TextColor3 = Color3.new(1,1,0)
		task.wait(Speed + .1)
		Status.Text = "Standing"
		Status.TextColor3 = Color3.new(1,0,0)
		cooldown = false
	end
end)

Open50.MouseButton1Click:Connect(function(plr)
	if  cooldown == false then
		cooldown = true
		local duration = Speed or 6
		local targetPosition = goal1.CFrame:lerp(OpenPosition1, 0.5)
		tweenModel(doorModel1, targetPosition,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		Opened = true
		Status.Text = "Moving"
		Status.TextColor3 = Color3.new(1,1,0)
		task.wait(Speed + .1)
		Status.Text = "Standing"
		Status.TextColor3 = Color3.new(1,0,0)
		cooldown = false
	end
end)

Open25.MouseButton1Click:Connect(function(plr)
	if  cooldown == false then
		cooldown = true
		local duration = Speed or 6
		local targetPosition = goal1.CFrame:lerp(OpenPosition1, 0.75)
		tweenModel(doorModel1, targetPosition,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		Opened = true
		Status.Text = "Moving"
		Status.TextColor3 = Color3.new(1,1,0)
		task.wait(Speed + .1)
		Status.Text = "Standing"
		Status.TextColor3 = Color3.new(1,0,0)
		cooldown = false
	end
end)

Close.MouseButton1Click:Connect(function(plr)
	if Opened == true and cooldown == false then
		local duration = Speed or 6
		tweenModel(doorModel1, OpenPosition1,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		Opened = false
		Status.Text = "Moving"
		Status.TextColor3 = Color3.new(1,1,0)
		task.wait(Speed + .1)
		Status.Text = "Standing"
		Status.TextColor3 = Color3.new(1,0,0)
		cooldown = false
	end
end)


local CustomButtons = require(ControlPanel:WaitForChild("CustomTemplates"))


for i, v in pairs(CustomButtons) do
	CustomButtons[i] = Open:Clone()
	CustomButtons[i].Parent = ControlPanel:WaitForChild("SecondFrame"):WaitForChild("UI"):WaitForChild("BG"):WaitForChild("ButtonRow1")

	local speedy
	local percentageOpen
	local stylistic
	
	for a, b in pairs(v) do
		if a == "Name" then
			CustomButtons[i].Text = b
		end
		if a == "Speed" then
			speedy = b
		end
		if a == "PercentageOpen" then
			percentageOpen = b
		end
		if a == "TweenStyle" then
			stylistic = b
		end
	end

	CustomButtons[i].MouseButton1Click:Connect(function(plr)
		if  cooldown == false then
			cooldown = true
			local duration = speedy or 1 -- Default value if speedy is nil
			local numb = percentageOpen and ((percentageOpen / 100) -1) * -1  or 0 -- Default value if percentageOpen is nil
			local targetPosition = goal1.CFrame:lerp(OpenPosition1, numb)
			tweenModel(doorModel1, targetPosition,TweenInfo.new(duration, stylistic, Enum.EasingDirection.Out))
			Opened = true
			Status.Text = "Moving"
			Status.TextColor3 = Color3.new(1, 1, 0)
			task.wait(duration + .1)
			Status.Text = "Standing"
			Status.TextColor3 = Color3.new(1, 0, 0)
			cooldown = false
		end
	end)
end

