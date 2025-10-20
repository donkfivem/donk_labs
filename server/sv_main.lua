QBCore = exports['qb-core']:GetCoreObject()

-- Config callback removed - client now reads config directly from shared script

RegisterNetEvent('qb-labs:server:lock', function(data)
    Config.Labs[data.lab].locked = true
    TriggerClientEvent('qb-labs:client:lock', -1, data.lab)
    TriggerClientEvent('qb-labs:client:DoorAnimation', source)
end)

RegisterNetEvent('qb-labs:server:unlock', function(data)
    Config.Labs[data.lab].locked = false
    TriggerClientEvent('qb-labs:client:unlock', -1, data.lab)
    TriggerClientEvent('qb-labs:client:DoorAnimation', source)
end)