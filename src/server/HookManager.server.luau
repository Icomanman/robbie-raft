local cs = game:GetService("CollectionService")
local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local Hook = require(rs.Shared.Hook)

local Hooks = {} :: { [Player]: Hook }

local function spawnHook(tool: Player)
    -- assert(typeof(tool) == "Player", "HookManager:spawnHook expects 'tool' to be a Player instance.")

    if Hooks[tool] then
        warn("Hook already exists for this tool, returning existing hook.")
        return Hooks[tool]
    end

    local hook = Hook.new(tool)
    table.insert(Hooks, hook)
    cs:AddTag(tool, "Hook")

    return hook
end

task.wait(1)
for _, player in players:GetPlayers() do
    print("Spawning hook for player:", player.Name)
    local hook = spawnHook(player)
    print("Spawned hook for player:", player.Name, "Hook:", hook)
    spawnHook(player)
end
