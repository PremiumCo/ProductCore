--[[   

COPYRIGHT & PRIVACY NOTICE:

COPYRIGHT © [2024] Premium Platforming. All Rights Reserved.

This code is confidential and proprietary to Premium Platforming. Unauthorized access, distribution, or use of any kind is strictly prohibited.

--]]
--[[

  _____                    _                   _____  _       _    __                     _             
 |  __ \                  (_)                 |  __ \| |     | |  / _|                   (_)            
 | |__) | __ ___ _ __ ___  _ _   _ _ __ ___   | |__) | | __ _| |_| |_ ___  _ __ _ __ ___  _ _ __   __ _ 
 |  ___/ '__/ _ \ '_ ` _ \| | | | | '_ ` _ \  |  ___/| |/ _` | __|  _/ _ \| '__| '_ ` _ \| | '_ \ / _` |
 | |   | | |  __/ | | | | | | |_| | | | | | | | |    | | (_| | |_| || (_) | |  | | | | | | | | | | (_| |
 |_|   |_|  \___|_| |_| |_|_|\__,_|_| |_| |_| |_|    |_|\__,_|\__|_| \___/|_|  |_| |_| |_|_|_| |_|\__, |
                                                                                                   __/ |
                                                                                                  |___/ 
 +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+
 |P|r|e|m|i|u|m| |P|r|o|d|u|c|t|s| |t|h|r|o|u|g|h| |P|r|e|m|i|u|m| |W|a|y|s|.|
 +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+

-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-                                 
Thank you for buying our product! Your purchase helps create our success. Without you, the customer, Premium would not be the same.

Please read below before opening a ticket <3

!!_OUR PRODUCTS DO NOT WORK IN STUDIO_!!
- (make sure your game is published)

!!_ALLOW HTTP REQUESTS FOR YOUR PRODUCT TO WORK_!!
- (this can be found in game settings!)

!!_YOU MUST OWN THE PRODUCT AND OWN THE GAME_!!
-(for group games you must be the group owner, open a ticket to transfer !only one way!)

!!_DO NOT UNGROUP THE PRODUCT_!!
-(to move the panels hold ALT and select the panel and use the move tool to move the panels)
-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-
   _____          _                    _______                   _       _           
  / ____|        | |                  |__   __|                 | |     | |          
 | |    _   _ ___| |_ ___  _ __ ___      | | ___ _ __ ___  _ __ | | __ _| |_ ___ ___ 
 | |   | | | / __| __/ _ \| '_ ` _ \     | |/ _ | '_ ` _ \| '_ \| |/ _` | __/ _ / __|
 | |___| |_| \__ | || (_) | | | | | |    | |  __| | | | | | |_) | | (_| | ||  __\__ \
  \_____\__,_|___/\__\___/|_| |_| |_|    |_|\___|_| |_| |_| .__/|_|\__,_|\__\___|___/
                                                          | |                        
                                                          |_|                        
-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-

Making a custom template is a little more dificult for new users. For more hands on support please open a customer service ticket. 

When making a custom template, find the "CustomTemplates" moudle script.

Double click it to open it.

You will see a pre-made template

Below will show you each function and how to edit it.

Looks like this:
-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-

local CustomButtons = { -- DO NOT TOUCH
	[1] = { -- Change "1" to the button number, KEEP IT IN ORDEDR AND DO NOT CHANGE THE ORDER OR SKIP A NUMBER
		Name = "Example", -- Name that will show up on the custom button screen
		Speed = 10, -- This is the amount of time it will take to move (In seconds)
		PercentageOpen = 100, -- How Open/High the product moves. Use 0%, 25%, 50%, 75%, & 100% increments
		TweenStyle = Enum.EasingStyle.Linear, -- The effect on how it opens (Listed Below In EFFECTS)
	}, -- Add this to the end of each button.
}

return CustomButtons -- DO NOT TOUCH
-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-
  ______  __  __          _       
 |  ____|/ _|/ _|        | |      
 | |__  | |_| |_ ___  ___| |_ ___ 
 |  __| |  _|  _/ _ \/ __| __/ __|
 | |____| | | ||  __| (__| |_\__ \
 |______|_| |_| \___|\___|\__|___/
                                  
    Here are the listed effects:                       

Linear
Sine
Quad
Cubic
Quart
Quint
Back
Elastic
Bounce
Exponential
Circular

-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-.-.-.-.-..-.-.-.-


Last Updated By Mason on 2/11/24


]]