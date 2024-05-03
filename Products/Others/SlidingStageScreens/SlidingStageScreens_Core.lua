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

local Door = ControlPanel.Parent:WaitForChild("MultiLift"):WaitForChild("Door")
local Door2 = ControlPanel.Parent:WaitForChild("MultiLift"):WaitForChild("Door2")
local EndPart = ControlPanel.Parent:WaitForChild("MultiLift"):WaitForChild("EndPart")
local EndPart2 = ControlPanel.Parent:WaitForChild("MultiLift"):WaitForChild("EndPart2")
local ClosedPosition = Door.PrimaryPart.Position
local ClosedPosition2 = Door2.PrimaryPart.Position
local Opened = false
local cooldown = false
local Speed = 1
local Style = Enum.EasingStyle.Quad


local function CalculatePosition(part1, part2)
	return CFrame.new(part1.Position):ToObjectSpace(CFrame.new(part2.Position)).Position
end

function TweenModelPos(Model, Tweeninfo, pos)
	if typeof(Model) ~= "Instance" then error(Model .. " isnt an instance") end
	if not Model:IsA("Model") then error(Model.Name .. " isnt a model") end
	if not Model.PrimaryPart then Model.PrimaryPart = Model:FindFirstChildWhichIsA("BasePart") end

	task.spawn(function()
		local Primary = Model.PrimaryPart
		local AnchorState = Primary.Anchored

		local TW = TweenService:Create(Primary, Tweeninfo, { Position = pos })

		for _, v in pairs(Model:GetDescendants()) do
			if v:IsA("BasePart") and v ~= Primary then
				local T = TweenService:Create(v, Tweeninfo, { Position = pos + CalculatePosition(Primary, v) })
				T:Play()

				local anchord = v.Anchored
				v.Anchored = true
				task.spawn(function()
					TW.Completed:Wait()
					v.Anchored = anchord
				end)
			end

			if v:IsA("Weld") or v:IsA("WeldConstraint") or v:IsA("ManualWeld") or v:IsA("Motor6D") then
				if v.Name ~= "TweenWeld" then
					v.Enabled = false
					task.spawn(function()
						TW.Completed:Wait()

						v.Enabled = true
					end)
				end
			end
		end

		TW:Play()
		TW.Completed:Wait()

		Primary.Anchored = AnchorState
	end)
	return
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

local dif = (Door.PrimaryPart.Position - EndPart.Position) 
local dif2 = (Door2.PrimaryPart.Position - EndPart2.Position)

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
			TweenModelPos(Door, TweenInfo.new(duration, stylistic, Enum.EasingDirection.Out), EndPart.Position + (dif * numb))
			TweenModelPos(Door2, TweenInfo.new(duration, stylistic, Enum.EasingDirection.Out), EndPart2.Position + (dif2 * numb))
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



Open.MouseButton1Click:Connect(function(plr)
	if cooldown == false then
		cooldown = true
		local duration = Speed or 6
		TweenModelPos(Door, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart.Position)
		TweenModelPos(Door2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart2.Position)
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
	if cooldown == false then
		cooldown = true
		local duration = Speed or 6
		TweenModelPos(Door, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart.Position + (dif * .25))
		TweenModelPos(Door2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart2.Position + (dif2 * .25))
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
	if cooldown == false then
		cooldown = true
		local duration = Speed or 6
		TweenModelPos(Door, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart.Position + (dif * 0.5))
		TweenModelPos(Door2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart2.Position + (dif2 * 0.5))
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
	if cooldown == false then
		cooldown = true
		local duration = Speed or 6
		TweenModelPos(Door, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart.Position + (dif * .75))
		TweenModelPos(Door2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), EndPart2.Position + (dif2 * .75))
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
	if cooldown == false then
		local duration = Speed or 6
		TweenModelPos(Door, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), ClosedPosition)
		TweenModelPos(Door2, TweenInfo.new(duration, Style, Enum.EasingDirection.Out), ClosedPosition2)
		Opened = false
		Status.Text = "Moving"
		Status.TextColor3 = Color3.new(1,1,0)
		task.wait(Speed + .1)
		Status.Text = "Standing"
		Status.TextColor3 = Color3.new(1,0,0)
		cooldown = false
	end
end)
