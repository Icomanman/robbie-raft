-- local cs = game:GetService("CollectionService")
local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local Hook = require(rs.Shared.Hook)
--
local utils = require(rs.Shared.utils.assert)
--
local Hooks = {} :: { [string]: Hook }

local function spawnHook(tool: Player)
    -- assert(typeof(tool) == "Instance" and tool:IsA("Player"), "HookManager:spawnHook expects 'tool' to be a Player instance.")
    utils.assertObjType(tool, "Player") -- Ensure tool is a Player instance
    local username = tool.Name
    if Hooks[username] then
        warn("Hook already exists for this username, returning existing hook.")
        return Hooks[username]
    end
    -- Instantiate a new Hook
    local hook = Hook.new(tool)
    -- Store it in the Hooks table
    table.insert(Hooks, hook)
    return hook
end

task.wait(1)
for _, player in players:GetPlayers() do
    print("Spawning hook for player:", player.Name)
    local hook = spawnHook(player)
    print("Spawned hook for player:", player.Name, "Hook:", hook)
    spawnHook(player)
end
