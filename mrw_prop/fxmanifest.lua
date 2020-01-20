fx_version 'adamant'
games 'gta5'
description 'Mrw_Prop'

author 'Morow'

client_script '@warmenu/warmenu.lua'

client_scripts {

  'client.lua'
}


server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server.lua'
}
