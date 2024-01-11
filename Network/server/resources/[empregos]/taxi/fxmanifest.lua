fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_scripts {
    "@vrp/lib/utils.lua",
    "@vrp/lib/Tunnel.lua",
    "@vrp/lib/Proxy.lua",
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}

