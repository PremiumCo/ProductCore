--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local TweenService = game:GetService("TweenService")

local Headline = script.Parent
local MainInterface = Headline.Parent
local ModesButton = Headline:WaitForChild("Modes")
local ColorsButton = Headline:WaitForChild("Colors")
local CustomButton = Headline:WaitForChild("Custom")
local ResetButton = Headline:WaitForChild("Reset")
local ModesTextColor = ModesButton:WaitForChild("TextLabel").TextColor3
local ColorsTextColor = ColorsButton:WaitForChild("TextLabel").TextColor3
local CustomTextColor = CustomButton:WaitForChild("TextLabel").TextColor3
local ResetTextColor = ResetButton:WaitForChild("TextLabel").TextColor3

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainEvent = ReplicatedStorage:WaitForChild("MainEvent")

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

local function deactivateOtherPages(activePage) 
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


-- UserInterface Scripting
ModesButton.MouseButton1Click:Connect(function()
	MainEvent:FireServer("ModesButton", ModesButton)
end)

ColorsButton.MouseButton1Click:Connect(function()
	MainEvent:FireServer("ColorsButton", ColorsButton)
end)

CustomButton.MouseButton1Click:Connect(function()
	MainEvent:FireServer("CustomButton", CustomButton)
end)


ResetButton.MouseButton1Click:Connect(function()
	MainEvent:FireServer("ResetButton", ResetButton)
end)




-- Modes Scripting
local FootsiePanel = MainInterface.Parent.Parent

local Footsies 


local footsiesFolder = workspace:WaitForChild("Footsies")






	local ModesPage = MainInterface:WaitForChild("Modes")
	local ModesButtonsFrame = ModesPage:WaitForChild("Background"):WaitForChild("Frame")

	local OnOff_Button = ModesButtonsFrame:WaitForChild("O/X")
	local OnOffFade_Button = ModesButtonsFrame:WaitForChild("Fade")
	local Random_Button = ModesButtonsFrame:WaitForChild("Random")
	local RandomFade_Button = ModesButtonsFrame:WaitForChild("FadeRandom")
	local LeftToRight_Button = ModesButtonsFrame:WaitForChild("LeftToRight")
	local RightToLeft_Button = ModesButtonsFrame:WaitForChild("RightToLeft")
	local OddAndEven_Button = ModesButtonsFrame:WaitForChild("OddAndEven")
	local Flickering_Button = ModesButtonsFrame:WaitForChild("Flickering")
	local InsideToOutside_Button = ModesButtonsFrame:WaitForChild("InsideToOutside")


	OnOff_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("OnOff_Button", OnOff_Button)
	end)


	OnOffFade_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("OnOffFade_Button", OnOffFade_Button)
	end)


	Random_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("Random_Button", Random_Button)
	end)


	RandomFade_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("RandomFade_Button", RandomFade_Button)
	end)


	LeftToRight_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("LeftToRight_Button", LeftToRight_Button)
	end)


	RightToLeft_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("RightToLeft_Button", RightToLeft_Button)
	end)


	OddAndEven_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("OddAndEven_Button", OddAndEven_Button)
	end)


	Flickering_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("Flickering_Button", Flickering_Button)
	end)


	InsideToOutside_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("InsideToOutside_Button", InsideToOutside_Button)
	end)


	-- Color Changer
	local ColorValue = MainInterface:WaitForChild("Colors"):WaitForChild("ColorPanel"):WaitForChild("Frame"):WaitForChild("Color")
	local SingularColorFrame = MainInterface:WaitForChild("Colors"):WaitForChild("SingularColors"):WaitForChild("Frame")

	ColorValue.Changed:Connect(function()
		MainEvent:FireServer("ColorValue", ColorValue)
	end)


	-- Reset Button
	local GlobalReset_Button = MainInterface:WaitForChild("Reset"):WaitForChild("Background"):WaitForChild("Frame"):WaitForChild("Reset")

	GlobalReset_Button.MouseButton1Click:Connect(function()
		MainEvent:FireServer("GlobalReset_Button", GlobalReset_Button)
	end)









local CustomPage = MainInterface:WaitForChild("Custom")
local CustomColorsFrame = CustomPage:WaitForChild("SingularColors"):WaitForChild("Frame")
local ColorShower = CustomPage:WaitForChild("ColorShower")
local ColorShowerFrame = ColorShower:WaitForChild("Frame"):WaitForChild("BackgroundColor"):WaitForChild("ColorShower")
local SelectedButton = ColorShower:WaitForChild("Frame"):WaitForChild("BackgroundColor"):WaitForChild("ColorShower"):WaitForChild("SelectedButton")
local DeleteColorButton = ColorShower:WaitForChild("Frame"):WaitForChild("BackgroundDeleteButton"):WaitForChild("DeleteColor")

local SetColorRed = CustomPage:WaitForChild("ColorInput"):WaitForChild("Frame"):WaitForChild("Red")
local SetColorBlue = CustomPage:WaitForChild("ColorInput"):WaitForChild("Frame"):WaitForChild("Blue")
local SetColorGreen = CustomPage:WaitForChild("ColorInput"):WaitForChild("Frame"):WaitForChild("Green")

local SetColor = CustomPage:WaitForChild("ColorInput"):WaitForChild("Frame"):WaitForChild("SetColor")


for i,v in pairs(CustomColorsFrame:GetChildren()) do
	if v.ClassName == "TextButton" then
		v.MouseButton1Click:Connect(function()
			SelectedButton.Value = v
			ColorShowerFrame.BackgroundColor3 = SelectedButton.Value.BackgroundColor3
			MainEvent:FireServer("CustomButtons", SelectedButton.Value.BackgroundColor3)
		end)
	end
end

local function round(n)
	return math.floor(n + 0.5)
end

ColorShowerFrame:GetPropertyChangedSignal("BackgroundColor"):Connect(function()
	if SelectedButton.Value == nil then
		print("No Custom Button Selected!")
	else
	SelectedButton.Value.BackgroundColor3 = ColorShowerFrame.BackgroundColor3
	ColorShowerFrame.ColorNumbers.Text = round(SelectedButton.Value.BackgroundColor3.r * 255)   .. ", ".. round(SelectedButton.Value.BackgroundColor3.g * 255)  .. ", ".. round(SelectedButton.Value.BackgroundColor3.b * 255) 
	MainEvent:FireServer("CustomButtons", SelectedButton.Value.BackgroundColor3)
	end
end)


DeleteColorButton.MouseButton1Click:Connect(function()
	ColorShowerFrame.BackgroundColor3 = Color3.new(1,1,1)
end)

SetColor.MouseButton1Click:Connect(function()
	ColorShowerFrame.BackgroundColor3 = Color3.new((tonumber(SetColorRed.TextBox.Text) or 0) / 255  ,(tonumber(SetColorGreen.TextBox.Text) or 0) / 255  ,(tonumber(SetColorBlue.TextBox.Text) or 0) / 255) 
end)

