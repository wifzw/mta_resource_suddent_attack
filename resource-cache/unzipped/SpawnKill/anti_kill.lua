-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy

local anti_spawn_kill = { }
addEventHandler( "onClientPlayerSpawn", root, 
function( hisTeam )
if anti_spawn_kill[ source ] then return end
if source ~= localPlayer then
anti_spawn_kill[ source ] = true
setTimer( doDisableAntiSpawnKill, 20000, 1, source )
setElementAlpha( source, 100 )
else
toggleControl( "fire", false )
toggleControl( "aim_weapon", false )
triggerEvent( "clientMsgBox", source, "" )
setTimer( toggleControl, 20000, 1, "fire", true )
setTimer( toggleControl, 20000, 1, "aim_weapon", true )
setTimer( triggerEvent, 20000, 1, "clientMsgBox", source, "" )
anti_spawn_kill[ source ] = true
setTimer( doDisableAntiSpawnKill, 20000, 1, source )
setElementAlpha( source, 100 )
end
end)

function doDisableAntiSpawnKill( plr, bool )
anti_spawn_kill[ plr ] = nil
setElementAlpha( plr, 255 )
end

addEventHandler( "onClientPlayerDamage", root, 
function( attacker, weapon, bodypart, loss )
if anti_spawn_kill[ source ] and anti_spawn_kill[ source ] == true then
cancelEvent( )
end
end)

-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy