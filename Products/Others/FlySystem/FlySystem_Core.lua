--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

--Controlbox Config
local Controlbox = script.Parent:FindFirstChild("ControlBox")
local ControlBoxMoveButtonsOff = Color3.fromRGB(0, 85, 0)
local ControlBoxMoveButtonsOn = Color3.fromRGB(0, 255, 127)
local ControlBoxStopButtonsOff = Color3.fromRGB(127, 0, 0)
local ControlBoxStopButtonsOn = Color3.fromRGB(255, 0, 0)
local ControlBoxMaintButtonsOn = Color3.fromRGB(255, 255, 255)
local ControlBoxMaintButtonsOff = Color3.fromRGB(138, 138, 138)

local tweenService = game:GetService("TweenService")

local doorModel = script.Parent
local RigName
local door = doorModel:WaitForChild("WELD To THIS")
local goal = doorModel:WaitForChild("MaxHeight")
local MaintenanceLevel = doorModel:WaitForChild("Maintenance")
local button = doorModel
local MasterCtrl = false
local OffColor = Color3.fromRGB(51, 52, 52)
local MovingColor = Color3.fromRGB(255, 0, 0)
local OnColor = Color3.fromRGB(85, 255, 127)
--
--Controlbox Config
local Controlbox = script.Parent:FindFirstChild("ControlBox")
local ControlBoxMoveButtonsOff = Color3.fromRGB(0, 85, 0)
local ControlBoxMoveButtonsOn = Color3.fromRGB(0, 255, 127)
local canOpen = true
local down = false
local origCFrame = door.PrimaryPart.CFrame

--CONFIG VARIABLES
local uptime = script.Parent:GetAttribute("Speed")
local downtime = 0 --the amount of time it takes for the door to open
local waitTime = script.Parent:GetAttribute("waitTime") --the amount of time to wait after the door has finished moving that you can use the button again
--yep
local Controller = script.Parent:FindFirstChild("Panel")
goal.Transparency = 1
MaintenanceLevel.Transparency = 1
door.PrimaryPart.Transparency = 1
Controller.SurfaceGui.Central.RigName.Text= script.Parent.Name
if Controlbox then
	Controlbox.Screen.SurfaceGui.Frame.RigName.TextLabel.Text = script.Parent.Name

end
local function tweenModel(model, CF, info)
	print("Tween Running")
	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = model:GetPrimaryPartCFrame()

	CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:SetPrimaryPartCFrame(CFrameValue.Value)
	end)

	local tween = tweenService:Create(CFrameValue, info, {Value = CF})
	tween:Play()
	if Controller then
		Controller.SurfaceGui.Central.Stop.MouseButton1Click:Connect(function()
			tween:Cancel()
			CFrameValue:Destroy()
			canOpen = true
			if Controlbox then
				Controlbox.Screen.SurfaceGui.Frame.Pos.TextLabel.Text = "Custom"

			end
		end)
	end
	if Controlbox then
		Controlbox.Buttons.Stop.ClickDetector.MouseClick:Connect(function()
			tween:Cancel()
			CFrameValue:Destroy()
			canOpen = true
			Controlbox.Screen.SurfaceGui.Frame.Pos.TextLabel.Text = "Custom"

		end)
	end
	tween.Completed:Connect(function()
		CFrameValue:Destroy()
		if Controller then
			tweenService:Create(Controller.SurfaceGui.Central.Up.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Down.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Stop.UIStroke, TweenInfo.new(0.1), {Color = MovingColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Maint.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()	
		end
		if Controlbox then
			tweenService:Create(Controlbox.Buttons.Up, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Down, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Stop, TweenInfo.new(0.1), {Color = ControlBoxStopButtonsOn}):Play()
			tweenService:Create(Controlbox.Buttons.Maintenance, TweenInfo.new(0.1), {Color = ControlBoxMaintButtonsOff}):Play()


		end
	end)
end
--Pos Up


Up = function()
	if canOpen then
		canOpen = false
		print("Moving Up")
		if Controller then
		tweenService:Create(Controller.SurfaceGui.Central.Up.UIStroke, TweenInfo.new(0.1), {Color = OnColor}):Play()
		tweenService:Create(Controller.SurfaceGui.Central.Down.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
		tweenService:Create(Controller.SurfaceGui.Central.Stop.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Maint.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
		end
		
		if Controlbox then
			tweenService:Create(Controlbox.Buttons.Up, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOn}):Play()
			tweenService:Create(Controlbox.Buttons.Down, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Stop, TweenInfo.new(0.1), {Color = ControlBoxStopButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Maintenance, TweenInfo.new(0.1), {Color = ControlBoxMaintButtonsOff}):Play()
			Controlbox.Screen.SurfaceGui.Frame.Pos.TextLabel.Text = "Up"

		end
		tweenModel(door, goal.CFrame, TweenInfo.new(uptime))
		wait(waitTime + uptime)
		canOpen = true
	end
end
--Pos Down

Down = function()
	if canOpen then
		canOpen = false
		print("Moving Down")
		if Controller then
			tweenService:Create(Controller.SurfaceGui.Central.Up.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Down.UIStroke, TweenInfo.new(0.1), {Color = OnColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Stop.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Maint.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
		end
		if Controlbox then
			tweenService:Create(Controlbox.Buttons.Up, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Down, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOn}):Play()
			tweenService:Create(Controlbox.Buttons.Stop, TweenInfo.new(0.1), {Color = ControlBoxStopButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Maintenance, TweenInfo.new(0.1), {Color = ControlBoxMaintButtonsOff}):Play()
			Controlbox.Screen.SurfaceGui.Frame.Pos.TextLabel.Text = "Down"

		end
		tweenModel(door, origCFrame, TweenInfo.new(uptime))
		wait(waitTime + uptime)
		canOpen = true
	end
end
--Pos Maintenance
Maintenance = function()
	if canOpen then
		canOpen = false
		if Controller then
			tweenService:Create(Controller.SurfaceGui.Central.Up.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Down.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Stop.UIStroke, TweenInfo.new(0.1), {Color = OffColor}):Play()
			tweenService:Create(Controller.SurfaceGui.Central.Maint.UIStroke, TweenInfo.new(0.1), {Color = OnColor}):Play()
		end
		if Controlbox then
			tweenService:Create(Controlbox.Buttons.Up, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Down, TweenInfo.new(0.1), {Color = ControlBoxMoveButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Stop, TweenInfo.new(0.1), {Color = ControlBoxStopButtonsOff}):Play()
			tweenService:Create(Controlbox.Buttons.Maintenance, TweenInfo.new(0.1), {Color = ControlBoxMaintButtonsOn}):Play()
			Controlbox.Screen.SurfaceGui.Frame.Pos.TextLabel.Text = "Maintenance"
		end
		tweenModel(door, MaintenanceLevel.CFrame, TweenInfo.new(uptime))
		wait(waitTime + uptime)
		canOpen = true
	end
end
if Controller then
	Controller.SurfaceGui.Central.Up.MouseButton1Click:Connect(function()
		Up()
	end)
	Controller.SurfaceGui.Central.Down.MouseButton1Click:Connect(function()
		Down()
	end)
	Controller.SurfaceGui.Central.Maint.MouseButton1Click:Connect(function()
		Maintenance()
	end)	
end

if Controlbox then
	Controlbox.Buttons.Up.ClickDetector.MouseClick:Connect(function()
		Up()
	end)
	Controlbox.Buttons.Down.ClickDetector.MouseClick:Connect(function()
		Down()
	end)
	Controlbox.Buttons.Maintenance.ClickDetector.MouseClick:Connect(function()
		Maintenance()
	end)
end