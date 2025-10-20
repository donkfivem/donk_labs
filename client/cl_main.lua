QBCore = exports['qb-core']:GetCoreObject()
CarryPackage = nil

-- Opens the menu to lock/unlock and enter a lab
-- @param lab string - Name of the lab
function LockUnlock(lab)
    print(lab)
    local menu = {
        {
            header = "< Close",
            txt = "ESC or click to close",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    if Config.Labs[lab].locked then
        menu[#menu+1] = {
            header = "Unlock Door",
            txt = "",
            params = {
                isServer = true,
                event = "qb-labs:server:unlock",
                args = {
                    lab = lab
                }
            }
        }
    else
        menu[#menu+1] = {
            header = "Lock Door",
            txt = "",
            params = {
                isServer = true,
                event = "qb-labs:server:lock",
                args = {
                    lab = lab
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end

-- Teleports the player ped inside a given lab
-- @param lab string - Name of the lab
local function enterLab(lab)
    Wait(500)
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(PlayerPedId(), Config.Labs[lab].exit.x, Config.Labs[lab].exit.y, Config.Labs[lab].exit.z - 0.98)
    SetEntityHeading(PlayerPedId(), Config.Labs[lab].exit.w)
    Wait(1000)
    TriggerServerEvent("qb-log:server:CreateLog", "keylabs", "Enter "..lab, "white", "**"..GetPlayerName(PlayerId()).."** has entered the "..lab)
    DoScreenFadeIn(250)
end

-- Performs the unlocking animation and plays a sound
local function OpenDoorAnimation()
    RequestAnimDict("anim@heists@keycard@")
    while not HasAnimDictLoaded("anim@heists@keycard@") do Wait(10) end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

-- Teleports the player ped inside a given lab
-- @param lab string - Name of the lab
function enterKeyLab(lab)
    local pos = GetEntityCoords(PlayerPedId())
    if #(pos - Config.Labs[lab].entrance.xyz) < 1 then
        enterLab(lab)
    end
end

-- Teleports the player ped outside a given lab
-- @param lab string - Name of the lab
function Exitlab(lab)
    local ped = PlayerPedId()
    OpenDoorAnimation()
    DoScreenFadeOut(250)
    Wait(250)
    SetEntityCoords(ped, Config.Labs[lab].entrance.x, Config.Labs[lab].entrance.y, Config.Labs[lab].entrance.z - 0.98)
    SetEntityHeading(ped, Config.Labs[lab].entrance.w)
    Wait(1000)
    TriggerServerEvent("qb-log:server:CreateLog", "keylabs", "Exit "..lab, "black", "**"..GetPlayerName(PlayerId()).."** has entered the "..lab)
    DoScreenFadeIn(250)
end


-- Config is now loaded directly from shared script, no need for server callbacks

RegisterNetEvent('qb-labs:client:DoorAnimation', function()
    OpenDoorAnimation()
end)

RegisterNetEvent('qb-labs:client:lock', function(lab)
    Config.Labs[lab].locked = true
end)

RegisterNetEvent('qb-labs:client:unlock', function(lab)
    Config.Labs[lab].locked = false
end)

-- Initialize all lab zones
CreateThread(function()
    for labName, labData in pairs(Config.Labs) do
        -- Create entrance zone
        local entranceZone = labData.entranceZone
        exports["qb-target"]:AddBoxZone(labName .. "entrance", labData.entrance.xyz, entranceZone.size.x, entranceZone.size.y, {
            name = labName .. "entrance",
            heading = labData.entrance.w,
            debugPoly = false,
            minZ = labData.entrance.z + entranceZone.minZ,
            maxZ = labData.entrance.z + entranceZone.maxZ,
        }, {
            options = {
                {
                    action = function()
                        enterKeyLab(labName)
                    end,
                    icon = "fas fa-user-secret",
                    label = "Enter",
                    canInteract = function()
                        if Config.Labs[labName].locked then return false end
                        return true
                    end,
                },
                {
                    action = function()
                        LockUnlock(labName)
                    end,
                    icon = "fas fa-key",
                    label = "Lock/Unlock Door",
                    item = labData.key
                }
            },
            distance = 1.5
        })

        -- Create exit zone
        local exitZone = labData.exitZone
        exports["qb-target"]:AddBoxZone(labName .. "exit", labData.exit.xyz, exitZone.size.x, exitZone.size.y, {
            name = labName .. "exit",
            heading = labData.exit.w,
            debugPoly = false,
            minZ = labData.exit.z + exitZone.minZ,
            maxZ = labData.exit.z + exitZone.maxZ,
        }, {
            options = {
                {
                    action = function()
                        Exitlab(labName)
                    end,
                    icon = "fas fa-user-secret",
                    label = "Exit",
                    canInteract = function()
                        if Config.Labs[labName].locked then return false end
                        return true
                    end,
                },
                {
                    action = function()
                        LockUnlock(labName)
                    end,
                    icon = "fas fa-key",
                    label = "Lock/Unlock Door",
                    item = labData.key
                }
            },
            distance = 1.5
        })
    end
end)