--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local checkIfSetupIsCorrect = function()
	local Lift = script.Parent.Parent.Parent:FindFirstChild("BridgeLift")
	if not Lift then return "BridgeLift model could not be found!" end
	local Config = script.Parent.Parent.Parent:FindFirstChild("Configuration")
	if not Config then return "Configuration module could not be found!" end
	local Bridge = Lift:FindFirstChild("Bridge")
	if not Bridge then return "Bridge model could not be found inside BridgeLift!" end
	local Tops = Lift:FindFirstChild("Tops")
	if not Tops then return "TopAttachments model could not be found inside Bridge!" end
	
	return true
end

if checkIfSetupIsCorrect() ~= true then error(checkIfSetupIsCorrect()) return nil; end

local Bridge = script.Parent.Parent.Parent.BridgeLift
local Configuration = require(script.Parent.Parent.Parent.Configuration)

local Origin = Bridge.PrimaryPart.Position
local MaxHeight = (Bridge.Bridge.RopeConstraints.KEY.CurrentDistance)

for _,Rope in pairs(Bridge.Bridge.RopeConstraints:GetChildren()) do
	if Rope:IsA("RopeConstraint") then
		Rope.Length = Rope.CurrentDistance
	end
end
	
local LiftController = Instance.new("Vector3Value")
LiftController:GetPropertyChangedSignal("Value"):Connect(function()
	Bridge.Bridge:MoveTo(LiftController.Value)
	for _,Rope in pairs(Bridge.Bridge.RopeConstraints:GetChildren()) do
		if Rope:IsA("RopeConstraint") then
			Rope.Length = MaxHeight - LiftController.Value.Y
		end
	end
end)

LiftController.Value = Origin

local AnimatingHeight = false

local changeHeight = function(Height, StudOrPercent)
	Height = tonumber(Height)
	if Height == nil or not tonumber(Height) then return warn("We ran into an issue translating the height into an integer, please check your configuration [Bridge Lift]") end
	
	if StudOrPercent:lower() == "percent" then
		if Height >= 101 then return warn("Height percentage exceeded 100% limit - not changing height.") end
		if AnimatingHeight then return nil end
		
		AnimatingHeight = true
		
		local HeightVector =  if Height == 0 then 0 else ((MaxHeight - 3) * (Height/100))
		
		local TweenSequence = game.TweenService:Create(LiftController, TweenInfo.new(script.Parent.BG.Speed.Intensity.Value.Value / 10), {
			Value = Vector3.new(0,HeightVector,0) + Origin
		})
		
		TweenSequence:Play()
		TweenSequence.Completed:Wait()
		
		AnimatingHeight = false
	elseif StudOrPercent:lower() == "studs" then
		if Height > (MaxHeight - 3) then return warn("Height studs exceeded max height - not changing height.") end
		if AnimatingHeight then return nil end

		AnimatingHeight = true

		local TweenSequence = game.TweenService:Create(LiftController, TweenInfo.new(script.Parent.BG.Speed.Intensity.Value.Value / 10), {
			Value = Vector3.new(0,Height,0) + Origin
		})

		TweenSequence:Play()
		TweenSequence.Completed:Wait()

		AnimatingHeight = false
	end
end

for _,Button in pairs(script.Parent.BG.HeightControlsPercent:GetChildren()) do
	if Button:IsA("TextButton") then
		Button.MouseButton1Click:Connect(function()
			changeHeight(string.gsub(Button.Text,"%%",""), "percent")
		end)
	end
end

for _,Button in pairs(script.Parent.BG.HeightControlStuds:GetChildren()) do
	if Button:IsA("TextButton") then
		Button.MouseButton1Click:Connect(function()
			changeHeight(Button.Text, "studs")
		end)
	end
end

for GoalName,GoalData in pairs(Configuration.Goals) do
	local GoalButton = script.GoalButton:Clone()
	GoalButton.Parent = script.Parent.BG.CustomGoal
	GoalButton.Name = GoalName
	GoalButton.Text = GoalName
	GoalButton.Visible = true
	
	GoalButton.MouseButton1Click:Connect(function()
		local HeightValue = GoalData.HeightValue
		local HeightType = GoalData.HeightType
		
		if HeightValue == nil or HeightType == nil then return error(("\nGoal name %s is setup incorrectly, please review your configuration [Bridge Lift]"):format(GoalName)) end
		
		if HeightType:lower() == "percent" then
			wait()
		elseif HeightType:lower() == "studs" then
			wait()
		else
			return error(("\nHeight Type on goal %s is setup incorrectly, please review your configuration [Bridge Lift]"):format(GoalName))
		end 
		
		if not tonumber(HeightValue) then return error(("\nCould not translate height value into a number on goal %s, please review your configuration [Bridge Lift]"):format(GoalName)) end
		
		changeHeight(HeightValue, HeightType:lower())
	end)
end

for _,Button in pairs(script.Parent.BG:GetDescendants()) do
	if Button:IsA("TextButton") and Button.Name ~= "Intensity" then
		Button.MouseEnter:Connect(function()
			game.TweenService:Create(Button, TweenInfo.new(.4, Enum.EasingStyle.Quad), {
				BackgroundColor3 = Color3.fromRGB(255,255,255),
				TextColor3 = Color3.fromRGB(0,0,0)
			}):Play()
		end)
		
		Button.MouseLeave:Connect(function()
			game.TweenService:Create(Button, TweenInfo.new(.4, Enum.EasingStyle.Quad), {
				BackgroundColor3 = Color3.fromRGB(27,27,27),
				TextColor3 = Color3.fromRGB(255,255,255)
			}):Play()
		end)
	end
end