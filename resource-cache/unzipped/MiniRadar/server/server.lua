--=============================================================================================[Script by HAYZEN]=====================================================================================================--

function startWork(key)
	if (key == 'XCCD') then
		triggerClientEvent(client, 'youCanWork', resourceRoot, 'XCCDplanet')
	end
end
addEvent('canIwork', true)
addEventHandler('canIwork', resourceRoot, startWork)

function renewRadarBorder(playersTable, state)
	triggerClientEvent(playersTable, "renewRadarBorder", resourceRoot, state)
end

function update (event)
	triggerClientEvent (root, "updateData", resourceRoot, getPlayerCount(), getMaxPlayers())
end
addEventHandler ("onPlayerJoin", root, update)
addEventHandler ("onPlayerQuit", root, update)

addEventHandler ("onResourceStart", resourceRoot, function()
	setTimer(function()
		triggerClientEvent (root, "updateData", resourceRoot, getPlayerCount(), getMaxPlayers())
	end, 50, 1)
end)

--====================================================================================================================================================================================================================--



--- Sitemiz : https://sparrow-mta.blogspot.com/

--- Facebook : https://facebook.com/sparrowgta/
--- İnstagram : https://instagram.com/sparrowmta/
--- YouTube : https://youtube.com/c/SparroWMTA/

--- Discord : https://discord.gg/DzgEcvy