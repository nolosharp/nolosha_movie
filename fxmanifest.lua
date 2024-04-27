fx_version 'cerulean'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Aimebap'
description 'Job de Journaliste'
version '1.0.0'

-- Définir les fichiers côté client
client_scripts {
    'client.lua' -- Votre script client
}

-- Définir les fichiers côté serveur
server_scripts {
    'server.lua' -- Votre script serveur
}

-- Si vous avez des fichiers d'interface utilisateur (HTML/CSS/JS)
ui_page 'ui.html'

files {
    'ui.html',
}