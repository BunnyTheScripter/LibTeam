local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ThunderFramework = ReplicatedStorage:WaitForChild("ThunderFramework")
local NotificationSystem = ThunderFramework:WaitForChild("NotificationSystem")

local Notifeus = require(NotificationSystem)

Notifeus:Notify(
	"Sucess", -- Header
	5, -- Duration
	Color3.fromRGB(30,30,30), -- Background Color
	"Base x64 found", -- Description
	Color3.fromRGB(0, 68, 255), -- Title Color
	"rbxassetid://12698727101", -- Icon
	Color3.fromRGB(255, 255, 255), -- text color
	nil, -- players

	true -- Show
)

task.wait(0.1)

Notifeus:Notify(
	"Error!", -- Header
	5, -- Duration
	Color3.fromRGB(30,30,30), -- Background Color
	"Base x64 didnt found", -- Description
	Color3.fromRGB(255, 123, 0), -- Title Color
	"rbxassetid://12698723961", -- Icon
	Color3.fromRGB(255, 255, 255), -- text color
	nil, -- players

	true -- Show
)



--[[ local loop = true

task.delay(10, function()
	loop = false
	print("teste")
end)

while loop do
	task.wait(0.1)
	Notifeus:Notify(
		"Looped!", -- Header
		5, -- Duration
		Color3.fromRGB(30,30,30), -- Background Color
		"its a loop sooooo...", -- Description
		Color3.fromRGB(255, 123, 0), -- Title Color
		"rbxassetid://12698723961", -- Icon
		Color3.fromRGB(255, 255, 255), -- text color
		nil, -- players
		true -- Show
	)
end--]]