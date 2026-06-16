-- Database functions for housing

local houses = {}
local houseDecorations = {}

-- Initialize houses from config
function InitializeHouses()
    for _, house in ipairs(Config.Houses) do
        houses[house.id] = {
            id = house.id,
            name = house.name,
            basePrice = house.basePrice,
            shell = house.shell,
            exterior = house.exterior,
            heading = house.heading,
            owner = nil,
            decorations = {},
            created = os.time(),
        }
        houseDecorations[house.id] = {}
    end
end

-- Get house by ID
function GetHouse(houseId)
    return houses[houseId]
end

-- Get all houses
function GetAllHouses()
    return houses
end

-- Set house owner
function SetHouseOwner(houseId, playerId)
    if houses[houseId] then
        houses[houseId].owner = playerId
        return true
    end
    return false
end

-- Remove house owner (sell house)
function RemoveHouseOwner(houseId)
    if houses[houseId] then
        houses[houseId].owner = nil
        houses[houseId].decorations = {}
        houseDecorations[houseId] = {}
        return true
    end
    return false
end

-- Check if player owns house
function PlayerOwnsHouse(playerId)
    for id, house in pairs(houses) do
        if house.owner == playerId then
            return id
        end
    end
    return nil
end

-- Add decoration to house
function AddDecoration(houseId, decorationData)
    if houses[houseId] then
        table.insert(houses[houseId].decorations, decorationData)
        return true
    end
    return false
end

-- Remove decoration from house
function RemoveDecoration(houseId, index)
    if houses[houseId] and houses[houseId].decorations[index] then
        table.remove(houses[houseId].decorations, index)
        return true
    end
    return false
end

-- Get house decorations
function GetHouseDecorations(houseId)
    if houses[houseId] then
        return houses[houseId].decorations
    end
    return {}
end

-- Calculate house price based on shell
function CalculateHousePrice(houseId)
    local house = houses[houseId]
    if house then
        local shell = Config.HouseShells[house.shell]
        if shell then
            return math.floor(house.basePrice * shell.price_multiplier)
        end
    end
    return house.basePrice
end

-- Initialize on server start
InitializeHouses()

print("^2[Housing] Database initialized with " .. #Config.Houses .. " houses^7")