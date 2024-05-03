--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local footie = game.Workspace.PremuimPlatformsFootie.Footsie

local function easeInOutCubic(t, b, c, d)
	t = t / (d/2)
	if (t < 1) then
		return c/2*t*t*t + b
	else
		t = t - 2
		return c/2*(t*t*t + 2) + b
	end
end

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

					-- Fade in
					for t = 1, 0, -0.05 do
						bulb.Transparency = easeInOutCubic(t, 1, -1, 1)
						bulb.SurfaceLight.Transparency = easeInOutCubic(t, 1, -1, 1)
						wait(0.01)
					end

					-- Set to fully visible
					bulb.Transparency = 0
					bulb.SurfaceLight.Transparency = 0
					bulb.Material = Enum.Material.Neon
					bulb.SurfaceLight.Brightness = 0.3

					wait(0.25)

					-- Fade out
					for t = 0, 1, 0.05 do
						bulb.Transparency = easeInOutCubic(t, 0, 1, 1)
						bulb.SurfaceLight.Transparency = easeInOutCubic(t, 0, 1, 1)
						wait(0.02)
					end

					-- Set to fully transparent
					bulb.Transparency = 1
					bulb.SurfaceLight.Transparency = 1
					bulb.Material = Enum.Material.SmoothPlastic
					bulb.SurfaceLight.Brightness = 0
				end)
			end
			wait(0.25)
		end
	end)
end
