# Roblox Luau Cheat Sheet

Luau is Roblox's customized version of Lua 5.1, featuring performance enhancements, additional syntax, and a powerful **optional type system**.

---

## I. Core Lua Fundamentals (Quick Overview)

* **Comments:**
    * Single-line: `-- This is a comment`
    * Multi-line: `--[[ This is a multi-line comment ]]`
* **Variables:**
    * Declaration: `local myVariable = value`
    * Global (generally discouraged): `myGlobal = value`
* **Data Types:** `nil`, `boolean`, `number`, `string`, `table`, `function`, `thread`, `userdata` (Roblox **`Instance`**s are `userdata`)
* **Operators:**
    * Arithmetic: `+`, `-`, `*`, `/`, `%` (modulo), `^` (exponent)
    * Concatenation: `..` (e.g., `"Hello " .. "World"`)
    * Comparison: `==`, `~=` (not equal), `<`, `>`, `<=`, `>=`
    * Logical: `and`, `or`, `not`
* **Tables (The primary data structure):**
    * Empty: `local t = {}`
    * Array-like (1-indexed): `local arr = {"a", "b", "c"}` (`arr[1]` is "a")
    * Dictionary-like: `local dict = {name = "Alice", age = 30}` (`dict.name` or `dict["name"]`)
    * Mixed: `local mixed = {1, "two", key = true}`
    * Length: `#arr` (for array-like tables)
* **Control Flow:**
    * `if-then-elseif-else-end`:
        ```lua
        if condition then
            -- code
        elseif anotherCondition then
            -- code
        else
            -- code
        end
        ```
    * `for` loops:
        * Numeric: `for i = start, finish, step do ... end`
        * Generic: `for key, value in pairs(table) do ... end` (any key-value pairs)
        * Generic: `for index, value in ipairs(array) do ... end` (numeric keys only, stops at first `nil`)
    * `while` loop: `while condition do ... end`
    * `repeat-until` loop: `repeat ... until condition`
    * `break`, `continue` (Luau specific)
* **Functions:**
    * Definition: `local function myFunc(param1, param2) ... return value end`
    * Anonymous: `local func = function(param) ... end`

---

## II. Luau Specific Enhancements

### 1. Type Annotations (Static Analysis)

* **Purpose:** For **type checking**, **linting**, and autocompletion in Roblox Studio. **Ignored completely at runtime.**
* **Enabling Type Checking:** Add one of these at the top of your script:
    * `--!strict` (Recommended for new code, enforces strict type checking)
    * `--!nonstrict` (Default, infers `any` for unannotated types)
    * `--!nocheck` (Disables type checking for the script)
* **Variable Annotation:**
    ```lua
    local myNumber: number = 123
    local myString: string = "hello"
    local myPart: Part = Instance.new("Part")
    local maybeNil: string? -- Optional type, can be string or nil
    ```
* **Function Parameter/Return Types:**
    ```lua
    local function add(a: number, b: number): number
        return a + b
    end

    local function greet(name: string): () -- Function returns nothing
        print("Hello, " .. name)
    end

    -- Multi-return types
    local function getCoords(): (number, number)
        return 10, 20
    end
    ```
* **Table Types (Object Shapes):**
    ```lua
    type Vector2D = {
        x: number,
        y: number
    }

    local point: Vector2D = {x = 1, y = 2}

    -- Array-like table type
    type StringList = {string} -- Equivalent to { [number]: string }
    local names: StringList = {"Alice", "Bob"}

    -- Dictionary with specific keys (sealed table by default)
    type PlayerData = {
        name: string,
        score: number,
        isOnline?: boolean -- Optional property
    }
    local data: PlayerData = {name = "Player1", score = 100}
    ```
* **Type Aliases (`type` keyword):**
    ```lua
    type EntityId = number
    type Point = {X: number, Y: number, Z: number}
    type Callback = (success: boolean, message: string) -> ()

    local id: EntityId = 123
    ```
* **Type Assertion (`::` operator):**
    Tells the type checker to treat an expression as a specific type.
    ```lua
    local untypedData = {}
    local typedData = untypedData :: PlayerData -- Assert untypedData is of PlayerData type
    ```
* **`typeof` operator:** Infers the type of an expression.
    ```lua
    local MyModule = {}
    function MyModule.new() return {} end
    type MyModuleType = typeof(MyModule) -- Infers type from MyModule table structure
    ```

### 2. Other Luau Enhancements

* **`continue` statement:** Jumps to the next iteration of a loop.
* **Compound Assignment Operators:** `+=`, `-=`, `*=`, `/=`, `//=`, `%=`, `^=`, `..=`
    * `health -= 10` (equivalent to `health = health - 10`)
* **Bitwise Operators:** `&`, `|`, `~`, `^` (XOR), `>>`, `<<` (right/left shift)
* **String Interpolation (f-strings):** Use backticks `` ` ``
    * `` local msg = `Hello, {name}! Your score is {score}.` ``

---

## III. Roblox API & Structure (Essentials)

* **`game` global:** Represents the entire Roblox experience.
* **Services:** Access core game functionalities using `game:GetService("ServiceName")`.
    ```lua
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local ServerStorage = game:GetService("ServerStorage")
    local ServerScriptService = game:GetService("ServerScriptService")
    local StarterGui = game:GetService("StarterGui")
    local DataStoreService = game:GetService("DataStoreService")
    local Lighting = game:GetService("Lighting")
    ```
* **Object Hierarchy:** Objects (**`Instance`**s) are organized in a tree structure.
    * `Part.Parent`
    * `Part.Children` (a table of direct children)
    * `Instance:FindFirstChild("Name")`
    * `Instance:WaitForChild("Name")` (waits until child exists, prevents errors)
    * `Instance.new("ClassName")` (creates a new object)
    * `Instance:Destroy()` (removes an object from the game and cleans up)
* **Properties:** Configure object attributes.
    ```lua
    part.BrickColor = BrickColor.new("Really red")
    part.Size = Vector3.new(4, 2, 6)
    part.Anchored = true -- Prevents part from falling due to gravity
    ```
* **Events:** Connect functions to game events.
    ```lua
    part.Touched:Connect(function(hit)
        print(hit.Name .. " touched the part!")
    end)

    Players.PlayerAdded:Connect(function(player)
        print(player.Name .. " joined the game!")
    end)
    ```
* **Client vs. Server Scripts:**
    * **Server Scripts (`.ServerScript`):** Run on the Roblox server. Control game logic, data, security.
    * **Local Scripts (`.LocalScript`):** Run on the client (player's device). Handle UI, player input, local visual effects. Can only access client-side services.

---

## IV. Common Roblox Luau Patterns

### 1. Object-Oriented Programming (Table-based "Classes")

```lua
-- Class Definition Module (e.g., stored in ReplicatedStorage/Modules/MyClassModule.lua)
local MyClass = {}
MyClass.__index = MyClass -- Essential for method inheritance lookup

-- Luau type definition for our class instances
type MyClass = typeof(setmetatable({} :: { Value: number }, MyClass))

--- Constructor for MyClass.
-- @param initialValue number The starting value for this instance.
-- @return MyClass A new instance of MyClass.
function MyClass:new(initialValue: number): MyClass
    local instance = setmetatable({}, self) -- 'self' here refers to the MyClass table (the blueprint)
    instance.Value = initialValue -- Instance property
    return instance
end

--- Adds an amount to the instance's value.
-- @param amount number The amount to add.
function MyClass:Add(amount: number): ()
    self.Value += amount -- 'self' here refers to the specific instance calling the method
    print("New value: " .. self.Value)
end

return MyClass -- The module returns the class table
```

```lua
-- Usage in another script (e.g., a Server Script or Local Script)
local MyClass = require(game.ReplicatedStorage.Modules.MyClassModule)

local obj1 = MyClass:new(10)
obj1:Add(5) -- Output: New value: 15

local obj2 = MyClass:new(20)
obj2:Add(3) -- Output: New value: 23
```

### 2. Module Scripts

* Used for **code reusability** (e.g., classes, utility functions, shared data).
* Loaded into other scripts using **`require()`**.
* A `ModuleScript` runs only once when it's `require()`d for the first time; subsequent `require()` calls return the same table that was initially returned.

### 3. Client-Server Communication

* **`RemoteEvent`:** For **one-way communication** (e.g., client tells server it clicked a button).
    * Client to Server: `RemoteEvent:FireServer(arg1, arg2, ...)`
    * Server listens: `RemoteEvent.OnServerEvent:Connect(function(player, arg1, arg2, ...) ... end)`
    * Server to Client: `RemoteEvent:FireClient(player, arg1, arg2, ...)`
    * Client listens: `RemoteEvent.OnClientEvent:Connect(function(arg1, arg2, ...) ... end)`
* **`RemoteFunction`:** For **two-way communication** (e.g., client asks server for data and waits for response).
    * Client to Server (waits): `response = RemoteFunction:InvokeServer(arg1, arg2, ...)`
    * Server handles & returns: `RemoteFunction.OnServerInvoke = function(player, arg1, arg2, ...) return value end`
    * Server to Client (waits): `response = RemoteFunction:InvokeClient(player, arg1, arg2, ...)`
    * Client handles & returns: `RemoteFunction.OnClientInvoke = function(arg1, arg2, ...) return value end`