--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local Players = game:GetService("Players")
local PRBTS = game:GetService("Workspace").PremiumRobots
local Config = require(PRBTS.Config)

while true do
	if Config.WL[Players.LocalPlayer.Name] then
		PRBTS.Panel.SurfaceGui.Main.Visible = true
		PRBTS.Panel.SurfaceGui.WLerror.Visible = false
		wait(1)
		script:Destroy()
	else
		PRBTS.Panel.SurfaceGui.WLerror.Visible = true
		PRBTS.Panel.SurfaceGui.Main.Visible = false
		wait(1)
		script:Destroy()
	end
	wait(1)
end

