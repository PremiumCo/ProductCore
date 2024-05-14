--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local customAngle = script.Parent.CustomAngle
local direction = script.Parent.Direction
local mode = script.Parent.Mode
local push = script.Parent.Push
local SetAngle = script.Parent.SetAngle

local percentage = 0
local speed = 0
local customspd = false

local Rotate = game:GetService("ReplicatedStorage").SpinnyEvents.RotateController

local TweenService = game:GetService("TweenService")
local AngleSet = nil

local directionStat = script.Parent.DirectionStat
local directionS = "Left"

local pushDirection = "None"

local cruiseSpin = false

mode.Reset.MouseButton1Down:Connect(function()
	local model = script.Parent.Parent.Adornee
	
	mode.Reset.BackgroundColor3 = Color3.new(1,1,1)
	
	cruiseSpin = false
	AngleSet = nil
	pushDirection = "None"
	customspd = false
	
	customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	
	customAngle.Temp.Text = ""
	
	Rotate:FireServer(model, "Reset")
end)

mode.Reset.MouseButton1Up:Connect(function()
	mode.Reset.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

direction.Temp.MouseButton1Click:Connect(function()
	local model = script.Parent.Parent.Adornee
	if directionS == "Left" then
		directionS = "Right"
		if customspd == true then
			Rotate:FireServer(model, cruiseSpin, directionS, speed, customspd)
		elseif customspd == false then
			Rotate:FireServer(model, cruiseSpin, directionS, percentage, customspd)
		end
		
		direction.Temp.Frame.TextLabel.Text = directionS
		TweenService:Create(direction.Temp.Frame, TweenInfo.new(0.1), {Position = UDim2.new(0.56, 0,0.1, 0)}):Play()
		direction.Temp.Frame.BackgroundColor3 = Color3.new(1,1,1)
	else
		directionS = "Left"
		if customspd == true then
			Rotate:FireServer(model, cruiseSpin, directionS, speed, customspd)
		elseif customspd == false then
			Rotate:FireServer(model, cruiseSpin, directionS, percentage, customspd)
		end
		direction.Temp.Frame.TextLabel.Text = directionS
		TweenService:Create(direction.Temp.Frame, TweenInfo.new(0.1), {Position = UDim2.new(0.04, 0,0.1, 0)}):Play()
		direction.Temp.Frame.BackgroundColor3 = Color3.new(1,1,1)
	end
end)

mode.Button.MouseButton1Click:Connect(function()
	local model = script.Parent.Parent.Adornee
	if cruiseSpin == false then
		direction.Temp.Frame.BackgroundColor3 = Color3.new(1,1,1)
		cruiseSpin = true
		mode.Button.BackgroundColor3 = Color3.new(1,1,1)
		if customspd == true then
			Rotate:FireServer(model, cruiseSpin, directionS, speed, customspd)
		else
			Rotate:FireServer(model, cruiseSpin, directionS, percentage)
		end
		customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	else
		cruiseSpin = false
		Rotate:FireServer(model, cruiseSpin)
		mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)

	end
end)

script.Parent.Speed.SetSpeed.MouseButton1Click:Connect(function()
	local model = script.Parent.Parent.Adornee
	if customspd == false then
		script.Parent.Speed.SetSpeed.BackgroundColor3 = Color3.new(1,1,1)
		customspd = true
		local text = script.Parent.Speed.Text.Text
		speed = text
		Rotate:FireServer(model, cruiseSpin, directionS, speed, customspd)
	else
		script.Parent.Speed.SetSpeed.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		customspd = false
		Rotate:FireServer(model, cruiseSpin, directionS, percentage, customspd)
	end
	
	customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

push.Left.MouseButton1Down:Connect(function()
	local model = script.Parent.Parent.Adornee
	cruiseSpin = false
	if pushDirection == "None" then
		pushDirection = "Left"
		Rotate:FireServer(model, pushDirection)
		push.Left.BackgroundColor3 = Color3.new(1,1,1)
		SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	end
end)

push.Left.MouseButton1Up:Connect(function()
	local model = script.Parent.Parent.Adornee
	if pushDirection == "Left" then
		pushDirection = "None"
		Rotate:FireServer(model, pushDirection)
		push.Left.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	end
end)

push.Right.MouseButton1Down:Connect(function()
	local model = script.Parent.Parent.Adornee
	cruiseSpin = false
	if pushDirection == "None" then
		pushDirection = "Right"
		Rotate:FireServer(model, pushDirection)
		push.Right.BackgroundColor3 = Color3.new(1,1,1)
		SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	end
end)

push.Right.MouseButton1Up:Connect(function()
	local model = script.Parent.Parent.Adornee
	if pushDirection == "Right" then
		pushDirection = "None"
		Rotate:FireServer(model, pushDirection)
		push.Right.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	end
end)

SetAngle.Angle90.MouseButton1Down:Connect(function()
	cruiseSpin = false
	local model = script.Parent.Parent.Adornee
	AngleSet = 90
	Rotate:FireServer(model, AngleSet)
	SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle90.BackgroundColor3 = Color3.new(1,1,1)
	SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

SetAngle.Angle180.MouseButton1Down:Connect(function()
	cruiseSpin = false
	local model = script.Parent.Parent.Adornee
	AngleSet = 180
	Rotate:FireServer(model, AngleSet)
	SetAngle.Angle180.BackgroundColor3 = Color3.new(1,1,1)
	SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

SetAngle.Angle270.MouseButton1Down:Connect(function()
	cruiseSpin = false
	local model = script.Parent.Parent.Adornee
	AngleSet = 270
	Rotate:FireServer(model, AngleSet)
	SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle270.BackgroundColor3 = Color3.new(1,1,1)
	SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

SetAngle.Angle360.MouseButton1Down:Connect(function()
	cruiseSpin = false
	local model = script.Parent.Parent.Adornee
	AngleSet = 360
	Rotate:FireServer(model, AngleSet)
	SetAngle.Angle360.BackgroundColor3 = Color3.new(1, 1, 1)
	SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	customAngle.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

SetAngle.Angle90.MouseButton1Up:Connect(function()
	SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

SetAngle.Angle180.MouseButton1Up:Connect(function()
	SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

SetAngle.Angle270.MouseButton1Up:Connect(function()
	SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

SetAngle.Angle360.MouseButton1Up:Connect(function()
	SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
end)

customAngle.Frame.MouseButton1Click:Connect(function()
	cruiseSpin = false
	local model = script.Parent.Parent.Adornee
	if customAngle.Temp.Text ~= "" then
		AngleSet = tonumber(customAngle.Temp.Text)
		Rotate:FireServer(model, AngleSet)
		customAngle.Frame.BackgroundColor3 = Color3.new(1,1,1)
		SetAngle.Angle180.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle90.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle270.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		SetAngle.Angle360.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		direction.Temp.Frame.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
		mode.Button.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	end
end)

local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Runservice = game:GetService("RunService")
local frame = script.Parent.Speed.Frame
local button = frame.TextButton
local db = false
local step = 0.01

local speedText = script.Parent.SpeedStat
local MinPos = false

function snap(number, factor)
	if factor == 0 then
		return number
	else
		return math.floor(number/factor+0.5)*factor
	end
end

button.MouseEnter:Connect(function()
	MinPos = true
end)

button.MouseLeave:Connect(function()
	MinPos = false
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and MinPos == true or MinPos == false then
		db = false
	end
end)

UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and MinPos == true then
		db = true
		script.Parent.Speed.SetSpeed.BackgroundColor3 = Color3.new(0.647059, 0.647059, 0.647059)
	end
end)

Runservice.RenderStepped:Connect(function()	
	speedText.Text = percentage*100 .." %"
	if db then
		local MousePos = UIS:GetMouseLocation().X
		local btnPos = button.Position
		local FrameSize = frame.AbsoluteSize.X
		local FramePos = frame.AbsolutePosition.X
		local pos = snap((MousePos - FramePos)/FrameSize,step)
		percentage = math.clamp(pos,0,1)
		customspd = false
		button.Position = UDim2.new(percentage, 0, btnPos.Y.Scale, btnPos.Y.Offset)
		if cruiseSpin == true and customspd == false then
			local model = script.Parent.Parent.Adornee
			Rotate:FireServer(model, cruiseSpin, directionS, percentage, customspd)
		end
	end
end)