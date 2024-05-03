--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local rgb = script.Parent:WaitForChild("RGB")
local value = script.Parent:WaitForChild("Value")
local preview = script.Parent:WaitForChild("Preview")
local colorval = script.Parent:WaitForChild("Color")

local selectedColor = Color3.fromHSV(1, 1, 1)
local colordata = {1, 1, 1}

local mouse1down = false

local mousex = 0
local mousey = 0
script.Parent.Parent.Parent.CWMaster.MouseMoved:Connect(function(x, y)
	mousex = x
	mousey = y
end)


local function setcolor(hue, sat, val)
	colordata = {hue or colordata[1], sat or colordata[2], val or colordata[3]}
	selectedColor = Color3.fromHSV(colordata[1], colordata[2], colordata[3])
	preview.BackgroundColor3 = selectedColor
	value.ImageColor3 = Color3.fromHSV(colordata[1], colordata[2], 1)
end

local function inbounds(frame)
	local x, y = mousex - frame.AbsolutePosition.X, mousey - frame.AbsolutePosition.Y
	local maxx, maxy = frame.AbsoluteSize.X, frame.AbsoluteSize.Y
	if x >= 0 and y >= 0 and x <= maxx and y <= maxy then
		return x / maxx, y / maxy
	end
end

local function updateRGB()
	if mouse1down then
		local x, y = inbounds(rgb)
		if x and y then
			rgb:WaitForChild("Marker").Position = UDim2.new(x, 0, y, 0)
			setcolor(1 - x, 1 - y)
		end

		local x, y = inbounds(value)
		if x and y then
			value:WaitForChild("Marker").Position = UDim2.new(.5, 0, y, 0)
			setcolor(nil, nil, 1 - y)
		end
	end
end

script.Parent.Parent.Parent.CWMaster.MouseMoved:Connect(updateRGB)


rgb.MouseButton1Down:Connect(function()
	mouse1down = true
end)
value.MouseButton1Down:Connect(function()
	mouse1down = true
end)

rgb.MouseButton1Up:Connect(function()
	mouse1down = false
end)
value.MouseButton1Up:Connect(function()
	mouse1down = false
end)

rgb.MouseLeave:Connect(function()
	mouse1down = false
end)
value.MouseLeave:Connect(function()
	mouse1down = false
end)

preview:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
	colorval.Value = preview.BackgroundColor3
end)

colorval.Changed:Connect(function()
	for i,v in pairs(game.Workspace.PremuimPlatformsFootie.Footsie:GetChildren()) do
		v["Fake Lense"].Color = colorval.Value
		v.Bulb1.Color = colorval.Value
		v.Bulb2.Color = colorval.Value
		v.Bulb3.Color = colorval.Value
		v.Bulb4.Color = colorval.Value
		v.Bulb5.Color = colorval.Value
		v.Bulb6.Color = colorval.Value
		v.Bulb7.Color = colorval.Value
		v.Bulb8.Color = colorval.Value
		v.Bulb9.Color = colorval.Value
		v.Bulb10.Color = colorval.Value
		v.Bulb11.Color = colorval.Value
		v["Fake Lense"].SurfaceLight.Color = colorval.Value
		v.Bulb1.SurfaceLight.Color = colorval.Value
		v.Bulb2.SurfaceLight.Color = colorval.Value
		v.Bulb3.SurfaceLight.Color = colorval.Value
		v.Bulb4.SurfaceLight.Color = colorval.Value
		v.Bulb5.SurfaceLight.Color = colorval.Value
		v.Bulb6.SurfaceLight.Color = colorval.Value
		v.Bulb7.SurfaceLight.Color = colorval.Value
		v.Bulb8.SurfaceLight.Color = colorval.Value
		v.Bulb9.SurfaceLight.Color = colorval.Value
		v.Bulb10.SurfaceLight.Color = colorval.Value
		v.Bulb11.SurfaceLight.Color = colorval.Value
	end
end)
