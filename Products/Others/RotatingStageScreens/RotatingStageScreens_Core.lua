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

local doorModel = ControlPanel.Parent
local door = doorModel:WaitForChild("Door")
local door2 = doorModel:WaitForChild("Door2")
local door3 = doorModel:WaitForChild("Door3")
local door4 = doorModel:WaitForChild("Door4")


local goal = doorModel:WaitForChild("Goal")
local goal2 = doorModel:WaitForChild("Goal2")
local goal3 = doorModel:WaitForChild("Goal3")
local goal4 = doorModel:WaitForChild("Goal4")


local Primary = door:WaitForChild("Primary")
local Primary2 = door2:WaitForChild("Primary2")
local Primary3 = door3:WaitForChild("Primary3")
local Primary4 = door4:WaitForChild("Primary4")


local OpenPosition = Primary.CFrame
local OpenPosition2 = Primary2.CFrame
local OpenPosition3 = Primary3.CFrame
local OpenPosition4 = Primary4.CFrame


local Opened = false
local cooldown = false
local Speed = 1
local Style = Enum.EasingStyle.Quad

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
	Speed = Speed + 1
	Status2.Text = tostring(Speed)
end)

MinusSpeed.MouseButton1Click:Connect(function()
	Speed = math.max(Speed - 1, 0)
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

Open.MouseButton1Click:Connect(function(plr)
	if  cooldown == false then
		cooldown = true
		local duration = Speed or 6
		tweenModel(door, goal.CFrame,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		tweenModel(door2, goal2.CFrame,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		tweenModel(door3, goal3.CFrame,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		tweenModel(door4, goal4.CFrame,TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		Opened = true
		Status.Text = "Moving"
		Status.TextColor3 = Color3.new(1,1,0)
		task.wait(Speed + .1)
		Status.Text = "Standing"
		Status.TextColor3 = Color3.new(1,0,0)
		cooldown = false
	end
end)

Open75.MouseButton1Click:Connect(function(plr)
	if  cooldown == false then
		cooldown = true
		local duration = Speed or 6
		local targetPosition = goal.CFrame:lerp(OpenPosition, 0.25)
		tweenModel(door, targetPosition, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition2 = goal2.CFrame:lerp(OpenPosition2, 0.25)
		tweenModel(door2, targetPosition2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition3 = goal3.CFrame:lerp(OpenPosition3, 0.25)
		tweenModel(door3, targetPosition3, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition4 = goal4.CFrame:lerp(OpenPosition4, 0.25)
		tweenModel(door4, targetPosition4, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))

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
		local targetPosition = goal.CFrame:lerp(OpenPosition, 0.5)
		tweenModel(door, targetPosition, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition2 = goal2.CFrame:lerp(OpenPosition2, 0.5)
		tweenModel(door2, targetPosition2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition3 = goal3.CFrame:lerp(OpenPosition3, 0.5)
		tweenModel(door3, targetPosition3, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition4 = goal4.CFrame:lerp(OpenPosition4, 0.5)
		tweenModel(door4, targetPosition4, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))

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
		local targetPosition = goal.CFrame:lerp(OpenPosition, 0.75)
		tweenModel(door, targetPosition, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition2 = goal2.CFrame:lerp(OpenPosition2, 0.75)
		tweenModel(door2, targetPosition2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition3 = goal3.CFrame:lerp(OpenPosition3, 0.75)
		tweenModel(door3, targetPosition3, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		local targetPosition4 = goal4.CFrame:lerp(OpenPosition4, 0.75)
		tweenModel(door4, targetPosition4, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))

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
		tweenModel(door, OpenPosition, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		tweenModel(door2, OpenPosition2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		tweenModel(door3, OpenPosition3, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))
		tweenModel(door4, OpenPosition4, TweenInfo.new(duration, Style, Enum.EasingDirection.Out))

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
			local targetPosition = goal.CFrame:lerp(OpenPosition, numb)
			tweenModel(door, targetPosition, TweenInfo.new(duration, stylistic, Enum.EasingDirection.Out))
			local targetPosition2 = goal2.CFrame:lerp(OpenPosition2, numb)
			tweenModel(door2, targetPosition2, TweenInfo.new(duration, stylistic, Enum.EasingDirection.Out))
			local targetPosition3 = goal3.CFrame:lerp(OpenPosition3, numb)
			tweenModel(door3, targetPosition3, TweenInfo.new(duration, stylistic, Enum.EasingDirection.Out))
			local targetPosition4 = goal4.CFrame:lerp(OpenPosition4, numb)
			tweenModel(door4, targetPosition4, TweenInfo.new(duration, stylistic, Enum.EasingDirection.Out))

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

