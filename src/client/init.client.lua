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
local Computed = Fusion.Computed
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
local FPS = Value("")

local FormatedFPS = Computed(function()
	return `FPS {FPS:get()}`
end)

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
		New("TextLabel")({
			Size = UDim2.fromScale(0.13, 0.0463),
			Text = FormatedFPS,
			TextScaled = true,
		}),

	},
})

-- FPS STUFF
task.spawn(function()
	local RunService = game:GetService("RunService")
local TimeFunction = RunService:IsRunning() and time or os.clock

local LastIteration, Start
local FrameUpdateTable = {}

local function HeartbeatUpdate()
	LastIteration = TimeFunction()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
	end

	FrameUpdateTable[1] = LastIteration
	FPS:set(tostring(math.floor(TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start))))
end

Start = TimeFunction()
RunService.Heartbeat:Connect(HeartbeatUpdate)
end)

UserInputService.InputBegan:Connect(function()
	DeviceValue:set(DeviceFinder.getDevice())
end)
UserInputService.InputEnded:Connect(function()
	DeviceValue:set(DeviceFinder.getDevice())
end)
