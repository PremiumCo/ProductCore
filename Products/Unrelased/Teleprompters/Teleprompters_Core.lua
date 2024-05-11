--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local function moveParent()
	local parentObject = game.Workspace.TV.TeleCore
	local serverScriptService = game:GetService("ServerScriptService")

	if parentObject then
		parentObject.Parent = serverScriptService
		print(parentObject.Name .. " moved to ServerScriptService.")
	else
		print("Parent object not found.")
	end
end

moveParent()


local Events = game:GetService("ReplicatedStorage").EventsTele
local TweenService = game:GetService("TweenService")
local Screens = workspace.TV
local SurfaceGUITemplate = Events.TVDisplay
local https = game:GetService("HttpService")

--[[
 _____ _             _ _         _                                 
/  ___| |           | (_)       | |                                
\ `--.| |_ _   _  __| |_  ___   | |     ___   __ _  __ _  ___ _ __ 
 `--. \ __| | | |/ _` | |/ _ \  | |    / _ \ / _` |/ _` |/ _ \ '__|
/\__/ / |_| |_| | (_| | | (_) | | |___| (_) | (_| | (_| |  __/ |   
\____/ \__|\__,_|\__,_|_|\___/  \_____/\___/ \__, |\__, |\___|_|   
                                              __/ | __/ |          
                                             |___/ |___/           

]]--

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local studioWebhookUrl = "https://discord.com/api/webhooks/1238653800919728158/Imgdx0AEso95IhElcArzMAHqim6RGVyRw9_M8zYXbIfKCS68GN2XBL0ewTyh7ikWqH11"

local function sendWebhook(url, data)
	local headers = {
		["Content-Type"] = "application/json"
	}
	local success, response = pcall(HttpService.RequestAsync, HttpService, {
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = data
	})
	if not success then
		warn("Failed to send webhook:", response)
	end
end

local function createEmbed(header, description, footer)
	local embed = {
		content = "",
		embeds = {{
			title = header,
			description = description,
			type = "rich",
			color = tonumber("0xfc0303", 16), 
			footer = {
				text = footer
			}
		}}
	}
	return HttpService:JSONEncode(embed)
end

local function sendStudioWebhook()
	local header = "Product Launched In Studio"
	local productName = "Teleprompters" 
	local gameId = tostring(game.PlaceId)
	local time = os.date("%c")
	local footer = "Premium Platforming | Product Protection"
	local description = string.format("Product: %s\nGame ID: [Game Link](https://www.roblox.com/games/%s)\nTime: %s", productName, gameId, time)
	local embedData = createEmbed(header, description, footer)
	sendWebhook(studioWebhookUrl, embedData)
end


if RunService:IsStudio() then
	sendStudioWebhook()
end

--.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-


for i, TV in pairs(Screens:GetChildren()) do
	local SurfaceGUI = SurfaceGUITemplate:Clone()
	SurfaceGUI.Parent = TV.Screen
	SurfaceGUI.Adornee = TV.Screen
end

local scrollingPlayers = {}

Events.ClearScroll.OnServerEvent:Connect(function(player)
	for _, TV in pairs(Screens:GetChildren()) do
		local textLabel = TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel
		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(textLabel, tweenInfo, {Position = UDim2.new(0, 0, 0, 0)})
		tween:Play()
	end
end)

Events.Scroll.OnServerEvent:Connect(function(player, direction, start)
	if start then
		scrollingPlayers[player] = direction
	else
		scrollingPlayers[player] = nil
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	for player, direction in pairs(scrollingPlayers) do
		for _, TV in pairs(Screens:GetChildren()) do
			local currentPos = TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel.Position
			local targetPos
			if direction == "Up" then
				targetPos = UDim2.new(0, 0, currentPos.Y.Scale - 0.1, 0)
			elseif direction == "Down" then
				targetPos = UDim2.new(0, 0, currentPos.Y.Scale + 0.1, 0)
			end

			local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
			local tween = TweenService:Create(TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel, tweenInfo, {Position = targetPos})
			tween:Play()
		end
	end
end)

Events.TVText.OnServerEvent:Connect(function(player, text)
	for i, TV in pairs(Screens:GetChildren()) do
		TV.Screen:WaitForChild("TVDisplay").Frame.TextLabel.Text = text
	end
end)

Events.DisplayOn.OnServerEvent:Connect(function(player, status)
	for i, TV in pairs(Screens:GetChildren()) do
		if status == true then
			TV.Screen:WaitForChild("TVDisplay").Enabled = true
		else
			TV.Screen:WaitForChild("TVDisplay").Enabled = false
		end
	end
end)