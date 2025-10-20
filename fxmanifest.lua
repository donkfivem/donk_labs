server_script '@ElectronAC/src/include/server.lua'
client_script '@ElectronAC/src/include/client.lua'

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'donk'
description 'Keybased labs for QBCore'
version '1.0'

client_scripts {
    'client/cl_main.lua'
}

shared_script {
    'shared/config.lua',
    '@ox_lib/init.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua'
}