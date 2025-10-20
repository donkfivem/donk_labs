fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'donk'
description 'Keybased labs for QBCore & ESX with qb-target & ox_target support'
version '2.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/framework.lua',
    'shared/target.lua'
}

client_scripts {
    'client/cl_main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua'
}