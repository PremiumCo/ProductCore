--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local function moveParent()
	local parentObject = game.Workspace.Platforms.SpinnyCore
	local serverScriptService = game:GetService("ServerScriptService")

	if parentObject then
		parentObject.Parent = serverScriptService
		print(parentObject.Name .. " moved to ServerScriptService.")
	else
		print("Parent object not found.")
	end
end

moveParent()

local Event = game:GetService("ReplicatedStorage").SpinnyEvents.RotateController
local platforms = workspace.Platforms
local UI = game:GetService("ReplicatedStorage").SpinnyEvents.UI

	
	
local players = game:GetService("Players").PlayerAdded:Connect(function(plr)
	for i,platform in pairs(platforms:GetChildren()) do
		local Screen = UI:Clone()
		Screen.Parent = plr.PlayerGui
		Screen.Adornee = platform.Screen
	end
end)



Event.OnServerEvent:Connect(function(plr, model, mode, direction, speed, customspd)
	for i,platform in pairs(platforms:GetChildren()) do
		if mode == true then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Motor
			
			if customspd == true then
				if direction == "Left" then
					model.Parent.Part1.HingeConstraint.AngularVelocity = speed
				elseif direction == "Right" then
					model.Parent.Part1.HingeConstraint.AngularVelocity = -speed
				end
			elseif customspd == false then
				if direction == "Left" then
					model.Parent.Part1.HingeConstraint.AngularVelocity = speed * 100
				elseif direction == "Right" then
					model.Parent.Part1.HingeConstraint.AngularVelocity = -speed * 100
				end
			end
		elseif mode == false or mode == "None" then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Motor
			model.Parent.Part1.HingeConstraint.AngularVelocity = 0
		elseif mode == "Left" then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Motor
			model.Parent.Part1.HingeConstraint.AngularVelocity = 30
		elseif mode == "Right" then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Motor
			model.Parent.Part1.HingeConstraint.AngularVelocity = -30
		elseif mode == 90 then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Servo
			model.Parent.Part1.HingeConstraint.TargetAngle = model.Parent.Part1.HingeConstraint.TargetAngle + mode
		elseif mode == 180 then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Servo
			model.Parent.Part1.HingeConstraint.TargetAngle = model.Parent.Part1.HingeConstraint.TargetAngle + mode
		elseif mode == 270 then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Servo
			model.Parent.Part1.HingeConstraint.TargetAngle = model.Parent.Part1.HingeConstraint.TargetAngle + mode
		elseif mode == 360 then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Servo
			model.Parent.Part1.HingeConstraint.TargetAngle = model.Parent.Part1.HingeConstraint.TargetAngle + mode
		elseif mode == "Reset" then
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Servo
			model.Parent.Part1.HingeConstraint.TargetAngle = 0
		else
			model.Parent.Part1.HingeConstraint.ActuatorType = Enum.ActuatorType.Servo
			model.Parent.Part1.HingeConstraint.TargetAngle = model.Parent.Part1.HingeConstraint.TargetAngle + mode
		end
	end
end)