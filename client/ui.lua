-- UI and Functions for Housing

-- Open main housing menu
function OpenHousingMenu()
    TriggerEvent('chat:addMessage', {
        color = {0, 150, 255},
        multiline = true,
        args = {"Housing", "^2=== HOUSING MENU ===^7\n[1] /browse - Browse Houses\n[2] /enterhouse - Enter Your House\n[3] /decorate - Decorate\n[4] /sellhouse - Sell Your House\n[5] /houses - List All Houses"}
    })
end

-- Browse available houses
function BrowseHouses()
    TriggerEvent('chat:addMessage', {
        color = {0, 150, 255},
        multiline = true,
        args = {"Housing", "^2========== AVAILABLE HOUSES =========="}
    })
    
    for id, house in pairs(housesData) do
        local status = house.owner and "^1[SOLD]^7" or "^2[FOR SALE]^7"
        local price = house.owner and "N/A" or "$" .. CalculateHousePrice(id)
        local info = "[" .. id .. "] " .. house.name .. " " .. status .. " | " .. house.shell .. " Shell | Price: " .. price
        TriggerEvent('chat:addMessage', {
            color = {200, 200, 200},
            multiline = true,
            args = {"", info}
        })
    end
    
    TriggerEvent('chat:addMessage', {
        color = {200, 200, 200},
        multiline = true,
        args = {"", "^2Usage: /buyhouse [number] | /houseinfo [number]"}
    })
end

-- List all houses with details
function ListAllHouses()
    TriggerEvent('chat:addMessage', {
        color = {0, 150, 255},
        multiline = true,
        args = {"Housing", "^2========== ALL HOUSES =========="}
    })
    
    for id, house in pairs(housesData) do
        local shell = Config.HouseShells[house.shell]
        local shellName = shell and shell.name or "Unknown"
        local status = house.owner and "^1Owned^7" or "^2Available^7"
        local price = CalculateHousePrice(id)
        
        TriggerEvent('chat:addMessage', {
            color = {200, 200, 200},
            multiline = true,
            args = {"", "[" .. id .. "] " .. house.name .. " - " .. status .. " - $" .. price .. " - " .. shellName}
        })
    end
end

-- Buy a house
function BuyHouse(houseId)
    local house = housesData[houseId]
    
    if not house then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1House #" .. houseId .. " not found!"}
        })
        return
    end
    
    if house.owner then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1This house is already owned!"}
        })
        return
    end
    
    local price = CalculateHousePrice(houseId)
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 0},
        multiline = true,
        args = {"Housing", "^3Purchasing " .. house.name .. " for $" .. price .. "...^7"}
    })
    
    TriggerServerEvent('housing:buyHouse', houseId, price)
end

-- Enter house
function EnterHouse(houseId)
    local house = housesData[houseId]
    
    if not house then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1House not found!"}
        })
        return
    end
    
    if not house.owner then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own this house!"}
        })
        return
    end
    
    LoadHouseShell(house.shell)
    SpawnPlayerInHouse(house)
    isInHouse = true
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"Housing", "^2Welcome to " .. house.name .. "! Type /decorate to decorate."}
    })
end

-- Load house interior
function LoadHouseShell(shellId)
    local shell = Config.HouseShells[shellId]
    
    if not shell then
        print("^1[Housing] Shell " .. shellId .. " not found!^7")
        return
    end
    
    print("^2[Housing] Loading interior: " .. shell.name .. "^7")
    RequestIpl(shell.interior)
    
    -- Remove other interiors
    for _, s in ipairs(Config.HouseShells) do
        if s.id ~= shellId then
            RemoveIpl(s.interior)
        end
    end
end

-- Spawn player in house
function SpawnPlayerInHouse(house)
    local shell = Config.HouseShells[house.shell]
    if shell then
        DoScreenFadeOut(800)
        Wait(1000)
        
        local playerPed = PlayerPedId()
        RequestModel(GetHashKey("player_one"))
        while not HasModelLoaded(GetHashKey("player_one")) do
            Wait(100)
        end
        
        SetEntityCoords(playerPed, shell.spawn.x, shell.spawn.y, shell.spawn.z, false, false, false, false)
        SetEntityHeading(playerPed, 0.0)
        FreezeEntityPosition(playerPed, false)
        
        DoScreenFadeIn(800)
    end
end

-- Exit house
function ExitHouse()
    if not isInHouse then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You're not in a house!"}
        })
        return
    end
    
    if playerHouse then
        local house = housesData[playerHouse]
        
        DoScreenFadeOut(800)
        Wait(1000)
        
        local playerPed = PlayerPedId()
        SetEntityCoords(playerPed, house.exterior.x, house.exterior.y, house.exterior.z, false, false, false, false)
        SetEntityHeading(playerPed, house.heading)
        
        DoScreenFadeIn(800)
        isInHouse = false
        
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"Housing", "^2You have exited your house."}
        })
    end
end

-- Open decoration menu
function OpenDecorationMenu()
    if not playerHouse then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own a house!"}
        })
        return
    end
    
    if not isInHouse then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You must be inside your house to decorate!"}
        })
        return
    end
    
    TriggerEvent('chat:addMessage', {
        color = {0, 150, 255},
        multiline = true,
        args = {"Housing", "^2========== DECORATION MENU =========="}
    })
    
    for i, decoration in ipairs(Config.Decorations) do
        TriggerEvent('chat:addMessage', {
            color = {200, 200, 200},
            multiline = true,
            args = {"", "[" .. i .. "] " .. decoration.name .. " - $" .. decoration.price}
        })
    end
    
    TriggerEvent('chat:addMessage', {
        color = {200, 200, 200},
        multiline = true,
        args = {"", "^2Usage: /placeitem [number]"}
    })
end

-- Place decoration
function PlaceDecoration(decorationId)
    if not playerHouse then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own a house!"}
        })
        return
    end
    
    if not isInHouse then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You must be inside your house!"}
        })
        return
    end
    
    local decoration = Config.Decorations[decorationId]
    
    if not decoration then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1Item not found!"}
        })
        return
    end
    
    -- Load model
    RequestModel(GetHashKey(decoration.model))
    while not HasModelLoaded(GetHashKey(decoration.model)) do
        Wait(100)
    end
    
    -- Get player position
    local playerPos = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    
    -- Create object
    local obj = CreateObject(GetHashKey(decoration.model), playerPos.x, playerPos.y, playerPos.z - 1, true, false, false)
    SetEntityHeading(obj, heading)
    PlaceObjectOnGround(obj)
    
    -- Store decoration data
    local decorData = {
        model = decoration.model,
        position = playerPos,
        heading = heading,
        name = decoration.name,
    }
    
    table.insert(placedDecorations, obj)
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"Housing", "^2" .. decoration.name .. " placed successfully!"}
    })
    
    TriggerServerEvent('housing:placeDecoration', playerHouse, decorData)
end

-- Remove decoration
function RemoveDecoration(index)
    if not playerHouse then
        return
    end
    
    if index > #placedDecorations then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1Decoration not found!"}
        })
        return
    end
    
    if placedDecorations[index] then
        DeleteEntity(placedDecorations[index])
    end
    
    table.remove(placedDecorations, index)
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"Housing", "^2Decoration removed!"}
    })
    
    TriggerServerEvent('housing:removeDecoration', playerHouse, index)
end

-- Sell house
function SellHouse()
    if not playerHouse then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own a house!"}
        })
        return
    end
    
    local house = housesData[playerHouse]
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 0},
        multiline = true,
        args = {"Housing", "^3You are selling " .. house.name .. "...^7"}
    })
    
    TriggerServerEvent('housing:sellHouse', playerHouse)
    playerHouse = nil
    placedDecorations = {}
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"Housing", "^2House sold successfully!"}
    })
end

-- View house info
function ViewHouseInfo(houseId)
    local house = housesData[houseId]
    
    if not house then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1House not found!"}
        })
        return
    end
    
    local shell = Config.HouseShells[house.shell]
    local shellName = shell and shell.name or "Unknown"
    local status = house.owner and "^1OWNED^7" or "^2FOR SALE^7"
    local price = CalculateHousePrice(houseId)
    
    TriggerEvent('chat:addMessage', {
        color = {0, 150, 255},
        multiline = true,
        args = {"Housing", "^2========== HOUSE INFO =========="}
    })
    TriggerEvent('chat:addMessage', {
        color = {200, 200, 200},
        multiline = true,
        args = {"", "^2Name:^7 " .. house.name}
    })
    TriggerEvent('chat:addMessage', {
        color = {200, 200, 200},
        multiline = true,
        args = {"", "^2Status:^7 " .. status}
    })
    TriggerEvent('chat:addMessage', {
        color = {200, 200, 200},
        multiline = true,
        args = {"", "^2Shell Type:^7 " .. shellName}
    })
    TriggerEvent('chat:addMessage', {
        color = {200, 200, 200},
        multiline = true,
        args = {"", "^2Price:^7 $" .. price}
    })
    TriggerEvent('chat:addMessage', {
        color = {200, 200, 200},
        multiline = true,
        args = {"", "^2Decorations:^7 " .. #house.decorations}
    })
end

-- Calculate house price based on shell
function CalculateHousePrice(houseId)
    local house = housesData[houseId]
    if house then
        local shell = Config.HouseShells[house.shell]
        if shell then
            return math.floor(house.basePrice * shell.price_multiplier)
        end
    end
    return house and house.basePrice or 0
end