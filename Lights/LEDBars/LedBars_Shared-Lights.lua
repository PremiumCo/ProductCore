--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

-- Unobfuscated on purpose, unfortunately Luraph obfuscation does not play well with this file.
-- Premium Platforming | All Rights Reserved 2024
-- Written by @draaawn

local Light = {}
Light.__index = Light

local allowedParameters = {
	Intensity = {'setIntensity', true},
	['Intensity All'] = {'setIntensityAll', true},
	Tilt = {'setTiltMotor', true},
	Color = {'setColor', true},
	['Color All'] = {'setColorAll', true},
}

local fixtureLimits = {
	Intensity = {
		min = 0,
		max = 1,
	},
	['Intensity All'] = {
		min = 0,
		max = 1,
	},
	Tilt = {
		min = math.rad(-135),
		max = math.rad(135),
	},
	Color = 'ignore',
	['Color All'] = 'ignore',
}

function Light.new(arguments)
	if not arguments then
		return
	end

	local self = {
		personality = arguments.personality,
		instances = arguments.instances,
		extras = {
			lastSavedColor = Color3.new(1, 1, 1),
			brightnessMultiplier = arguments.instances.model:GetAttribute('BrightnessMultiplier'),
			phase = arguments.extras.phase,
			continuousPhase = arguments.extras.continuousPhase,
			fixturePhase = arguments.extras.fixturePhase
		},
	}
	return setmetatable(self, Light)
end

local function calcAvgBrightness(instances)
	local cellCount = #instances
	local totalNormalizedTransparency = 0

	for _, item in ipairs(instances) do
		totalNormalizedTransparency = totalNormalizedTransparency + (1 - item.Transparency)
	end

	if cellCount > 0 then
		local averageNormalizedTransparency = totalNormalizedTransparency / cellCount
		local maxBrightness = 5
		local scaledBrightness = averageNormalizedTransparency * maxBrightness

		local gamma = 0.5
		local correctedBrightness = scaledBrightness ^ gamma

		return math.min(maxBrightness, math.max(0, correctedBrightness))
	else
		return 0
	end
end

local function calcAvgColor(instances)
	local r, g, b = 0, 0, 0

	for _, item in instances do
		r = r + item.Color.R
		g = g + item.Color.G
		b = b + item.Color.B
	end

	return Color3.new(r / #instances, g / #instances, b / #instances)
end

function Light.setIntensity(self, value, cellIndex)
	local cells = self.instances.cells
	local cellInstance = cells[cellIndex]

	if not cellInstance then return end

	local brightnessMultiplier = self.extras.brightnessMultiplier
	cellInstance.Transparency = value

	local brightness = ((tonumber(calcAvgBrightness(cells))) or 1) * brightnessMultiplier
	local spotlight = self.instances.spot

	spotlight.Brightness = brightness
	spotlight.Range = math.clamp((1 - value) * 60, 35, 60)
	spotlight.Angle = math.clamp((1 - value) * 50, 35, 135)

	local attachments = self.instances.possibleAttachments
	for _, attachment in attachments do
		if not attachment:IsA('Attachment') then continue end
		if attachment.Name ~= 'External' then continue end

		attachment:FindFirstChildWhichIsA("Light").Brightness = brightness
	end

	if not self.personality.useBeam then return end

	cellInstance.light.Transparency = NumberSequence.new(value, 1)
end

function Light.setIntensityAll(self, value)
	local cells = self.instances.cells

	local brightnessMultiplier = self.extras.brightnessMultiplier

	local brightness = (1 - value) * brightnessMultiplier
	local spotlight = self.instances.spot

	spotlight.Brightness = brightness
	spotlight.Range = math.clamp((1 - value) * 60, 35, 60)
	spotlight.Angle = math.clamp((1 - value) * 50, 35, 135)

	for cellIndex = 1, #self.instances.cells do
		local cellInstance = cells[cellIndex]

		if not cellInstance then continue end
		cellInstance.Transparency = value

		if not self.personality.useBeam then continue end
		cellInstance.light.Transparency = NumberSequence.new(value, 1)
	end

	local attachments = self.instances.possibleAttachments
	for _, attachment in attachments do
		if not attachment:IsA('Attachment') then continue end
		if attachment.Name ~= 'External' then continue end

		attachment:FindFirstChildWhichIsA("Light").Brightness = brightness
	end
end

function Light.setTiltMotor(self, value)
	local motor = self.instances.motors.tilt
	motor.DesiredAngle = value
end

function Light.setColor(self, color, cellIndex)
	local cells = self.instances.cells
	local cellInstance = cells[cellIndex]

	if not cellInstance then return end

	-- Order is important!
	cellInstance.Color = color
	
	local _color =  calcAvgColor(cells)
	local spotlight = self.instances.spot

	spotlight.Color = _color

	local attachments = self.instances.possibleAttachments
	for _, attachment in attachments do
		if not attachment:IsA('Attachment') then continue end
		if attachment.Name ~= 'External' then continue end

		attachment:FindFirstChildWhichIsA("Light").Color = _color
	end

	if not self.personality.useBeam then return end
	cellInstance.light.Color = ColorSequence.new(color)
end

function Light.setColorAll(self, color)
	local cells = self.instances.cells
	local spotlight = self.instances.spot

	for cellIndex = 1, #self.instances.cells do
		local cellInstance = cells[cellIndex]

		if not cellInstance then continue end
		
		cellInstance.Color = color
		spotlight.Color = color

		if not self.personality.useBeam then continue end
		cellInstance.light.Color = ColorSequence.new(color)
	end

	local attachments = self.instances.possibleAttachments
	for _, attachment in attachments do
		if not attachment:IsA('Attachment') then continue end
		if attachment.Name ~= 'External' then continue end

		attachment:FindFirstChildWhichIsA("Light").Color = color
	end
end

function Light:isEven()
	return self.personality.fixtureId % 2 == 0
end

function Light:isLeft()
	return self.personality.groupId == 1
end

function Light:setValue(parameter, value, cell)
	local parameterData = allowedParameters[parameter]

	if not parameterData then return end
	local functionName, enabled = unpack(parameterData)

	if not enabled then return end
	local limitData = fixtureLimits[parameter]

	if limitData ~= 'ignore' then
		value = math.clamp(
			value, limitData.min, limitData.max
		)
	end

	local success, message = pcall(function()
		return Light[functionName](self, value, cell)
	end)
end

return Light