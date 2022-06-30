fx_version 'adamant'

game 'rdr3'

lua54 'yes'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


client_scripts {
  'cfg/config.lua',
  'client/client.lua',
}

server_scripts {
  'cfg/config.lua',
  'server/server.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/assets/js/*.js',
    'html/assets/css/*.css',
    'html/assets/fonts/crock.ttf',
    'html/assets/fonts/kaola.ttf',
    'html/assets/fonts/new-.ttf',
    'html/assets/fonts/new.ttf',
    'html/assets/images/*.png',
}
