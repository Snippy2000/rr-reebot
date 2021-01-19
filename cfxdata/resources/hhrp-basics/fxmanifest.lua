fx_version 'adamant'
games { 'gta5' }

--3dme
client_script '3dme/client.lua'
server_script '3dme/@mysql-async/lib/MySQL.lua'
server_script '3dme/server.lua'

--heli
client_script 'heli/heli_client.lua'
server_script 'heli/heli_server.lua'

--lux_vehiclecontrol
client_script 'lux_vehiclecontrol/client.lua'
server_script 'lux_vehiclecontrol/server.lua'

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

server_script 'shopsserver.lua'

--ServerSync
client_scripts {
  'ServerSync/ss_shared_functions.lua',
  'ServerSync/config/Keybinds.lua',
  'ServerSync/config/ServerSync.lua',
  'ServerSync/ss_cli_traffic_crowd.lua',
  'ServerSync/ss_cli_weather.lua',
  'ServerSync/ss_cli_time.lua'
}

server_scripts {
  'ServerSync/ss_shared_functions.lua',
  'ServerSync/config/ServerSync.lua',
  'ServerSync/ss_srv_weather.lua',
  'ServerSync/ss_srv_time.lua'
}

--hhrp-cctv
client_scripts 'hhrp-cctv/client.lua'

--hhrp-assets
client_scripts {
  'hhrp-assets/client.lua',
  'hhrp-assets/client1.lua',
  'hhrp-assets/client2.lua'
}

server_scripts {
  'hhrp-assets/@mysql-async/lib/MySQL.lua',
  'hhrp-assets/server.lua',
  'hhrp-assets/binoserver.lua'
}

--hhrp-binoculars
client_script "hhrp-binoculars/binoculars.lua"
server_script "hhrp-binoculars/server.lua"

--hhrp-blips
client_scripts 'hhrp-blips/client.lua'

--hhrp-carry
client_script "hhrp-carry/cl_carry.lua"
server_script "hhrp-carry/sv_carry.lua"

--hhrp-chopshop
server_scripts {
	'hhrp-chopshop/@mysql-async/lib/MySQL.lua',
	'hhrp-chopshop/config.lua',
	'hhrp-chopshop/server/server.lua'
}

client_scripts {
	'hhrp-chopshop/config.lua',
	'hhrp-chopshop/client/client.lua'
}

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

--hhrp fleeca
client_scripts {
  "hhrp fleeca/utils.lua", 
  "hhrp fleeca/client.lua"
}
server_scripts {
  "hhrp fleeca/utils.lua", 
  "hhrp fleeca/server.lua"
}

--hhrp-garbage
client_scripts {
  'hhrp-garbage/client.lua',
}
server_scripts {
  'hhrp-garbage/server.lua',
}

--hhrp-GiveCarKeys
server_script {
	'hhrp-GiveCarKeys/@mysql-async/lib/MySQL.lua',
	'hhrp-GiveCarKeys/server/main.lua'
}

client_scripts {
	'hhrp-GiveCarKeys/client/main.lua'
}

--hhrp-grandmas
client_script 'hhrp-grandmas/client.lua'
server_script 'hhrp-grandmas/server.lua'

--hhrp-jewelrobbery
client_script {
  "hhrp-jewelrobbery/client.lua",
  "hhrp-jewelrobbery/config.lua"
}

server_script {
  'hhrp-jewelrobbery/@mysql-async/lib/MySQL.lua',
  "hhrp-jewelrobbery/server.lua",
  "hhrp-jewelrobbery/config.lua"
}

--hhrp-keys
client_scripts {
  'hhrp-keys/keys_c.lua',
}

server_scripts {
  'hhrp-keys/keys_s.lua',
  "hhrp-keys/@mysql-async/lib/MySQL.lua"
}

--hhrp-license
server_scripts {
	'hhrp-license/@async/async.lua',
	'hhrp-license/@mysql-async/lib/MySQL.lua',
	'hhrp-license/server/main.lua'
}

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

--hhrp-ping
client_scripts {
  'hhrp-ping/config.lua',
'hhrp-ping/client/main.lua',
}

server_scripts {
'hhrp-ping/@mysql-async/lib/MySQL.lua',
'hhrp-ping/server/main.lua',
}

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

--hhrp-rpchat
client_script 'hhrp-rpchat/client/main.lua'

server_scripts {

  'hhrp-rpchat/@mysql-async/lib/MySQL.lua',
  'hhrp-rpchat/server/main.lua'

}

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

--hhrp-scoreboard
client_scripts {
  'hhrp-scoreboard/cl_scoreboard.lua',
  'hhrp-scoreboard/warmenu.lua',
}

server_scripts {
  
  'hhrp-scoreboard/sv_scoreboard.lua',

}

--hhrp-securityheists
client_script 'hhrp-securityheists/client.lua'
client_script 'hhrp-securityheists/clientTowAI.lua'
server_script "hhrp-securityheists/server.lua"

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

--hhrp-vehdamage
server_scripts {
	'hhrp-vehdamage/@mysql-async/lib/MySQL.lua',
	'hhrp-vehdamage/server.lua',
}

client_scripts {
	'hhrp-vehdamage/client.lua',
}

--hhrp-WeedPlants
client_scripts {
	'hhrp-WeedPlants/config.lua',
  'hhrp-WeedPlants/utils.lua',
	'hhrp-WeedPlants/client.lua',
}

server_scripts {	
  'hhrp-WeedPlants/@mysql-async/lib/MySQL.lua',
	'hhrp-WeedPlants/config.lua',
  'hhrp-WeedPlants/utils.lua',
	'hhrp-WeedPlants/server.lua',
}