--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local Config = {}

Config.WL = { --WHITELIST YOUR NAMES HERE 
	["Zocker333HD"] = true,
	["Balbalbalh"] = true,
	["Masythedev"] = true,
	["blahblah"] = true, -- Set to "true" for an active whitelist. Set to "false" for a none aactive whitelist.
}
Config.Coloring = {
	BaseColor= Color3.fromRGB(255, 255, 255),
	ButtonActivated = Color3.fromRGB(255,155,0),
	MainButtonDisabled = Color3.fromRGB(85, 255, 127),
	SecondaryButtonDisabled = Color3.fromRGB(204, 52, 235),
	ErrorColor = Color3.fromRGB(255,155,0),
	ModelLED = Color3.fromRGB(165, 0, 0),
	--ModelLED = Color3.fromRGB(163, 162, 165),
}
Config.FaderMultyplier = {
	SpeedFader = 1.5
}

return Config
