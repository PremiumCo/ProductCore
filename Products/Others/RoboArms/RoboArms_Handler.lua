--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

game.Workspace.PremiumRobots.Panel:WaitForChild("SurfaceGui")
local FixturesB = script.Parent.Fixture.SelectionF
local GroupB = script.Parent.Fixture.SelectionG
local CuesB = script.Parent.Cues.Selection
local PositionsB = script.Parent.Positions.Selection
local ResetSwitch = script.Parent.Topbar.ResetSwitch

local Fixtures = script.Parent.Parent.Parent.Parent.Fixtures
local CurrentFixture = script.CurrentFixture
local IsGroup = script.IsGroup.Value
local SwitchGF = script.Parent.Fixture.Switch
local SwitchGFStatus = 0
local InGameWhitelist = script.IngameWhitelist

local Config = require(script.Parent.Parent.Parent.Parent.Config)
local TweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local LastFixtureP = nil
local LastGroupP = nil


mouse = false
local Fader = script.Parent.Slider
local Positions = require(script.Parent.Parent.Parent.Parent.Positions)
local Cues = script.Parent.Parent.Parent.Parent.Animations

players.PlayerAdded:Connect(function(plr)
	local ingamewl = InGameWhitelist:Clone()
	ingamewl.Parent = plr.PlayerGui
	ingamewl.Enabled = true
end)
local function ColorStuff()
	local topbar = script.Parent.Topbar
	local OtherUis = script.Parent
	local color = Config.Coloring.BaseColor
	script.Temp.PName.TextColor3 = color
	script.Temp2.PName.TextColor3 = color
	topbar.PName.TextColor3 = color
	topbar.ResetSwitch.TextColor3 = color
	topbar.Switch.TextColor3 = color
	topbar.ImageLabel.ImageColor3 = color
	OtherUis.Fixture.PName.TextColor3 = color
	OtherUis.Fixture.Switch.TextColor3 = color
	OtherUis.Positions.PName.TextColor3 = color
	OtherUis.Cues.PName.TextColor3 = color
	OtherUis.Slider.Int.TextColor3 = color

end
function MakeErrorShow(Message)
	local perror = script.Parent.Topbar.PError
	local Twinfo =  TweenInfo.new(0,Enum.EasingStyle.Sine)
	perror.Text = Message
	TweenService:Create(perror,TweenInfo.new(0,Enum.EasingStyle.Sine),{TextTransparency = 0}):Play();wait(0)
	for count = 1, 4 do
		TweenService:Create(perror,Twinfo,{ TextColor3 = Config.Coloring.BaseColor}):Play();wait(0.2)
		TweenService:Create(perror,Twinfo,{ TextColor3 = Config.Coloring.ErrorColor}):Play();wait(0.2)
	end
	wait(2.5)
	TweenService:Create(perror,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{TextTransparency = 1}):Play();wait(0.2)
	TweenService:Create(perror,Twinfo,{ TextColor3 = Config.Coloring.BaseColor}):Play()
end
ColorStuff()

Fader.Intensity.MouseButton1Down:connect(function() mouse=true  end)
Fader.Intensity.MouseButton1Up:connect(function()   mouse=false end)
Fader.Intensity.MouseLeave:connect(function(x,y) mouse=false end)
Fader.Intensity.MouseMoved:connect(function(x,y)
	if mouse then

		if 100-(((y-Fader.Intensity.AbsolutePosition.Y)/1220)*10) > 2 then
			Fader.Intensity.Value.Value = 10-(((y-Fader.Intensity.AbsolutePosition.Y)/1220)*10)
		else
			Fader.Intensity.Value.Value = 0
		end
		Fader.Intensity.Bar.Size = UDim2.new(1, 0, ((1-((y-Fader.Intensity.AbsolutePosition.Y)/1220))), 0)

	end
end)
Fader.Intensity.Value.Value = 0
Fader.Intensity.Value.Changed:connect(function()
	Fader.Intensity.Bar.Size = UDim2.new(1, 0, (Fader.Intensity.Value.Value/2)/10, 0)
	Fader.Int.Text = Fader.Intensity.Value.Value*Config.FaderMultyplier.SpeedFader
end)


for i,v in Positions.Positions do
	local TempPositionButton= script.Temp2:Clone()
	TempPositionButton.Parent = PositionsB
	TempPositionButton.PName.Text = v.Name
	TempPositionButton.Name = v.Name
end

for i,v in Cues:GetChildren() do
	local TempCueButton= script.Temp2:Clone()
	local Cue = require(v)
	TempCueButton.Parent = CuesB
	TempCueButton.PName.Text = Cue.Config.Name
	TempCueButton.Name = Cue.Config.Name
end

for i,v in Fixtures:GetChildren() do
	if FixturesB:FindFirstChild(v.Name) then
	else
		local TempFixtureButton = script.Temp:Clone()
		TempFixtureButton.Parent = FixturesB
		TempFixtureButton.PName.Text = v.Name
		TempFixtureButton.Name = v.Name
	end
	if GroupB:FindFirstChild(v.Group.value) then
	else
		local TempGroupButton = script.Temp:Clone()
		TempGroupButton.Parent = GroupB
		TempGroupButton.PName.Text = v.Group.value
		TempGroupButton.Name = v.Group.value
		TempGroupButton.Indicator.BackgroundColor3 = Config.Coloring.SecondaryButtonDisabled
	end
end


local function FixtureMove(data)
	for i,v in Positions.Positions do
		if v.Name == data then
			local FaderSpeedValue = script.Parent.Slider.Intensity.Value.Value
			local x1,x2,x3,y1,y2,y3 = v.x1,v.x2,v.x3,v.y1,v.y2,v.y3
			if IsGroup == false then
				for i,v in Fixtures:GetChildren() do
					if v.Name == script.CurrentFixture.value then
						local TWinfo = TweenInfo.new(FaderSpeedValue,Enum.EasingStyle.Linear)
						local X1,X2,X3,Y1,Y2,Y3 = v.Motor.X1,v.Motor.X2,v.Motor.X3,v.Motor.Y1,v.Motor.Y2,v.Motor.Y3
						TweenService:Create(X1,TWinfo,{ DesiredAngle = x1}):Play()
						TweenService:Create(X2,TWinfo,{ DesiredAngle = x2}):Play()
						TweenService:Create(X3,TWinfo,{ DesiredAngle = x3}):Play()
						TweenService:Create(Y1,TWinfo,{ DesiredAngle = y1}):Play()
						TweenService:Create(Y2,TWinfo,{ DesiredAngle = y2}):Play()
						TweenService:Create(Y3,TWinfo,{ DesiredAngle = y3}):Play()
					end

				end
			end
			for i,v in Fixtures:GetChildren() do
				if v.Group.value == script.CurrentFixture.value then
					local TWinfo = TweenInfo.new(FaderSpeedValue,Enum.EasingStyle.Linear)
					local X1,X2,X3,Y1,Y2,Y3 = v.Motor.X1,v.Motor.X2,v.Motor.X3,v.Motor.Y1,v.Motor.Y2,v.Motor.Y3
					TweenService:Create(X1,TWinfo,{ DesiredAngle = x1}):Play()
					TweenService:Create(X2,TWinfo,{ DesiredAngle = x2}):Play()
					TweenService:Create(X3,TWinfo,{ DesiredAngle = x3}):Play()
					TweenService:Create(Y1,TWinfo,{ DesiredAngle = y1}):Play()
					TweenService:Create(Y2,TWinfo,{ DesiredAngle = y2}):Play()
					TweenService:Create(Y3,TWinfo,{ DesiredAngle = y3}):Play()
				end
			end
		end
	end			
end


local function FixtureCueMove(data)
	spawn(function()
		local CRNTFixture = script.CurrentFixture.Value
		for i,e in Cues:GetChildren() do
			local CurrentAnimation = require(e)
			if CurrentAnimation.Config.Name == data then
				for i,v in CurrentAnimation.Positions do
					local x1,x2,x3,y1,y2,y3 = v.x1,v.x2,v.x3,v.y1,v.y2,v.y3
					local Time = CurrentAnimation.Config.speed
					local waitr = v.xwait
					if IsGroup == false then
						for i,v in Fixtures:GetChildren() do
							if v.Name == CRNTFixture then
								local TWinfo = TweenInfo.new(Time,Enum.EasingStyle.Linear)
								local X1,X2,X3,Y1,Y2,Y3 = v.Motor.X1,v.Motor.X2,v.Motor.X3,v.Motor.Y1,v.Motor.Y2,v.Motor.Y3
								TweenService:Create(X1,TWinfo,{ DesiredAngle = x1}):Play()
								TweenService:Create(X2,TWinfo,{ DesiredAngle = x2}):Play()
								TweenService:Create(X3,TWinfo,{ DesiredAngle = x3}):Play()
								TweenService:Create(Y1,TWinfo,{ DesiredAngle = y1}):Play()
								TweenService:Create(Y2,TWinfo,{ DesiredAngle = y2}):Play()
								TweenService:Create(Y3,TWinfo,{ DesiredAngle = y3}):Play()
							end
						end
					else
						for i,v in Fixtures:GetChildren() do
							if v.Group.value == CRNTFixture then
								local TWinfo = TweenInfo.new(Time,Enum.EasingStyle.Linear)
								local X1,X2,X3,Y1,Y2,Y3 = v.Motor.X1,v.Motor.X2,v.Motor.X3,v.Motor.Y1,v.Motor.Y2,v.Motor.Y3
								TweenService:Create(X1,TWinfo,{ DesiredAngle = x1}):Play()
								TweenService:Create(X2,TWinfo,{ DesiredAngle = x2}):Play()
								TweenService:Create(X3,TWinfo,{ DesiredAngle = x3}):Play()
								TweenService:Create(Y1,TWinfo,{ DesiredAngle = y1}):Play()
								TweenService:Create(Y2,TWinfo,{ DesiredAngle = y2}):Play()
								TweenService:Create(Y3,TWinfo,{ DesiredAngle = y3}):Play()
							end
						end
					end
					wait(waitr)
				end
			end
		end
	end)
end

SwitchGF.MouseButton1Click:Connect(function()
	if SwitchGFStatus == 0 then
		SwitchGFStatus = 1
		FixturesB.Visible = false
		GroupB.Visible = true
		SwitchGF.Parent.PName.Text = "Group"
	elseif SwitchGFStatus == 1 then
		SwitchGFStatus = 0
		FixturesB.Visible = true
		GroupB.Visible = false
		SwitchGF.Parent.PName.Text = "Fixture"
	end
end)
for i,v in PositionsB:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			if Fader.Intensity.Value.Value == 0 then
				MakeErrorShow("Please define the Speed")
			else

				if script.CurrentFixture.Value == "" then
					MakeErrorShow("Please select a Fixture")
				else	
					spawn(function()
						FixtureMove(v.Name)
						TweenService:Create(v.Indicator,TweenInfo.new(0.15,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.ButtonActivated}):Play()
						wait(0.15)
						TweenService:Create(v.Indicator,TweenInfo.new(0.15,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.MainButtonDisabled}):Play()
					end)
				end
			end
		end)
	end
end
for i,v in CuesB:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			if Fader.Intensity.Value.Value == 0 then
				MakeErrorShow("Please define the Speed")
			else
				if script.CurrentFixture.Value == "" then
					MakeErrorShow("Please select a Fixture")
				else	
					spawn(function()
						FixtureCueMove(v.Name)
						TweenService:Create(v.Indicator,TweenInfo.new(0.15,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.ButtonActivated}):Play()
						wait(0.15)
						TweenService:Create(v.Indicator,TweenInfo.new(0.15,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.MainButtonDisabled}):Play()
					end)
				end
			end

		end)
	end
end
for i,v in FixturesB:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			for i,v in FixturesB:GetChildren() do
				if v:IsA("TextButton") then
					if v.PName.Text == LastFixtureP then
						TweenService:Create(v.Indicator,TweenInfo.new(0.25,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.MainButtonDisabled}):Play()
					end
				end
			end			
			for i,v in GroupB:GetChildren() do
				if v:IsA("TextButton") then
					if v.PName.Text == LastGroupP then
						TweenService:Create(v.Indicator,TweenInfo.new(0.25,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.SecondaryButtonDisabled}):Play()
					end
				end	
			end
			script.CurrentFixture.Value = v.PName.Text
			IsGroup = false
			TweenService:Create(v.Indicator,TweenInfo.new(0.25,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.ButtonActivated}):Play()
			LastFixtureP = v.PName.Text
		end)
	end
end
for i,v in GroupB:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			for i,v in FixturesB:GetChildren() do
				if v:IsA("TextButton") then
					if v.PName.Text == LastFixtureP then
						TweenService:Create(v.Indicator,TweenInfo.new(0.25,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.MainButtonDisabled}):Play()
					end
				end
			end			
			for i,v in GroupB:GetChildren() do
				if v:IsA("TextButton") then
					if v.PName.Text == LastGroupP then
						TweenService:Create(v.Indicator,TweenInfo.new(0.25,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.SecondaryButtonDisabled}):Play()
					end
				end
			end
			script.CurrentFixture.Value = v.PName.Text
			IsGroup = true
			TweenService:Create(v.Indicator,TweenInfo.new(0.25,Enum.EasingStyle.Sine), {BackgroundColor3 = Config.Coloring.ButtonActivated}):Play()
			LastGroupP = v.PName.Text
		end)
	end
end
ResetSwitch.MouseButton1Click:Connect(function()
	for i,v in Fixtures:GetChildren() do
		local X1,X2,X3,Y1,Y2,Y3 = v.Motor.X1,v.Motor.X2,v.Motor.X3,v.Motor.Y1,v.Motor.Y2,v.Motor.Y3
		X1.DesiredAngle = 0
		X2.DesiredAngle = 0
		X3.DesiredAngle = 0
		Y1.DesiredAngle = 0
		Y2.DesiredAngle = 0
		Y3.DesiredAngle = 0
	end
end)
