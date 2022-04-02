fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

exports {
	'DisplayLeftNotification',
	'DisplayLocationNotification',
}
client_scripts {
  'client.js',
  'client.lua',
}

server_scripts {
  'server.lua',
}
ui_page 'html/index.html'

files {
    'html/index.js',
    'html/index.css',
    'html/index.html',
    'html/crock.ttf',
    'html/images/*.png',
}
