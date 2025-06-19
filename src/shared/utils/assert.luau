-- generic function signature
local utils = {} :: { [string]: (...any) -> any }

--- Asserts that the given value is of the expected type.
-- @param value any The value to check.
-- @param expectedType string The expected type of the value.
-- @throws error if the value is not of the expected type.
function utils.assertObjType(obj: any, class: any): nil
    assert(
        typeof(obj) == "Instance" and obj:IsA(class),
        string.format("> Expected value of type '%s', got '%s'.", class, typeof(obj))
    )
end

return utils
