-- Framework Bridge for QBCore and ESX compatibility
Framework = {}
Framework.Type = nil
Framework.Object = nil

-- Detect and initialize the framework
function Framework.Init()
    if GetResourceState('qb-core') == 'started' or GetResourceState('qbx_core') == 'started' then
        Framework.Type = 'qb'
        if GetResourceState('qbx_core') == 'started' then
            Framework.Object = exports['qbx_core']:GetCoreObject()
        else
            Framework.Object = exports['qb-core']:GetCoreObject()
        end
        print('[donk_labs] Framework detected: QBCore')
    elseif GetResourceState('es_extended') == 'started' then
        Framework.Type = 'esx'
        Framework.Object = exports['es_extended']:getSharedObject()
        print('[donk_labs] Framework detected: ESX')
    else
        error('[donk_labs] No compatible framework found! Please install QBCore or ESX')
    end
end

-- Server-side functions
if IsDuplicityVersion() then
    function Framework.GetPlayer(source)
        if Framework.Type == 'qb' then
            return Framework.Object.Functions.GetPlayer(source)
        elseif Framework.Type == 'esx' then
            return Framework.Object.GetPlayerFromId(source)
        end
    end

    function Framework.GetIdentifier(source)
        local player = Framework.GetPlayer(source)
        if not player then return nil end

        if Framework.Type == 'qb' then
            return player.PlayerData.citizenid
        elseif Framework.Type == 'esx' then
            return player.identifier
        end
    end

    function Framework.HasItem(source, item)
        local player = Framework.GetPlayer(source)
        if not player then return false end

        if Framework.Type == 'qb' then
            local hasItem = player.Functions.GetItemByName(item)
            return hasItem ~= nil
        elseif Framework.Type == 'esx' then
            local item = player.getInventoryItem(item)
            return item and item.count > 0
        end
        return false
    end

    function Framework.AddItem(source, item, amount)
        local player = Framework.GetPlayer(source)
        if not player then return false end

        if Framework.Type == 'qb' then
            return player.Functions.AddItem(item, amount)
        elseif Framework.Type == 'esx' then
            player.addInventoryItem(item, amount)
            return true
        end
        return false
    end

    function Framework.RemoveItem(source, item, amount)
        local player = Framework.GetPlayer(source)
        if not player then return false end

        if Framework.Type == 'qb' then
            return player.Functions.RemoveItem(item, amount)
        elseif Framework.Type == 'esx' then
            player.removeInventoryItem(item, amount)
            return true
        end
        return false
    end

    function Framework.GetPlayerName(source)
        local player = Framework.GetPlayer(source)
        if not player then return "Unknown" end

        if Framework.Type == 'qb' then
            return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
        elseif Framework.Type == 'esx' then
            return player.getName()
        end
        return "Unknown"
    end
else
    -- Client-side functions
    function Framework.GetPlayerData()
        if Framework.Type == 'qb' then
            return Framework.Object.Functions.GetPlayerData()
        elseif Framework.Type == 'esx' then
            return Framework.Object.GetPlayerData()
        end
    end

    function Framework.ShowNotification(message, type)
        if Framework.Type == 'qb' then
            Framework.Object.Functions.Notify(message, type or 'primary', 5000)
        elseif Framework.Type == 'esx' then
            Framework.Object.ShowNotification(message)
        end
    end

    function Framework.HasItem(item)
        if Framework.Type == 'qb' then
            local hasItem = Framework.Object.Functions.HasItem(item)
            return hasItem
        elseif Framework.Type == 'esx' then
            -- ESX requires server callback for item check
            return true -- This will be validated server-side
        end
        return false
    end
end

-- Initialize framework on resource start
CreateThread(function()
    Framework.Init()
end)
