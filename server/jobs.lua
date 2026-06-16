-- Real Estate Agent Job

local realEstateAgents = {}

-- Register real estate job
function RegisterRealEstateJob()
    print("^2[Housing] Registering Real Estate Agent Job^7")
    -- Job would be registered in your ESX/QBCore framework here
end

-- Get real estate agents
function GetRealEstateAgents()
    return realEstateAgents
end

-- Add real estate agent
function AddRealEstateAgent(playerId, playerName)
    realEstateAgents[playerId] = {
        id = playerId,
        name = playerName,
        salary = Config.JobSalary,
        jobStartTime = os.time(),
    }
end

-- Remove real estate agent
function RemoveRealEstateAgent(playerId)
    if realEstateAgents[playerId] then
        realEstateAgents[playerId] = nil
        return true
    end
    return false
end

-- Pay all agents
function PayAllRealEstateAgents()
    for playerId, agent in pairs(realEstateAgents) do
        -- Payment logic would go here
        -- TriggerEvent('esx_addonaccount:getSharedAccount', Config.RealEstateJob.name, function(account)
        --     account.addMoney(Config.JobSalary)
        -- end)
    end
end

-- Get agent info
function GetAgentInfo(playerId)
    return realEstateAgents[playerId]
end

RegisterRealEstateJob()