--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local module = {}
local httpService = game:GetService('HttpService')
local successful, result = pcall(httpService.GetAsync, httpService, 'https://google.com')
if successful then
elseif result:lower():find('http requests are not enabled') then
	warn('[Premium Robots] HTTP requests are not enabled! go to Home->GameSettings->Security->Allow HTTP Requests > ON')
else
	warn('Invalid HTTP request:',result)
end
local RunService = game:GetService ("RunService")
function module.Setup()
	if RunService:IsStudio()== false then
		game.Workspace.PremiumRobots.Panel.Temp.Main.Error.TextColor3 = Color3.fromRGB(255, 0, 0)
		game.Workspace.PremiumRobots.Panel.Temp.Main.Error.Text = " Failed to Load Reason; Instance is Studio"
	else
		if successful then
			script.Components.ControllerUI.SurfaceGui.Parent = game.Workspace.PremiumRobots.Panel
			game.Workspace.PremiumRobots.Panel.Temp:Destroy()
		elseif result:lower():find('http requests are not enabled') then
			game.Workspace.PremiumRobots.Panel.Temp.Main.Error.TextColor3 = Color3.fromRGB(255, 0, 0)
			game.Workspace.PremiumRobots.Panel.Temp.Main.Error.Text = " Failed to Load Reason; HTTP Requests are not Turned On"
		else
			game.Workspace.PremiumRobots.Panel.Temp.Main.Error.TextColor3 = Color3.fromRGB(255, 0, 0)
			warn('Invalid HTTP request:',result)
			game.Workspace.PremiumRobots.Panel.Temp.Main.Error.Text = " Failed to Load Reason; HTTP returned Invalid"
		end
	end
	
end

return module