fx_version 'cerulean'
game 'gta5'

author 'dariobico20'
description 'Full Housing Script with Real Estate Job, House Shells, and Decoration System'
version '1.0.0'

escrow_ignore {
	'stream/*',
	'config.lua',
}

shared_scripts {
	'shared/config.lua',
}

server_scripts {
	'server/main.lua',
	'server/jobs.lua',
	'server/database.lua',
}

client_scripts {
	'client/main.lua',
	'client/ui.lua',
}