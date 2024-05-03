--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]


local footie = game.Workspace.PremuimPlatformsFootie.Footsie

for i, v in pairs(footie:GetChildren()) do
	spawn(function()
		while true do
			local bulbOrder = {}
			for j = 1, 11 do
				table.insert(bulbOrder, j)
			end
			for j = 11, 2, -1 do
				local r = math.random(1, j)
				bulbOrder[j], bulbOrder[r] = bulbOrder[r], bulbOrder[j]
			end
			for _, index in ipairs(bulbOrder) do
				local bulb = v["Bulb" .. index]
				spawn(function()
					wait(math.random())
					bulb.Transparency = 0
					bulb.Material = Enum.Material.Neon
					bulb.SurfaceLight.Brightness= .3
					wait(0.1)
					bulb.Material = Enum.Material.SmoothPlastic
					bulb.SurfaceLight.Brightness= 0
					bulb.Transparency = 1
				end)
			end
			wait(.5)
		end
	end)
end