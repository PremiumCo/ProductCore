--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

--------------------------------------------------------------------------------------------------------------------------------
--[[                                              Copyright © Inertia Lighting                                              ]]--
--------------------------------------------------------------------------------------------------------------------------------

local LuaAdditions = {}

---------------------------------------------------------------

LuaAdditions.version = 'v0.0.3-beta'

---------------------------------------------------------------

local srcFolder = script.Parent:WaitForChild('src')

LuaAdditions.Table = require(srcFolder.Table)

-- LuaAdditions.string is omitted.

LuaAdditions.Utility = require(srcFolder.Utility)

---------------------------------------------------------------

return LuaAdditions
