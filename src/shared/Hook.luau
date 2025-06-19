local utils = require(script.Parent.utils.assert)
--
local Hook = {}
Hook.__index = Hook

export type Hook = typeof(setmetatable(
    {} :: {
        toolRef: Player,
        active: boolean,
        cooldown: number,
        id: string,
        name: string,
        -- -- Physical properties of the hook mechanism itself
        -- length: number, -- The current length of the deployed hook cable
        -- maxLength: number, -- The maximum reach of the hook cable
        -- pullForce: number, -- How strong the hook pulls the player/object
        -- -- State properties
        -- isDeployed: boolean, -- True if the hook is currently out and attached
        -- targetPosition: Vector3?, -- Where the hook is currently attached in the world (optional, can be nil)
    },
    Hook
))

--- Creates a new Hook instance.
-- @param tool Player The Player instance that owns the hook.
-- @param id string Unique identifier for the hook.
-- @param name string Display name for the hook.
-- @param maxLength number The maximum length the hook can extend.
-- @param pullForce number The force used to pull when the hook is active.
-- @return Hook A new Hook instance with all properties initialized.
function Hook.new(tool: Player, id: string?, name: string?): Hook
    -- function Hook.new(tool: Tool, id: string, name: string, maxLength: number, pullForce: number): Hook
    -- assert(typeof(tool) == "Instance" and tool:IsA("Tool"), "HookClass:new expects 'tool' to be a Tool instance.")
    -- assert(typeof(tool) == "Instance" and tool:IsA("Player"), "HookClass:new expects 'tool' to be a Player instance.")
    utils.assertObjType(tool, "Player") -- Ensure tool is a Player instance
    return setmetatable({
        toolRef = tool, -- reference to the Tool instance
        active = false, -- Default: not active
        cooldown = 0, -- Default: no cooldown initially
        id = id or "hook-id-" .. tostring(math.random(0, 9999999)),
        name = name or "Default Hook",
        -- -- Physical properties of the hook mechanism itself
        -- length = 0, -- Starts at 0 (not deployed)
        -- maxLength = maxLength, -- Requires a value to be passed in
        -- pullForce = pullForce, -- Requires a value to be passed in
        -- isDeployed = false, -- Starts as not deployed
        -- targetPosition = nil, -- No target position initially
    }, Hook)
end

function Hook.scanNearbyItems()
    print("scanNearbyItems called")
end

return Hook
