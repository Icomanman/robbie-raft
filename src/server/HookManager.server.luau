-- local cs = game:GetService("CollectionService")
local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local Hook = require(rs.Shared.Hook)
--
local utils = require(rs.Shared.utils.assert)
--
local Hooks = {} :: { [string]: Hook }

local function spawnHook(tool: Player)
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
    local hook = spawnHook(player)
    print("> Spawned hook for player:", player.Name, "Hook:", hook)
    spawnHook(player)

    local backpack = player:WaitForChild("Backpack") -- Ensures backpack exists
    local grapple = backpack:FindFirstChild("GrappleHook")
    print("> Backpack found for " .. player.Name, backpack)
    print("> Tool found " .. grapple.Name)

    backpack.ChildAdded:Connect(function(tool: Instance)
        if tool:IsA("Tool") then
            print("> Tool added to backpack:", tool.Name)
        end
    end)

    -- Handle tools already present
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            print("> Tool already in backpack:", tool.Name)
        end
    end
end
