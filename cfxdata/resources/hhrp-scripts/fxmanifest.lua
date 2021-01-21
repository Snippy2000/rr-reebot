fx_version 'adamant'
games { 'gta5' }


--cron
server_script 'cron/server/main.lua'

--debug
client_scripts {'debug/client.lua'}

--heli
client_script 'heli/heli_client.lua'
server_script 'heli/heli_server.lua'

--hhrp-actionbar
client_script 'hhrp-actionbar/client.lua'

--hhrp-binoculars
client_script "hhrp-binocular/sbinoculars.lua"
server_script "hhrp-binocular/sserver.lua"

--hhrp-blips
client_scripts {'hhrp-blips/client.lua'}

--hhrp-carry
client_script "hhrp-carry/cl_carry.lua"
server_script "hhrp-carry/sv_carry.lua"

--hhrp-cctv
client_scripts {'hhrp-cctv/client.lua'}

--hhrp-emotes
client_script 'hhrp-emotes/WarMenu.lua'
client_script "hhrp-emotes/sitchair.lua"
client_script "hhrp-emotes/cl_menu.lua"
client_script "hhrp-emotes/client.lua"

--hhrp-fines
client_script "hhrp-fines/client.lua"
server_script "hhrp-fines/server.lua"

--hhrp-fish
client_script "hhrp-fish/client.lua"
server_script "hhrp-fish/server.lua"

--hhrp-fleeca
client_scripts {
    "hhrp-fleeca/utils.lua", 
    "hhrp-fleeca/client.lua"
}
server_scripts {
    "hhrp-fleeca/utils.lua", 
    "hhrp-fleeca/server.lua"
}

--hhrp-garbage
client_scripts {
    'hhrp-garbage/client.lua',
  }
  
  server_scripts {
    'hhrp-garbage/server.lua',
  }

--hhrp-grandmas
client_script 'hhrp-grandmas/client.lua'
server_script 'hhrp-grandmas/server.lua'

--hhrp-logs
server_script {
    'hhrp-logs/server.lua'
}
client_script {
    'hhrp-logs/client.lua'
}

--hhrp-mechanic
server_scripts {
    'hhrp-mechanic/server.lua',
}
client_scripts {

    'hhrp-mechanic/main.lua',

}

--hhrp-oxyruns
server_script "hhrp-oxyruns/server.lua"
client_script "hhrp-oxyruns/client.lua"

--hhrp-pawnshop
server_script 'hhrp-pawnshop/pawnshop_server.lua'
client_script 'hhrp-pawnshop/pawnshop_client.lua'

--hhrp-pizza
server_scripts {
    "hhrp-pizza/server.lua",
}

client_scripts {
    "hhrp-pizza/client.lua",
}

--hhrp-policefrisk
client_scripts {
	'hhrp-policefrisk/client.lua'
}

server_scripts {
    'hhrp-policefrisk/server.lua'
}

--hhrp-prone
client_scripts {
    'hhrp-prone/client.lua'
}

--hhrp-propattach
client_script 'hhrp-propattach/client.lua'

--hhrp-safebreach
client_scripts {
	"hhrp-safebreach/config.lua",
	"hhrp-safebreach/client/functions.lua",
	"hhrp-safebreach/client/main.lua"
}

server_scripts {
	"hhrp-safebreach/config.lua",
	"hhrp-safebreach/server/main.lua"
}

--hhrp-spawnveh
client_scripts {
    'hhrp-spawnveh/config.lua',
    'hhrp-spawnveh/client/client.lua',
 }

 --hhrp-states
 client_scripts {
    'hhrp-states/client.lua'
}

--hhrp-storerobbery
client_scripts {
	'hhrp-storerobbery/config.lua',
    'hhrp-storerobbery/client.lua'
}

server_scripts {
    'hhrp-storerobbery/config.lua',
	'hhrp-storerobbery/server.lua'
}

--hhrp-teleport
client_scripts {'hhrp-teleport/client.lua'}

--hhrp-trains
client_script 'hhrp-trains/client.lua'
server_script 'hhrp-trains/server.lua'

--lux_vehcontrol
client_script 'lux_vehcontrol/client.lua'
server_script 'lux_vehcontrol/server.lua'

--mythic_chairs
client_scripts {
	'mythic_chairs/config/config.lua',
	'mythic_chairs/config/chairs.lua',
	'mythic_chairs/client/main.lua'
}

server_scripts {
	'mythic_chairs/config/config.lua',
	'mythic_chairs/config/chairs.lua',
	'mythic_chairs/server/main.lua'
}

--PolyZone
client_scripts {
    'PolyZone/client.lua',
    'PolyZone/commands.lua',
    'PolyZone/creation.lua'
  }
  
  server_scripts {
    'PolyZone/server.lua'
  }

--shops
client_script{'shops/client.lua',
	'shops/gui.lua',
}

server_script 'shops/server.lua'