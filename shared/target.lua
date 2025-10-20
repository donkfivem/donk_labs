-- Target System Bridge for qb-target and ox_target compatibility
Target = {}
Target.Type = nil

-- Detect and initialize the target system
function Target.Init()
    if GetResourceState('qb-target') == 'started' then
        Target.Type = 'qb-target'
        print('[donk_labs] Target system detected: qb-target')
    elseif GetResourceState('ox_target') == 'started' then
        Target.Type = 'ox_target'
        print('[donk_labs] Target system detected: ox_target')
    else
        error('[donk_labs] No compatible target system found! Please install qb-target or ox_target')
    end
end

-- Add a box zone with options
function Target.AddBoxZone(name, coords, width, length, options, targetOptions)
    if Target.Type == 'qb-target' then
        exports['qb-target']:AddBoxZone(name, coords, width, length, options, {
            options = targetOptions.options,
            distance = targetOptions.distance
        })
    elseif Target.Type == 'ox_target' then
        -- ox_target uses a different format
        local oxOptions = {}
        for i, option in ipairs(targetOptions.options) do
            table.insert(oxOptions, {
                name = name .. '_option_' .. i,
                label = option.label,
                icon = option.icon,
                onSelect = option.action,
                canInteract = option.canInteract,
                items = option.item and {option.item} or nil,
                distance = targetOptions.distance or 2.0
            })
        end

        exports.ox_target:addBoxZone({
            coords = coords,
            size = vector3(width, length, options.maxZ - options.minZ),
            rotation = options.heading or 0,
            debug = options.debugPoly or false,
            options = oxOptions
        })
    end
end

-- Remove a zone by name
function Target.RemoveZone(name)
    if Target.Type == 'qb-target' then
        exports['qb-target']:RemoveZone(name)
    elseif Target.Type == 'ox_target' then
        exports.ox_target:removeZone(name)
    end
end

-- Initialize target system when called
CreateThread(function()
    Target.Init()
end)
