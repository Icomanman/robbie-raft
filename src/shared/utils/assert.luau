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

--- Creates a popup GUI for the player with the specified text.
-- @param player Player The player to create the popup for.
-- @param text string? The text to display in the popup. Defaults to nil.
function utils.createPopup(player: Player, text: string?): nil
    -- if not player or not player:FindFirstChild("PlayerGui") then
    if not player then
        return
    end

    local popupGui = Instance.new("ScreenGui")
    popupGui.Name = "PickupPopup"
    popupGui.ResetOnSpawn = false
    popupGui.Parent = player.PlayerGui

    local popupFrame = Instance.new("Frame")
    popupFrame.Size = UDim2.new(0.2, 0, 0.05, 0)
    popupFrame.Position = UDim2.new(0.4, 0, 0.8, 0)
    popupFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    popupFrame.BackgroundTransparency = 0.4
    popupFrame.BorderSizePixel = 0
    popupFrame.Parent = popupGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = popupFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Parent = popupFrame

    task.delay(1.5, function()
        popupFrame:TweenPosition(UDim2.new(0.4, 0, 0.75, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
        task.wait(0.5)
        popupGui:Destroy()
    end)
end

return utils
