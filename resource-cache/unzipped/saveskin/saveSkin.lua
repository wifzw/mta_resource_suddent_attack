--[[

	+++ This script was created by DANFOR +++
	
	+++ This script can save the skin player at the time of death or exit from the game +++
	
	+++ Don't change anything unless you know what you're doing +++
	
	+++ This script sets the skin player when the player logs in and you can't
	set it to set the skin when the player enters because the skin is stored in
	the player account. +++
	
]]--

--------------------

--/\ When the player dies, save his skin and spawn him /\--

function onWasted()
	local playerSkinToSave = getElementModel(source)
	setElementData(source, "skin", playerSkinToSave)
	spawnPlayer(source, 0, 0, 0, 0, 0)
	fadeCamera(source, true)
	setCameraTarget(source, source)
end
addEventHandler("onPlayerWasted", root, onWasted)

--------------------

--/\ When the player is spawn, set his skin /\--

function onSpawn()
	local playerSkinToSet = getElementData(source, "skin")
	if playerSkinToSet then
		setElementModel(source, playerSkinToSet)
	end
end
addEventHandler("onPlayerSpawn", root, onSpawn)

--------------------

--/\ when the player quited the game, save his skin on his account /\--

function onQuit()
	local playeraccount = getPlayerAccount ( source )
	local playerSkinToSaveOnAccount = getElementModel(source)
	setAccountData(playeraccount, "skinToSetOnLogin", playerSkinToSaveOnAccount)
end
addEventHandler("onPlayerQuit", root, onQuit)

--------------------

--/\ when the player joined the game, spawn him /\--

function onJoin()
	spawnPlayer(source, 0, 0, 0, 0, 0)
	fadeCamera(source, true)
	setCameraTarget(source, source)
end
addEventHandler("onPlayerJoin", root, onJoin)

---------------

--/\ when the player logged in, get his skin from his account, then set his skin /\--

function onLogin()
	local playeraccount = getPlayerAccount ( source )
	local playerSkinToSetOnLogin = getAccountData(playeraccount, "skinToSetOnLogin")
	if playerSkinToSetOnLogin then
		spawnPlayer(source, 0, 0, 0, 0, playerSkinToSetOnLogin)
		fadeCamera(source, true)
		setCameraTarget(source, source)
	else
		spawnPlayer(source, 0, 0, 0, 0, 0)
		fadeCamera(source, true)
		setCameraTarget(source, source)
	end
end
addEventHandler("onPlayerLogin", root, onLogin)