resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Identity'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@hhrp-core/locale.lua',
	'server/main.lua'
}

client_scripts {
	'@hhrp-core/locale.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css'
}

dependency 'hhrp-core'

fx_version 'adamant'
games { 'gta5' }