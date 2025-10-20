Config = {}

Locales = {} -- Interaction locales

Config.Labs = {
    ["gunbunker"] = {
        entrance = vector4(769.2976, -2229.546, 99999.9, 91.511245),
        exit = vector4(903.19659, -3182.285, -97.05294, 90.00),
        locked = true,
        key = "gunkey",
        entranceZone = {size = {x = 0.8, y = 1.4}, minZ = -1, maxZ = 1},
        exitZone = {size = {x = 0.7, y = 1.6}, minZ = -1, maxZ = 1}
    },
    ["newgunbunker"] = {
        entrance = vector3(-1094.195, -2349.482, 14.101727),
        exit = vector4(-1598.187, -429.8414, 19.754362, 175.19985),
        locked = true,
        key = "gunkey3",
        entranceZone = {size = {x = 0.9, y = 1.4}, minZ = -1, maxZ = 1},
        exitZone = {size = {x = 0.9, y = 1.6}, minZ = -1, maxZ = 1}
    },
    ["methlab"] = {
        entrance = vector4(-142.8501, -2492.543, 44.410202, 143.62173),
        exit = vector4(996.61, -3200.65, -36.4, 90.0),
        locked = true,
        key = "lsdlabkeycard",
        entranceZone = {size = {x = 0.6, y = 1.2}, minZ = -1, maxZ = 1},
        exitZone = {size = {x = 0.6, y = 1.2}, minZ = -1, maxZ = 1}
    },
    ["cokelab"] = {
        entrance = vector4(-202.6422, 3651.8041, 51.736965, 13.92162),
        exit = vector4(1088.6855, -3187.462, -38.99342, 189.40104),
        locked = true,
        key = "cokelabkeycard",
        entranceZone = {size = {x = 0.6, y = 1.2}, minZ = -1, maxZ = 1},
        exitZone = {size = {x = 0.8, y = 1.2}, minZ = -1, maxZ = 1}
    },
}