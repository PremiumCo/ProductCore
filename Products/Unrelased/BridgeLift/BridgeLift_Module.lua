--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

--[[

# CUSTOM GOALS LAYOUT #

["GOAL NAME HERE"] = {
	HeightType = "PERCENT" or "STUDS",
	HeightValue = PUT HEIGHT NUMBER HERE, eg. 5
}

# EXAMPLE PERCENTAGE GOAL #

["Example Percentage Goal"] = {
	HeightType = "PERCENT",
	HeightValue = 50
}

# EXAMPLE STUDS GOAL #

["Example Percentage Goal"] = {
	HeightType = "STUDS",
	HeightValue = 5
}

IMPORTANT NOTE: If you get an error saying "Custom goal exceeds bridge max height" go into the 
bridge model and lift up the model called "Tops".

]]--
return {
	Goals = {
		["Example Goal"] = {
			HeightType = "PERCENT",
			HeightValue = 50
			
		}
	}
}
