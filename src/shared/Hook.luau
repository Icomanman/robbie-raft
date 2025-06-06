--
local Hook = {}
Hook.__index = Hook

export type Hook = typeof(setmetatable(
    {} :: {
        id: string,
        name: string,
    },
    Hook
))

function Hook.new(id: string, name: string): Hook
    return setmetatable({
        id = id,
        name = name,
    }, Hook)
end
