fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
shared_script "shared.lua"
client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'config.lua',
	'gumcore_luapi.lua',
	'server.lua',
}
server_exports {'gumAPI'}
