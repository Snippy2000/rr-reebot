resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description 'hhrp:Apartments'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server/main.lua",
	"config.lua",
}

client_scripts {
	"client/main.lua",
	"client/gui.lua",
	"config.lua",
}
exports {
    'imClosesToRoom3'
}