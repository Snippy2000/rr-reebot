fx_version "adamant"
game "gta5"

name "mumble-voip"
description "A tokovoip replacement that uses fivems mumble voip"
author "Frazzle (frazzle9999@gmail.com)"
version "1.3"

ui_page "ui/index.html"

files {
	"ui/index.html",
	"ui/on.wav",
	"ui/off.wav",
}

shared_scripts {
	"config.lua",
	"grid.lua",
}

client_scripts {
	"client.lua",
}

server_scripts {
	"server.lua",
}

provide "tokovoip_script"