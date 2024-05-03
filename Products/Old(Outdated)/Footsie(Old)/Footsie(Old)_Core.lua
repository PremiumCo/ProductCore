--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local panel = game.Workspace.PremuimPlatformsFootie.footiepanel
local footsie = game.Workspace.PremuimPlatformsFootie.Footsie
local buttons = panel.SurfaceGui.buttons
local TweenService = game:GetService("TweenService")
local effects = game.Workspace.PremuimPlatformsFootie.EffectScripts


buttons["pan"].MouseButton1Click:Connect(function()
	for i, v in pairs(footsie:GetChildren()) do
		spawn(function()
			for i = 9, 0, -1 do
				TweenService:Create(buttons["pan"].red, TweenInfo.new(0.1), {ImageTransparency = i/10}):Play()
				wait(5)
				TweenService:Create(buttons["pan"].red, TweenInfo.new(0.1), {ImageTransparency = i/0}):Play()
				for j = 1, 11 do
				local bulb = v["Bulb" .. j]
				effects.rand.Enabled = false
				effects.fandrand.Enabled = false
				bulb.SurfaceLight.Brightness = 0
				bulb.Material = Enum.Material.SmoothPlastic
				wait(10)
				buttons.pan.red.ImageTransparency = 1
				end
			end
		end)
	end
end)


buttons["O/X"].MouseButton1Click:Connect(function()
	for i, v in pairs(footsie:GetChildren()) do
		spawn(function()
			
			for i = 9, 0, -1 do
				TweenService:Create(buttons["O/X"].green, TweenInfo.new(0.1), {ImageTransparency = i/10}):Play()
				wait(0.1)
				for j = 1, 11 do
					v.ledl.Transparency = 1
					local bulb = v["Fake Lense"]
					bulb.Material = Enum.Material.Neon
					
				game:GetService("TweenService"):Create(bulb.SurfaceLight, TweenInfo.new(0, Enum.EasingStyle.Linear), {Brightness = 0.7}):Play()
				bulb.Material = Enum.Material.Neon
				
		    end
		 end
	  end)
   end
end)


buttons["O/X"].MouseButton2Click:Connect(function()
	for i, v in pairs(footsie:GetChildren()) do
		spawn(function()
			for j = 1, 11 do
				local bulb = v["Fake Lense"]
				v.ledl.Transparency = 0
				bulb.SurfaceLight.Brightness = 0
				bulb.Material = Enum.Material.SmoothPlastic
			end
		end)
	end

	for i = 0, 10 do
		TweenService:Create(buttons["O/X"].green, TweenInfo.new(0.5), {ImageTransparency = i/10}):Play()
		wait(0.1)
	end

	for i = 9, 0, -1 do
		TweenService:Create(buttons["O/X"].red, TweenInfo.new(0.1), {ImageTransparency = i/10}):Play()
		wait(0.1)
	end

	for i = 0, 10 do
		TweenService:Create(buttons["O/X"].red, TweenInfo.new(0.5), {ImageTransparency = i/10}):Play()
		wait(0.1)
	end
end)

buttons["FadeO/X"].MouseButton1Click:Connect(function()
	for i, v in pairs(footsie:GetChildren()) do
		spawn(function()
			for i = 9, 0, -1 do
				v.ledl.Transparency = 1
				TweenService:Create(buttons["FadeO/X"].green, TweenInfo.new(0.1), {ImageTransparency = i/10}):Play()
				wait(0.1)
				for j = 1, 11 do
					local bulb = v["Fake Lense"]
					game:GetService("TweenService"):Create(bulb.SurfaceLight, TweenInfo.new(1, Enum.EasingStyle.Linear), {Brightness = 0.7}):Play()
					bulb.Material = Enum.Material.Neon

				end
			end
		end)
	end
end)

buttons["FadeO/X"].MouseButton2Click:Connect(function()
	for i, v in pairs(footsie:GetChildren()) do
		spawn(function()
			for j = 1, 11 do
				local bulb = v["Fake Lense"]
				v.ledl.Transparency = 0
				game:GetService("TweenService"):Create(bulb.SurfaceLight, TweenInfo.new(1, Enum.EasingStyle.Linear), {Brightness = 0}):Play()
				bulb.Material = Enum.Material.SmoothPlastic
			end
		end)
	end

	for i = 0, 10 do
		TweenService:Create(buttons["FadeO/X"].green, TweenInfo.new(0.5), {ImageTransparency = i/10}):Play()
		wait(0.1)
	end

	for i = 9, 0, -1 do
		TweenService:Create(buttons["FadeO/X"].red, TweenInfo.new(0.1), {ImageTransparency = i/10}):Play()
		wait(0.1)
	end

	for i = 0, 10 do
		TweenService:Create(buttons["FadeO/X"].red, TweenInfo.new(0.5), {ImageTransparency = i/10}):Play()
		wait(0.1)
	end
end)

buttons["Rand"].MouseButton1Click:Connect(function()
	for i, v in pairs(footsie:GetChildren()) do
		spawn(function()
			for i = 9, 0, -1 do
				v.ledl.Transparency = 1
				v["Fake Lense"].Transparency = 1
				TweenService:Create(buttons["Rand"].green, TweenInfo.new(0.1), {ImageTransparency = i/10}):Play()
				wait(0.1)
				for j = 1, 11 do
					local bulb = v["Bulb" .. j]
					effects.rand.Enabled = true	
					bulb.SurfaceLight.Brightness = 0
					bulb.Material = Enum.Material.Neon
					

				end
			end
		end)
	end
end)

buttons["Rand"].MouseButton2Click:Connect(function()
	for i, v in pairs(footsie:GetChildren()) do
		spawn(function()
			for j = 1, 11 do
				local bulb = v["Bulb" .. j]
				v["Fake Lense"].Transparency = 0
				v.ledl.Transparency = 0
				bulb.Material = Enum.Material.SmoothPlastic
				effects.rand.Enabled = false
				bulb.SurfaceLight.Brightness = 0
				
			end
			for i = 0, 10 do
				TweenService:Create(buttons["Rand"].green, TweenInfo.new(0.5), {ImageTransparency = i/10}):Play()
				wait(0.1)
			end

			for i = 9, 0, -1 do
				TweenService:Create(buttons["Rand"].red, TweenInfo.new(0.1), {ImageTransparency = i/10}):Play()
				wait(0.1)
			end

			for i = 0, 10 do
				TweenService:Create(buttons["Rand"].red, TweenInfo.new(0.5), {ImageTransparency = i/10}):Play()
				wait(0.1)
				
			end
		end)
	end
end)



		


buttons["day"].MouseButton1Click:Connect(function()
	game.Lighting.OutdoorAmbient = Color3.new(40/255,40/255,40/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(60/255,60/255,60/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(80/255,80/255,80/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(90/255,90/255,90/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(100/255,100/255,100/255)
	wait(0.1)
	game.Lighting.Brightness = 2
	wait(0.1)
	game.Lighting.TimeOfDay = 12
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(40/255,40/255,40/255)
	wait(0.1)
	game.Lighting.Ambient = Color3.new(60/255,60/255,60/255)
	wait(0.1)
	game.Lighting.Ambient = Color3.new(80/255,80/255,80/255)
	wait(0.1)
	game.Lighting.Ambient = Color3.new(90/255,90/255,90/255)
	wait(0.1)
	game.Lighting.Ambient = Color3.new(100/255,100/255,100/255)
	wait(0.1)

end)

buttons["night"].MouseButton1Click:Connect(function()
	game.Lighting.OutdoorAmbient = Color3.new(120/255,120/255,120/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(115/255,115/255,115/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(110/255,110/255,110/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(105/255,105/255,105/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(100/255,100/255,100/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(95/255,95/255,95/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(85/255,85/255,85/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(75/255,75/255,75/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(65/255,65/255,65/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(55/255,55/255,55/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(45/255,45/255,45/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(35/255,35/255,35/255)
	wait(0.1)
	game.Lighting.OutdoorAmbient = Color3.new(20/255,20/255,20/255)
	wait(0.1)
	game.Lighting.Brightness = 0.1
	wait(0.1)
	game.Lighting.TimeOfDay = 0
	game.Lighting.OutdoorAmbient = Color3.new(0,0,0)
	wait(0.1)
	game.Lighting.Ambient = Color3.new(0,0,0)
end)
