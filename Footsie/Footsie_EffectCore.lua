--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]



local TweenService = game:GetService("TweenService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainEvent = ReplicatedStorage:WaitForChild("MainEvent")

local Players = game:GetService("Players")


local function createColorTween(object, property, targetColor, duration)
	local tweenInfo = TweenInfo.new(duration)
	local goal = {}
	goal[property] = targetColor

	local tween = TweenService:Create(object, tweenInfo, goal)
	return tween
end

local function createPositionTween(object, property, targetPos, duration)
	local tweenInfo = TweenInfo.new(duration)
	local goal = {}
	goal[property] = targetPos

	local tween = TweenService:Create(object, tweenInfo, goal)
	return tween
end

local function createBrightnessTween(object, property, targetBrightness, duration)
	local tweenInfo = TweenInfo.new(duration)
	local goal = {}
	goal[property] = targetBrightness

	local tween = TweenService:Create(object, tweenInfo, goal)
	return tween
end

local function deactivateOtherPages(activePage, Plr) 

		local MainInterface = Plr.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
		local Headline = MainInterface:WaitForChild("Headline")
		
		for i,v in pairs(Headline:GetChildren()) do 
			if v.ClassName == "TextButton" and v.Name ~= activePage then
				local targetColor = Color3.new(1, 1, 1)
				local duration = 1

				local colorTween = createColorTween(v:WaitForChild("TextLabel"), "TextColor3", targetColor, duration)

				colorTween:Play()

				if MainInterface[v.Name].Position ~= UDim2.new(.5,0,1.55,0) then
					local initialPosition = MainInterface[v.Name].Position
					local PositionTween = createPositionTween(MainInterface[v.Name], "Position", UDim2.new(.5,0,1.55,0), .5)

					PositionTween:Play()
				end
			else if v.ClassName == "TextButton" and v.Name == activePage then
					local initialPosition = MainInterface[v.Name].Position
					local PositionTween = createPositionTween(MainInterface[v.Name], "Position", UDim2.new(initialPosition.X.Scale,0,.55,0), .5)

					PositionTween:Play()
				end 
			end	
		end
end



local footsiesFolder = workspace:WaitForChild("Footsies")

for _, foot in pairs(footsiesFolder:GetChildren()) do

	local Footsie = foot
	local LightsFolder = Footsie:WaitForChild("Lights")
	local LightsOn = game:GetService("Workspace"):WaitForChild("footiepanel"):WaitForChild("LigntIsOn").Value

MainEvent.OnServerEvent:Connect(function(Player, Use, Object)

	if Use == "ModesButton" then
		for a,b in pairs(Players:GetChildren()) do 
			deactivateOtherPages("Modes", b) 

			task.wait()

			local targetColor = Color3.new(0, 217, 0)
			local duration = 1
		

			local MainInterface = b.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
			local ModesButton = MainInterface:WaitForChild("Headline"):WaitForChild("Modes")
			
			local colorTween1 = createColorTween(ModesButton.TextLabel, "TextColor3", targetColor, duration)

			colorTween1:Play()
		end
	end
	
	
	if Use == "ColorsButton" then
		for a,b in pairs(Players:GetChildren()) do 
			deactivateOtherPages("Colors", b) 

			task.wait()

			local targetColor = Color3.new(0, 217, 0)
			local duration = 1
			
			local MainInterface = b.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
			local ColorsButton = MainInterface:WaitForChild("Headline"):WaitForChild("Colors")

			local colorTween2 = createColorTween(ColorsButton.TextLabel, "TextColor3", targetColor, duration)

			colorTween2:Play()
		end
	end
	
	
	if Use == "CustomButton" then
		for a,b in pairs(Players:GetChildren()) do 
			deactivateOtherPages("Custom", b) 

			task.wait()

			local targetColor = Color3.new(0, 217, 0)
			local duration = 1
			
			local MainInterface = b.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
			local CustomButton = MainInterface:WaitForChild("Headline"):WaitForChild("Custom")
			
			local colorTween2 = createColorTween(CustomButton.TextLabel, "TextColor3", targetColor, duration)

			colorTween2:Play()
		end
	end
	
	
	if Use == "ResetButton" then
		for a,b in pairs(Players:GetChildren()) do 
			deactivateOtherPages("Reset", b) 

			task.wait()

			local targetColor = Color3.new(0, 217, 0)
			local duration = 1
			
			local MainInterface = b.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
			local ResetButton = MainInterface:WaitForChild("Headline"):WaitForChild("Reset")
			
			local colorTween3 = createColorTween(ResetButton.TextLabel, "TextColor3", targetColor, duration)

			colorTween3:Play()
		end
	end
	
	
	
	
	
		if Use == "OnOff_Button" then
			print("ON/Off")
			if LightsOn == false then 
				LightsOn = true
				for i, light in pairs(LightsFolder:GetChildren()) do 
					light:WaitForChild("SurfaceLight").Brightness = 1
					light.Material = "Neon"
				end
			else if LightsOn == true then
					LightsOn = false
					for i, light in pairs(LightsFolder:GetChildren()) do 
						light:WaitForChild("SurfaceLight").Brightness = 0
						light.Material = "SmoothPlastic"
					end
				end
			end
	end

	
	if Use == "OnOffFade_Button" then
		if LightsOn == false then 
			for i, light in pairs(LightsFolder:GetChildren()) do 
				local brightnessTween = createBrightnessTween(light:WaitForChild("SurfaceLight"), "Brightness", 1, 1)

				brightnessTween:Play()
				light.Material = "Neon"
			end
			LightsOn = true
		else if LightsOn == true then
				for i, light in pairs(LightsFolder:GetChildren()) do 
					local brightnessTween = createBrightnessTween(light:WaitForChild("SurfaceLight"), "Brightness", 0, 1)

					brightnessTween:Play()
					light.Material = "SmoothPlastic"
				end
				LightsOn = false
			end
		end
	end
		
		
		if Use == "Random_Button" then
			if LightsOn == false then 
				LightsOn = true
				while LightsOn do 
					for i, light in pairs(LightsFolder:GetChildren()) do 
						light:WaitForChild("SurfaceLight").Brightness = math.random(0,1)
						if light:WaitForChild("SurfaceLight").Brightness == 1 then
							light.Material = "Neon"
						else 
							light.Material = "SmoothPlastic"
						end
					end
					task.wait(.2)
				end
			else if LightsOn == true then
					LightsOn = false
					for i, light in pairs(LightsFolder:GetChildren()) do 
						light:WaitForChild("SurfaceLight").Brightness = 0
						light.Material = "SmoothPlastic"
					end
				end
			end
		end	
		
		
		if Use == "RandomFade_Button" then
			if LightsOn == false then 
				LightsOn = true
				while LightsOn do 
					for i, light in pairs(LightsFolder:GetChildren()) do 
						local randomNumb = math.random(0,1)

						if randomNumb == 1 then
							local brightnessTween = createBrightnessTween(light:WaitForChild("SurfaceLight"), "Brightness", 1, 1)

							brightnessTween:Play()
							light.Material = "Neon"
						else 
							local brightnessTween = createBrightnessTween(light:WaitForChild("SurfaceLight"), "Brightness", 0, 1)

							brightnessTween:Play()

							light.Material = "SmoothPlastic"
						end
					end
					task.wait(.2)
				end
			else if LightsOn == true then
					LightsOn = false
					for i, light in pairs(LightsFolder:GetChildren()) do 
						local brightnessTween = createBrightnessTween(light:WaitForChild("SurfaceLight"), "Brightness", 0, 1)

						brightnessTween:Play()

						light.Material = "SmoothPlastic"
					end
				end
			end
		end
		
		
		if Use == "LeftToRight_Button" then
			if LightsOn == false then 
				LightsOn = true
				while LightsOn do 
					for i = 1, #LightsFolder:GetChildren() do 
						local light = LightsFolder:WaitForChild("L" .. i)
						light:WaitForChild("SurfaceLight").Brightness = 5
						light.Material = "Neon"

						task.wait()

						light:WaitForChild("SurfaceLight").Brightness = 0
						light.Material = "SmoothPlastic"
					end
				end
			else
				LightsOn = false
				for i, light in pairs(LightsFolder:GetChildren()) do 
					light:WaitForChild("SurfaceLight").Brightness = 0
					light.Material = "SmoothPlastic"
				end
			end
		end
		
		
		if Use == "RightToLeft_Button" then
			if LightsOn == false then 
				LightsOn = true
				while LightsOn do 
					for i = #LightsFolder:GetChildren(), 1, -1 do 
						local light = LightsFolder:WaitForChild("L" .. i)
						light:WaitForChild("SurfaceLight").Brightness = 5
						light.Material = "Neon"

						task.wait()

						light:WaitForChild("SurfaceLight").Brightness = 0
						light.Material = "SmoothPlastic"
					end
				end
			else
				LightsOn = false
				for i, light in pairs(LightsFolder:GetChildren()) do 
					light:WaitForChild("SurfaceLight").Brightness = 0
					light.Material = "SmoothPlastic"
				end
			end
		end
		
		
		if Use == "OddAndEven_Button" then
			if LightsOn == false then 
				LightsOn = true
				for i, light in pairs(LightsFolder:GetChildren()) do 
					if i % 2 == 0 then
						LightsFolder:WaitForChild("L" .. i):WaitForChild("SurfaceLight").Brightness = 1
						LightsFolder:WaitForChild("L" .. i).Material = "Neon"
					end
				end
			else
				LightsOn = false
				for i, light in pairs(LightsFolder:GetChildren()) do 
					light:WaitForChild("SurfaceLight").Brightness = 0
					light.Material = "SmoothPlastic"
				end
			end
		end
		
		
		if Use == "Flickering_Button" then
			if LightsOn == false then 
				LightsOn = true
				while LightsOn and task.wait(.5) do 
					for i, light in pairs(LightsFolder:GetChildren()) do 
						light:WaitForChild("SurfaceLight").Brightness = 1
						light.Material = "Neon"
					end
					task.wait(.5)
					for i, light in pairs(LightsFolder:GetChildren()) do 
						light:WaitForChild("SurfaceLight").Brightness = 0
						light.Material = "SmoothPlastic"
					end
				end
			else if LightsOn == true then
					LightsOn = false
					for i, light in pairs(LightsFolder:GetChildren()) do 
						light:WaitForChild("SurfaceLight").Brightness = 0
						light.Material = "SmoothPlastic"
					end
				end
			end
		end
		
		
		if Use == "InsideToOutside_Button" then
			if LightsOn == false then 
				LightsOn = true
				while LightsOn and task.wait(.5) do 
					spawn(function()
						for i = 24, 1, -1 do 
							local light = LightsFolder:WaitForChild("L" .. i)
							light:WaitForChild("SurfaceLight").Brightness = 5
							light.Material = "Neon"

							task.wait()

							light:WaitForChild("SurfaceLight").Brightness = 0
							light.Material = "SmoothPlastic"
						end
					end)

					spawn(function()
						for i = 24, 48, 1 do 
							local light = LightsFolder:WaitForChild("L" .. i)
							light:WaitForChild("SurfaceLight").Brightness = 5
							light.Material = "Neon"

							task.wait()

							light:WaitForChild("SurfaceLight").Brightness = 0
							light.Material = "SmoothPlastic"
						end
					end)
				end
			else
				LightsOn = false
				for i, light in pairs(LightsFolder:GetChildren()) do 
					light:WaitForChild("SurfaceLight").Brightness = 0
					light.Material = "SmoothPlastic"
				end
			end
		end
		
		

		
		if Use == "ColorValue" then
				local MainInterface = Player.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
				local ColorValue = MainInterface:WaitForChild("Colors"):WaitForChild("ColorPanel"):WaitForChild("Frame"):WaitForChild("Color")
				local SingularColorFrame = MainInterface:WaitForChild("Colors"):WaitForChild("SingularColors"):WaitForChild("Frame")	
				
		
				for i, light in pairs(LightsFolder:GetChildren()) do 
					light:WaitForChild("SurfaceLight").Color = ColorValue.Value
					light.BrickColor = BrickColor.new(ColorValue.Value)
				end
		end
		
	
		
		if Use == "GlobalReset_Button" then
			LightsOn = false
			for i, light in pairs(LightsFolder:GetChildren()) do 
				light:WaitForChild("SurfaceLight").Brightness = 0
				light:WaitForChild("SurfaceLight").Color = Color3.new(1,1,1)
				light.Material = "SmoothPlastic"
				light.BrickColor = BrickColor.new(1,1,1)
			end
		end
		
		
		if Use == "CustomButtons" then
			for i, light in pairs(LightsFolder:GetChildren()) do 
				light:WaitForChild("SurfaceLight").Color = Object
				light.BrickColor = BrickColor.new(Object)
			end
		end	
		
			
end)
	
end


for a,b in pairs(Players:GetChildren()) do 
	local MainInterface = b.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
	local ColorValue = MainInterface:WaitForChild("Colors"):WaitForChild("ColorPanel"):WaitForChild("Frame"):WaitForChild("Color")
	local SingularColorFrame = MainInterface:WaitForChild("Colors"):WaitForChild("SingularColors"):WaitForChild("Frame")	
	for i, ColorButton in pairs(SingularColorFrame:GetChildren()) do 
		if ColorButton.ClassName == "TextButton" then
			ColorButton.MouseButton1Click:Connect(function()
				ColorValue.Value = ColorButton.Value.Value 
			end)
		end
	end
end


Players.PlayerAdded:Connect(function(player)	
	local MainInterface = player.PlayerGui:WaitForChild("SurfaceGui"):WaitForChild("MainInterface")
	local ColorValue = MainInterface:WaitForChild("Colors"):WaitForChild("ColorPanel"):WaitForChild("Frame"):WaitForChild("Color")
	local SingularColorFrame = MainInterface:WaitForChild("Colors"):WaitForChild("SingularColors"):WaitForChild("Frame")	
	for i, ColorButton in pairs(SingularColorFrame:GetChildren()) do 
		if ColorButton.ClassName == "TextButton" then
			ColorButton.MouseButton1Click:Connect(function()
				ColorValue.Value = ColorButton.Value.Value 
			end)
		end
	end
end)