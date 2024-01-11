fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_script {
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

files {
	"web-side/**/*"
}