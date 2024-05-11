local https = game:GetService("HttpService")
local url = "https://discord.com/api/webhooks/1237657210851692594/pYEvFesHfpK7J1MgwmwH3bC6a_sEODlAgHAGlkNmXo-rkWpUZQyaLYLjvuq-yVF6MJMC"

function createEmbed(url, title, message)
	local data = {
		["content"] = "",
		["embeds"] = {{
			["title"] = "**"..title.."**",
			["description"] = message,
			["type"] = "rich",
			["color"] = tonumber(0xfc0303)
		}}
	}
	local finalData = https:JSONEncode(data)
	https:PostAsync(url, finalData)
end

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	local userId = player.UserId
	local timing = DateTime.now()
	createEmbed(url,  "Product Launch | TEST LIFT", "**UserID: **".. player.UserId .. "\n **User Link:** https://www.roblox.com/users/"..player.UserId .."\n **Game: **".. game.PlaceId.."\n **Game Link: **https://www.roblox.com/games/"..game.PlaceId.."\n **Time:** "..timing:FormatLocalTime("LLL","en-us"))
end)