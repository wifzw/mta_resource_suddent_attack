function outputJoinquitMessage(player, msg, r, g, b, pos, time)
	triggerClientEvent(player, "sendServerMessage", player, msg, r, g, b, pos, time)
end

addEventHandler("onPlayerLogin", root, function()
	outputJoinquitMessage(root, "#FFFFFF"..getPlayerName(source).." #FFFFFFLogou.", 255, 100, 100, false, 5)
end)


addEventHandler('onPlayerQuit', root, function(quitType)
	outputJoinquitMessage(root, "#FFFFFF"..getPlayerName(source).." #FFFFFFSaiu do Servidor. ("..quitType..").", 255, 100, 100, false, 5)
	end
)

function onJoinquitWasted(ammo, killer, killerWeapon, bodypart)
	if (killer) and (getElementType(killer) == "player") then
	if bodypart == 9 then  -- Headshot
	outputJoinquitMessage(root, "#FFFFFF"..getPlayerName(killer).." #FFFFFFMorto por : "..getPlayerName(source).." #FFFFFF| Arma: ("..getWeaponNameFromID(killerWeapon)..") - (Headshot)", 255, 100, 100, false, 5)
	else
	outputJoinquitMessage(root, "#FFFFFF"..getPlayerName(killer).." #FFFFFFMorto por : "..getPlayerName(source).." #FFFFFF| Arma: ("..getWeaponNameFromID(killerWeapon)..")", 255, 100, 100, false, 5)
	end
	else
	outputJoinquitMessage(root, "#FFFFFF"..getPlayerName(source).. " #FFFFFFCometeu suicídio.", 255, 100, 100, false, 5)
	end
end
addEventHandler("onPlayerWasted", root, onJoinquitWasted)