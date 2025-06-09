print("> init.server.luau")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Hook = require(ReplicatedStorage.Shared.Hook)

local newHook = Hook.new("hook-id-123", "Test Hook")
print(newHook)
