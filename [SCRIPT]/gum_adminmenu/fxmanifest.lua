fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

files {
  'config.lua'
}

client_scripts {
  'cfg/config.lua',
  'client/client.lua',
  'assets/js/client.js'
}

server_scripts {
  'cfg/config.lua',
  'server/server.lua',
}
