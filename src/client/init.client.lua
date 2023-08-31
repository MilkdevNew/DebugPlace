repeat
	task.wait()
until game:IsLoaded()
-- local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.fusion)
local New, Children, OnEvent, Value=
	Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.Value
local Out = Fusion.Out
--[[
    Date: 02/11/2023
    Time: 10:59:53

    Path: src\client\init.client.lua

    Script made by Gamerboy72008
]]
local Camera = game.Workspace.CurrentCamera

local DeviceFinder = require(ReplicatedStorage.Common.DeviceFinder)

local DeviceValue = Value(DeviceFinder.getDevice())
local new = Value(`Viewport Size: {Camera.ViewportSize.X}, {Camera.ViewportSize.Y}`)
local TextBoxText = Value()
local gyro = Value("NOT ENABLED")

New("ScreenGui")({
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
			Text = DeviceValue,
			TextScaled = true,
		}),

	},
})

UserInputService.InputBegan:Connect(function()
	DeviceValue:set(DeviceFinder.getDevice())
end)
UserInputService.InputEnded:Connect(function()
	DeviceValue:set(DeviceFinder.getDevice())
end)
