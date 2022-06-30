fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
exports {
	'loading',
}
client_scripts {
	'cfg/config.lua',
	'cfg/full_database.lua',
	'client/client.lua',
}

server_scripts {
	'cfg/full_database.lua',
}
ui_page 'html/index.html'

files {
	'html/index.html',
    'html/assets/js/*.js',
    'html/assets/css/*.css',
    'html/assets/fonts/crock.ttf',
    'html/assets/fonts/kaola.ttf',
    'html/assets/fonts/text.ttf',
	'html/assets/img/*.png',
}}
