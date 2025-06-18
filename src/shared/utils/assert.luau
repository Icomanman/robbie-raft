
function assertType(any: value, any: expectedType, string: message?): nil
    if typeof(value) ~= expectedType then
        error(message or ("Expected type " .. expectedType .. ", got " .. typeof(value)), 2)
    end
end