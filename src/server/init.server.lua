local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

--[[
    Date: 06/02/2023
    Time: 22:29:45

    Path: src\server\init.server.lua

    Script made by MilkshakeSir2
]]

ReplicatedStorage.FilterText.OnServerInvoke = function(player, content)
	assert(type(content) == "string", "Content is not a string")

	local success, result = pcall(function()
		return TextService:FilterStringAsync(content, player.UserId)
	end)

	if success then
		local filterMessage = result:GetNonChatStringForBroadcastAsync()
		filterMessage = filterMessage or ""

		return filterMessage
	end
end
