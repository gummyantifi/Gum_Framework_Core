fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
shared_script "server/shared.lua"
client_scripts {
	'cfg/config.lua',
	'client/client.lua',
}

server_scripts {
	'cfg/config.lua',
	'server/gumcore_luapi.lua',
	'server/server.lua',
}
server_exports {'gumAPI'}
