--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]

local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")
local PropsFolder = ServerStorage:WaitForChild("Props")
local ControlPanel = script.Parent
local SurfaceGui = ControlPanel:WaitForChild("SurfaceGui")
local MainFrame = SurfaceGui:WaitForChild("MainFrame")
local TemplateButton = MainFrame:WaitForChild("TEMPLATE")

for _, prop in pairs(PropsFolder:GetChildren()) do
	local PropButton = TemplateButton:Clone()
	PropButton.Name = prop.Name
	PropButton.Text = prop.Name
	PropButton.Visible = true
	PropButton.Parent = MainFrame

	local ButtonOn = false
	PropButton.MouseButton1Click:Connect(function()
		-- I just did this to look cool not using an if statement ;=) 
		ButtonOn = not ButtonOn
		PropButton.BackgroundColor3 = ButtonOn and Color3.new(0, 255, 0) or TemplateButton.BackgroundColor3
		prop.Parent = ButtonOn and Workspace or ServerStorage
	end)
end

-- this is such a scam like how do people not use chatgpt to make sum like this?!?! yet they spent like a dollar on this system... what a scam 