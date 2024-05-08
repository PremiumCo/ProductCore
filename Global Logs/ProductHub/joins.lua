local HttpService = game:GetService("HttpService")

-- Replace "YOUR_WEBHOOK_URL_HERE" with your actual Discord webhook URL
local webhookUrl = "https://discord.com/api/webhooks/1237655648234111016/qWxRe-6l4I4qJ7kanQznyYyiHoK21RW84T7GYV_lrSBNSvBxVF8vBeWs40oxOHR9Bmq0"

-- Function to send player's join information to the Discord webhook
local function sendJoinInfoToWebhook(player)
	local timestamp = os.date("%Y-%m-%d %H:%M:%S")

	-- Create a message embed with player's join information
	local embed = {
		title = "Player Joined | Product Hub",
		color = tonumber("0x00FF00"), -- Green color
		fields = {
			{ name = "Username", value = "[" .. player.Name .. "](https://www.roblox.com/users/" .. player.UserId .. "/profile)", inline = true },
			{ name = "User ID", value = player.UserId, inline = true },
			{ name = "Join Time", value = timestamp, inline = true }
		}
	}

	-- Create a table with the embed content
	local data = {
		embeds = { embed }
	}

	-- Convert the table to JSON format
	local jsonData = HttpService:JSONEncode(data)

	-- Make a POST request to the webhook URL
	local success, errorMessage = pcall(function()
		HttpService:PostAsync(webhookUrl, jsonData, Enum.HttpContentType.ApplicationJson)
	end)

	if not success then
		warn("Failed to send join info to Discord webhook: " .. errorMessage)
	end
end

game.Players.PlayerAdded:Connect(function(player)
	-- Send player's join information to the Discord webhook
	sendJoinInfoToWebhook(player)
end)
