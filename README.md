# donk_labs

> **Forked from**: [Lionh34rt's keylabs](https://github.com/Lionh34rt/keylabs)
> Enhanced with multi-framework and multi-target support

A comprehensive key-based lab system for FiveM, supporting both **QBCore** and **ESX** frameworks, with compatibility for **qb-target** and **ox_target** systems.

## Features

- **Multi-Framework Support**: Works with both QBCore and ESX
- **Multi-Target Support**: Compatible with qb-target and ox_target
- **Automatic Detection**: Automatically detects your framework and target system
- **Configurable Labs**: Easy-to-configure lab locations and settings
- **Key-Based Access**: Secure lab entry using key items
- **Lock/Unlock System**: Players with keys can lock and unlock lab doors
- **Teleportation System**: Seamless entry and exit with animations
- **Interior Support**: Uses bob74_ipl interiors for realistic lab environments

## Prerequisites

### Required
- **Framework**: QBCore or ESX
- **Target System**: qb-target or ox_target
- **ox_lib**: For UI components
- **oxmysql**: For database functionality

### Optional
- **bob74_ipl**: For lab interiors
- **InteractSound**: For door sound effects (QBCore only)

## Installation

1. **Download** the resource and place it in your `resources` folder

2. **Add items** to your framework's item configuration:

### QBCore (qb-core/shared/items.lua)
```lua
-- Lab Keys
["gunkey"] = {
    ["name"] = "gunkey",
    ["label"] = "Gun Bunker Key",
    ["weight"] = 0,
    ["type"] = "item",
    ["image"] = "gunkey.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Gun Bunker Access Key"
},
["gunkey3"] = {
    ["name"] = "gunkey3",
    ["label"] = "New Gun Bunker Key",
    ["weight"] = 0,
    ["type"] = "item",
    ["image"] = "gunkey.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "New Gun Bunker Access Key"
},
["lsdlabkeycard"] = {
    ["name"] = "lsdlabkeycard",
    ["label"] = "LSD Lab Keycard",
    ["weight"] = 0,
    ["type"] = "item",
    ["image"] = "labkey.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "LSD Lab Access Keycard"
},
["cokelabkeycard"] = {
    ["name"] = "cokelabkeycard",
    ["label"] = "Coke Lab Keycard",
    ["weight"] = 0,
    ["type"] = "item",
    ["image"] = "labkey.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Coke Lab Access Keycard"
}
```

### ESX with ox_inventory (ox_inventory/data/items.lua)
```lua
-- Add to your items.lua
['gunkey'] = {
    label = 'Gun Bunker Key',
    weight = 1,
    stack = false,
    close = true,
    description = 'Gun Bunker Access Key',
    client = {
        image = 'gunkey.png',
    }
},

['gunkey3'] = {
    label = 'New Gun Bunker Key',
    weight = 1,
    stack = false,
    close = true,
    description = 'New Gun Bunker Access Key',
    client = {
        image = 'gunkey.png',
    }
},

['lsdlabkeycard'] = {
    label = 'LSD Lab Keycard',
    weight = 1,
    stack = false,
    close = true,
    description = 'LSD Lab Access Keycard',
    client = {
        image = 'labkey.png',
    }
},

['cokelabkeycard'] = {
    label = 'Coke Lab Keycard',
    weight = 1,
    stack = false,
    close = true,
    description = 'Coke Lab Access Keycard',
    client = {
        image = 'labkey.png',
    }
}
```

3. **Add to server.cfg**:
```cfg
ensure ox_lib
ensure donk_labs
```

## Configuration

Edit `shared/config.lua` to customize your labs and settings:

```lua
-- Framework Settings
Config.Framework = 'auto' -- 'auto', 'qb', or 'esx'
Config.TargetSystem = 'auto' -- 'auto', 'qb-target', or 'ox_target'

-- Menu System (QBCore only)
Config.Menu = 'qb-menu' -- 'qb-menu' or 'ox_lib'

-- Notification System
Config.Notification = 'framework' -- 'framework', 'ox_lib', 'okokNotify', 'mythic_notify'

-- Lab Configuration
Config.Labs = {
    ["gunbunker"] = {
        entrance = vector4(769.2976, -2229.546, 99999.9, 91.511245),
        exit = vector4(903.19659, -3182.285, -97.05294, 90.00),
        locked = true,
        key = "gunkey",
        entranceZone = {size = {x = 0.8, y = 1.4}, minZ = -1, maxZ = 1},
        exitZone = {size = {x = 0.7, y = 1.6}, minZ = -1, maxZ = 1}
    },
    -- Add more labs here
}
```

## Usage

1. **Obtain a lab key** (configure how players get keys in your server)
2. **Approach the lab entrance** (target zone will appear)
3. **Use the target** to lock/unlock the door with your key
4. **Enter the lab** once unlocked
5. **Exit the lab** using the exit target zone inside

## Framework Compatibility

### QBCore
- Full support for QBCore and QBX Core
- Integration with qb-menu or ox_lib context menu
- Support for qb-log logging system
- Native notification system

### ESX
- Full support for ESX Legacy and older versions
- Native notification system
- Inventory integration for key checks

## Target System Compatibility

### qb-target
- Native qb-target box zones
- Item-based interaction filtering
- Full compatibility with all qb-target features

### ox_target
- Automatic conversion to ox_target format
- Support for all ox_target features
- Item-based interaction filtering

## File Structure

```
donk_labs/
├── client/
│   └── cl_main.lua          # Client-side logic
├── server/
│   └── sv_main.lua          # Server-side logic
├── shared/
│   ├── config.lua           # Main configuration
│   ├── framework.lua        # Framework bridge
│   └── target.lua           # Target system bridge
├── fxmanifest.lua           # Resource manifest
└── README.md                # This file
```

## Credits

- **Original Script**: [Lionh34rt](https://github.com/Lionh34rt) - Original keylabs system
- **Based on**: qb-moneywash and qb-methlab
- **Enhanced by**: donk - Multi-framework and multi-target support

## Support

For issues, questions, or contributions:
1. Check the [Issues](../../issues) page
2. Create a new issue with detailed information
3. Include your framework, target system, and any error messages

## Preview

Original preview: https://streamable.com/ve170x

## License

This project is a fork and enhancement of the original work. Please respect the original author's work and provide credit where due.

---

**Note**: This is a forked repository with significant enhancements for multi-framework support. The original project can be found at [Lionh34rt/keylabs](https://github.com/Lionh34rt/keylabs).
