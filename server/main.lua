-- Full Housing Script - Server Side

print("^2[Housing] Server started^7")

-- Handle house purchase
RegisterServerEvent('housing:buyHouse')
AddEventHandler('housing:buyHouse', function(houseId, price)
    local playerId = source
    local house = GetHouse(houseId)
    
    if not house then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1House not found!"}
        })
        return
    end
    
    if house.owner then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1This house is already owned!"}
        })
        return
    end
    
    -- Calculate actual price based on shell
    local actualPrice = CalculateHousePrice(houseId)
    
    -- Here you would check player money and deduct it
    -- For now, we'll just set the owner
    
    if SetHouseOwner(houseId, playerId) then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Housing", "^2You have purchased " .. house.name .. " for $" .. actualPrice}
        })
        TriggerClientEvent('housing:updatePlayerHouse', playerId, houseId)
        print("^2[Housing] Player " .. playerId .. " bought house " .. houseId .. "^7")
    end
end)

-- Handle decoration placement
RegisterServerEvent('housing:placeDecoration')
AddEventHandler('housing:placeDecoration', function(houseId, decorationData)
    local playerId = source
    local house = GetHouse(houseId)
    
    if not house then
        return
    end
    
    if house.owner ~= playerId then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own this house!"}
        })
        return
    end
    
    if AddDecoration(houseId, decorationData) then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Housing", "^2Decoration saved!"}
        })
    end
end)

-- Handle decoration removal
RegisterServerEvent('housing:removeDecoration')
AddEventHandler('housing:removeDecoration', function(houseId, index)
    local playerId = source
    local house = GetHouse(houseId)
    
    if not house then
        return
    end
    
    if house.owner ~= playerId then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own this house!"}
        })
        return
    end
    
    if RemoveDecoration(houseId, index) then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Housing", "^2Decoration removed!"}
        })
    end
end)

-- Handle house selling
RegisterServerEvent('housing:sellHouse')
AddEventHandler('housing:sellHouse', function(houseId)
    local playerId = source
    local house = GetHouse(houseId)
    
    if not house then
        return
    end
    
    if house.owner ~= playerId then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own this house!"}
        })
        return
    end
    
    if RemoveHouseOwner(houseId) then
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Housing", "^2House sold successfully!"}
        })
    end
end)

-- Request all house data
RegisterServerEvent('housing:requestHouses')
AddEventHandler('housing:requestHouses', function()
    local playerId = source
    local allHouses = GetAllHouses()
    TriggerClientEvent('housing:syncHouses', playerId, allHouses)
end)

-- Job payment - Fixed: SetTimeout instead of setTimeout
SetTimeout(Config.PaymentInterval, function()
    PayAllRealEstateAgents()
    print("^2[Housing] Paid all real estate agents^7")
end)

print("^2[Housing] Server initialized successfully^7")