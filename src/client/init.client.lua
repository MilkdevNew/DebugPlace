repeat
	task.wait()
until game:IsLoaded()
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local New, Children, OnEvent, Value, Spring, Computed, Tween =
	Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value, Fusion.Spring, Fusion.Computed, Fusion.Tween

--[[
    Date: 02/11/2023
    Time: 10:59:53

    Path: src\client\init.client.lua

    Script made by Gamerboy72008
]]
local Camera = game.Workspace.CurrentCamera

local DeviceFinder = require(ReplicatedStorage.Common.DeviceFinder)
function GetScreenSize(fullscreen: boolean?): Vector2
	if game:GetService("RunService"):IsStudio() then
		warn("Call of GetScreenSize() inside studio returns the viewport dimensions, not the actual screen dimensions!")
	end
	if fullscreen then
		local GameSettings = UserSettings().GameSettings
		if not GameSettings:InFullScreen() then
			GameSettings.FullscreenChanged:Wait()
		end
	end
	local UI = Instance.new("ScreenGui")
	UI.ScreenInsets = Enum.ScreenInsets.None
	UI.Parent = game.Players.LocalPlayer.PlayerGui
	local size = UI.AbsoluteSize
	UI:Destroy()
	return size * 3
end

local DeviceValue = Value(DeviceFinder.getDevice())
local new = Value(`Viewport Size: {Camera.ViewportSize.X}, {Camera.ViewportSize.Y}`)
local ScreenSize = GetScreenSize()
local anotherValue = Value(`Viewport Size 2: {ScreenSize.X}, {ScreenSize.Y}`)
local gyro = Value("NOT ENABLED")

Gui = New("ScreenGui")({
	Parent = player.PlayerGui,
	IgnoreGuiInset = false,
	[Children] = {
		New("UIListLayout")({
			Name = "UIListLayout",
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		New("UIPadding")({
			Name = "UIPadding",
			PaddingBottom = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 10),
		}),
		New("TextLabel")({
			Size = UDim2.fromScale(0.13, 0.0463),
			Text = new,
			TextScaled = true,
		}),
		New("TextLabel")({
			Size = UDim2.fromScale(0.13, 0.0463),
			Text = anotherValue,
			TextScaled = true,
		}),
		New("TextLabel")({
			Size = UDim2.fromScale(0.13, 0.0463),
			Text = DeviceValue,
			TextScaled = true,
		}),
		New("TextLabel")({
			Size = UDim2.fromScale(0.13, 0.0463),
			Text = gyro,
			TextScaled = true,
		}),
	},
})

local gyroEnabled = UserInputService.GyroscopeEnabled

task.spawn(function()
	while true do
		ScreenSize = GetScreenSize()
		anotherValue:set(`Viewport Size 2: {ScreenSize.X}, {ScreenSize.Y}`)
		new:set(`Viewport Size: {Camera.ViewportSize.X}, {Camera.ViewportSize.Y}`)
		if gyroEnabled then
			local _inputObj, cframe = UserInputService:GetDeviceRotation()
			gyro:set(cframe)
		else
			gyro:set("NOT ENABLED-g")
		end
		task.wait()
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	DeviceValue:set(DeviceFinder.getDevice())
end)
UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
	DeviceValue:set(DeviceFinder.getDevice())
end)
