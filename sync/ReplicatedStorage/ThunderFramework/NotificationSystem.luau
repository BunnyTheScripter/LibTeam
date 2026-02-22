local Notifeus = {}

--// Services
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")

--// Player
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

--// UI References
local ScreenGui             = PlayerGui:WaitForChild("Notifeus")
local NotificationFrame     = ScreenGui:WaitForChild("NotificationFrame")
local TemplateNotification  = NotificationFrame:WaitForChild("Template")

--// Tween Infos
local FadeInInfo = TweenInfo.new(
	0.4,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out
)

local PopInInfo = TweenInfo.new(
	0.45,
	Enum.EasingStyle.Back,
	Enum.EasingDirection.Out
)

local FadeOutInfo = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In
)

--// Settings
local debug = true

--// Remote
local notifyEvent = game:GetService("ReplicatedStorage")
	:WaitForChild("ThunderFramework")
	:WaitForChild("NotificationSystem")
	:WaitForChild("NotifactionRemoteEvent")

-- // Template

--[[Notifeus:Notify(
	"pneumoultramicroscopicosilicovulcaniconiotico", -- Header
	2, -- Duration
	Color3.fromRGB(30,30,30), -- Background Color
	"pneumoultramicroscopicosilicovulcaniconiotico", -- Description
	Color3.fromRGB(255, 255, 255), -- Title Color
	"rbxassetid://96302419452386", -- Icon
	Color3.fromRGB(255, 255, 255), -- text color
	nil, -- players
	true -- Show
)
--]]

--// Functions

function Notifeus:Notify(
	message: string,
	duration: number,
	BackGroundColor: Color3,
	title: string,
	titleColor: Color3,
	image: string,
	textcolor: Color3,
	players: Player?,
	IsTween: boolean
)

	if RunService:IsClient() then
		----------------------------------------------------

		local NotificationClone = TemplateNotification:Clone()

		local MessageLabel = NotificationClone.Message
		local TitleLabel   = NotificationClone.Title
		local ImageLabel   = NotificationClone.Image
		local UIStroke     = NotificationClone:FindFirstChildOfClass("UIStroke")

		----------------------------------------------------

		MessageLabel.Text = message
		MessageLabel.TextColor3 = textcolor

		TitleLabel.Text = title
		TitleLabel.TextColor3 = titleColor

		ImageLabel.Image = image

		NotificationClone.BackgroundColor3 = BackGroundColor

		----------------------------------------------------

		NotificationClone.Parent = NotificationFrame.Container
		NotificationClone.Visible = true

		----------------------------------------------------

		if IsTween then
			local originalSize = NotificationClone.Size

			NotificationClone.BackgroundTransparency = 1
			NotificationClone.Size = UDim2.new(
				originalSize.X.Scale,
				originalSize.X.Offset,
				0,
				0
			)

			MessageLabel.TextTransparency = 1
			TitleLabel.TextTransparency = 1
			ImageLabel.ImageTransparency = 1

			if UIStroke then
				UIStroke.Transparency = 1
			end

			----------------------------------------------------

			local bgInTween = TweenService:Create(
				NotificationClone,
				FadeInInfo,
				{ BackgroundTransparency = 0 }
			)

			local sizeInTween = TweenService:Create(
				NotificationClone,
				PopInInfo,
				{ Size = originalSize }
			)

			local titleInTween = TweenService:Create(
				TitleLabel,
				FadeInInfo,
				{ TextTransparency = 0 }
			)

			local messageInTween = TweenService:Create(
				MessageLabel,
				FadeInInfo,
				{ TextTransparency = 0 }
			)

			local imageInTween = TweenService:Create(
				ImageLabel,
				FadeInInfo,
				{ ImageTransparency = 0 }
			)

			bgInTween:Play()
			sizeInTween:Play()
			titleInTween:Play()
			messageInTween:Play()
			imageInTween:Play()

			if UIStroke then
				local strokeInTween = TweenService:Create(
					UIStroke,
					FadeInInfo,
					{ Transparency = 0.5 }
				)
				strokeInTween:Play()
			end
		end

		----------------------------------------------------

		if debug then
			local debugData = {
				message = message,
				duration = duration,
				color = BackGroundColor,
				title = titleColor,
				image = image,
				textcolor = textcolor,
				players = players,
				IsTween = IsTween,
			}

			print("=== Notification Debug ===")
			for key, value in pairs(debugData) do
				print(string.format("%s = %s", key, tostring(value)))
			end
			print("==========================")
		end

		----------------------------------------------------

		task.spawn(function()
			task.wait(duration)

			if IsTween then
				local originalSize = NotificationClone.Size

				local bgOutTween = TweenService:Create(
					NotificationClone,
					FadeOutInfo,
					{
						BackgroundTransparency = 1,
						Size = UDim2.new(
							originalSize.X.Scale,
							originalSize.X.Offset,
							0,
							0
						)
					}
				)

				local titleOutTween = TweenService:Create(
					TitleLabel,
					FadeOutInfo,
					{ TextTransparency = 1 }
				)

				local messageOutTween = TweenService:Create(
					MessageLabel,
					FadeOutInfo,
					{ TextTransparency = 1 }
				)

				local imageOutTween = TweenService:Create(
					ImageLabel,
					FadeOutInfo,
					{ ImageTransparency = 1 }
				)

				bgOutTween:Play()
				titleOutTween:Play()
				messageOutTween:Play()
				imageOutTween:Play()

				if UIStroke then
					local strokeOutTween = TweenService:Create(
						UIStroke,
						FadeOutInfo,
						{ Transparency = 1 }
					)
					strokeOutTween:Play()
				end

				bgOutTween.Completed:Wait()
			end

			NotificationClone:Destroy()
		end)

		----------------------------------------------------

	elseif RunService:IsServer() then
		if players then
			notifyEvent:FireClient(
				players,
				message,
				duration,
				BackGroundColor,
				title,
				titleColor,
				image,
				textcolor,
				IsTween
			)
		else
			notifyEvent:FireAllClients(
				message,
				duration,
				BackGroundColor,
				title,
				titleColor,
				image,
				textcolor,
				IsTween
			)
		end
	end
end

return Notifeus