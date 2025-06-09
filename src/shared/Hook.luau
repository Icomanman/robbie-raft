--
local Hook = {}
Hook.__index = Hook

export type Hook = typeof(setmetatable(
    {} :: {
        active: boolean,
        cooldown: number,
        id: string,
        name: string,
    },
    Hook
))

function Hook.new(id: string, name: string): Hook
    return setmetatable({
        name = name or "Default Hook",
        id = id or "hook-id-" .. tostring(math.random(0, 9999999)),
    }, Hook)
end

function Hook.scanNearbyItems()
    print("scanNearbyItems called")
end

local newHook = Hook.new()
print(newHook)

print("> from Module Script")

return Hook
