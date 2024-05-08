local HttpService = game:GetService("HttpService")
local BannedPlayers = {
	1355914607,
	73868662,
}

-- Replace "YOUR_WEBHOOK_URL_HERE" with your actual Discord webhook URL
local webhookUrl = "https://discord.com/api/webhooks/1237655417010786377/118OvlnijR9lc4lRhySLPmSWTuMPCtc8SeDRuJquAo2YV_IZpwvNMd-tQjrt4P1VdI6x"

game.Players.PlayerAdded:Connect(function(player)
	if table.find(BannedPlayers, player.UserId) then
		player:Kick("You are blacklisted from Premium Platforming! (Your join has been logged)")

		-- Get the current timestamp
		local timestamp = os.date("%Y-%m-%d %H:%M:%S")

		-- Create an embed message to send to the webhook
		local embed = {
			title = "Banned Player Joined | PRODUCT HUB",
			description = "A banned player attempted to join the game.",
			color = tonumber("0xFF0000"), -- Red color
			fields = {
				{ name = "Username", value = "[" .. player.Name .. "](https://www.roblox.com/users/" .. player.UserId .. "/profile)", inline = true },
				{ name = "User ID", value = player.UserId, inline = true },
				{ name = "Timestamp", value = timestamp, inline = true }
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
			warn("Failed to send message to Discord webhook: " .. errorMessage)
		end
	end
end)
