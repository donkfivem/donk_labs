RegisterNetEvent('qb-labs:server:lock', function(data)
    local src = source
    local hasKey = Framework.HasItem(src, Config.Labs[data.lab].key)

    if not hasKey then
        if Framework.Type == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the required key', 'error')
        elseif Framework.Type == 'esx' then
            TriggerClientEvent('esx:showNotification', src, 'You don\'t have the required key')
        end
        return
    end

    Config.Labs[data.lab].locked = true
    TriggerClientEvent('qb-labs:client:lock', -1, data.lab)
    TriggerClientEvent('qb-labs:client:DoorAnimation', src)

    if Framework.Type == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, 'Door locked', 'success')
    elseif Framework.Type == 'esx' then
        TriggerClientEvent('esx:showNotification', src, 'Door locked')
    end
end)

RegisterNetEvent('qb-labs:server:unlock', function(data)
    local src = source
    local hasKey = Framework.HasItem(src, Config.Labs[data.lab].key)

    if not hasKey then
        if Framework.Type == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the required key', 'error')
        elseif Framework.Type == 'esx' then
            TriggerClientEvent('esx:showNotification', src, 'You don\'t have the required key')
        end
        return
    end

    Config.Labs[data.lab].locked = false
    TriggerClientEvent('qb-labs:client:unlock', -1, data.lab)
    TriggerClientEvent('qb-labs:client:DoorAnimation', src)

    if Framework.Type == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, 'Door unlocked', 'success')
    elseif Framework.Type == 'esx' then
        TriggerClientEvent('esx:showNotification', src, 'Door unlocked')
    end
end)
