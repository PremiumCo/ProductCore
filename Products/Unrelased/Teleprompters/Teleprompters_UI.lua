--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local clear = script.Parent.Frame.Clear
local confirm = script.Parent.Frame.Confirm
local down = script.Parent.Frame.Down
local up = script.Parent.Frame.Up
local tBox = script.Parent.BoardTxt.BoardTxt.Frame.TextBox
local slider = script.Parent.Frame.Slider.ActivationStat
local close = script.Parent.Frame.Close
local edit = script.Parent.Frame.Edit


local editing = false
local status = false
local scroll = ""

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local configuration = require(ReplicatedStorage.Events.Configuration)

local scrollClear = ReplicatedStorage.Events.ClearScroll
local scrollEvent = ReplicatedStorage.Events.Scroll
local displayOn = ReplicatedStorage.Events.DisplayOn
local textDisplayEvent = ReplicatedStorage.Events.TVText

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightControl then
		local player = game:GetService("Players").LocalPlayer
		player.PlayerGui.TVController.Enabled = true
	end

--	if input.KeyCode == Enum.KeyCode.RightControl then
--		local player = game:GetService("Players").LocalPlayer
--		local playerrank = player:GetRankInGroup(configuration.permission["Group Lock"].GroupID)
--		if configuration.permission["Group Lock"].Enabled == true and player:IsInGroup(configuration.permission["Group Lock"].GroupID) and playerrank > configuration.permission["Group Lock"].MinRankID then
--			player.PlayerGui.TVController.Enabled = true
--		else
--			print(configuration.permission["User Lock"].AllowedUsers)
--		end
--	end
end)

edit.MouseButton1Click:Connect(function()
	if editing == false then
		editing = true
		edit.BackgroundColor3 = Color3.new(1, 1, 1)
		edit.ImageLabel.ImageColor3 = Color3.new(0.192157, 0.192157, 0.192157)
		local tween = TweenService:Create(tBox.Parent.Parent.Parent, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 0.07, 0); Size = UDim2.new(0.759, 0,0.85,0)})
		tween:Play()
	else
		editing = false
		edit.BackgroundColor3 = Color3.new(0.192157, 0.192157, 0.192157)
		edit.ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
		local tween = TweenService:Create(tBox.Parent.Parent.Parent, TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.759, 0, 0.07, 0); Size = UDim2.new(0, 0,0.85,0)})
		tween:Play()
	end

end)

close.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.Enabled = false
end)


local function Scroll(direction, start)
	if status then
		scrollEvent:FireServer(direction, start)
	end
end

up.MouseButton1Down:Connect(function()
	Scroll("Up", true)
end)

down.MouseButton1Down:Connect(function()
	Scroll("Down", true)
end)

up.MouseButton1Up:Connect(function()
	Scroll("Up", false)
end)

down.MouseButton1Up:Connect(function()
	Scroll("Down", false)
end)


clear.MouseButton1Click:Connect(function()
	tBox.Text = ""
	textDisplayEvent:FireServer(tBox.Text)
	scrollClear:FireServer()
end)

confirm.MouseButton1Click:Connect(function()
	textDisplayEvent:FireServer(tBox.Text)
end)

slider.Parent.TextButton.MouseButton1Click:Connect(function()
	if status == false then
		status = true
		slider:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, .3)
		slider.BackgroundColor3 = Color3.new(0, 0.333333, 0)
		slider.TextLabel.Text = "On"
		displayOn:FireServer(status)
	elseif status == true then
		status = false
		slider:TweenPosition(UDim2.new(.5,0,0,0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, .3)
		slider.BackgroundColor3 = Color3.new(0.666667, 0, 0)
		slider.TextLabel.Text = "Off"
		displayOn:FireServer(status)
	end
end)