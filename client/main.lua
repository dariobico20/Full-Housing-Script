-- Full Housing Script - Client Side

local playerHouse = nil
local housesData = {}
local placedDecorations = {}
local isInHouse = false

-- Initialize housing
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2[Housing] Client initialized^7")
        TriggerServerEvent('housing:requestHouses')
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"Housing", "Housing system loaded. Use /house to start."}
        })
    end
end)

-- Sync houses from server
RegisterNetEvent('housing:syncHouses')
AddEventHandler('housing:syncHouses', function(houses)
    housesData = houses
    print("^2[Housing] Synced " .. CountTable(houses) .. " houses from server^7")
end)

-- Update player house ownership
RegisterNetEvent('housing:updatePlayerHouse')
AddEventHandler('housing:updatePlayerHouse', function(houseId)
    playerHouse = houseId
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"Housing", "^2Congratulations! You now own a house!"}
    })
end)

-- Commands
RegisterCommand('house', function(source, args, rawCommand)
    OpenHousingMenu()
end, false)

RegisterCommand('browse', function(source, args, rawCommand)
    BrowseHouses()
end, false)

RegisterCommand('buyhouse', function(source, args, rawCommand)
    if args[1] then
        BuyHouse(tonumber(args[1]))
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1Usage: /buyhouse [number]"}
        })
    end
end, false)

RegisterCommand('enterhouse', function(source, args, rawCommand)
    if playerHouse then
        EnterHouse(playerHouse)
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1You don't own a house!"}
        })
    end
end, false)

RegisterCommand('exithouse', function(source, args, rawCommand)
    ExitHouse()
end, false)

RegisterCommand('decorate', function(source, args, rawCommand)
    OpenDecorationMenu()
end, false)

RegisterCommand('placeitem', function(source, args, rawCommand)
    if args[1] then
        PlaceDecoration(tonumber(args[1]))
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1Usage: /placeitem [number]"}
        })
    end
end, false)

RegisterCommand('removeitem', function(source, args, rawCommand)
    if args[1] then
        RemoveDecoration(tonumber(args[1]))
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1Usage: /removeitem [number]"}
        })
    end
end, false)

RegisterCommand('sellhouse', function(source, args, rawCommand)
    SellHouse()
end, false)

RegisterCommand('houseinfo', function(source, args, rawCommand)
    if args[1] then
        ViewHouseInfo(tonumber(args[1]))
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Housing", "^1Usage: /houseinfo [number]"}
        })
    end
end, false)

RegisterCommand('houses', function(source, args, rawCommand)
    ListAllHouses()
end, false)

-- Helper function
function CountTable(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end