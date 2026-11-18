fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'whip_onx_vehicles'
description 'Registers ONX CVP/EVP vehicle packs into the WHIPFX Vehicle catalog'
version '1.0.0'

dependency 'whip_core'
whip_requires '1.0.2'

shared_scripts {
    '@whip_core/lib/satellite.lua',
}

server_scripts {
    'vehicles.lua',
    'server/main.lua',
}

files {
    'images/*.webp',
}
