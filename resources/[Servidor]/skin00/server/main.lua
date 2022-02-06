function setPlayerSkin2(thePlayer, commandName, skin)
	if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Admin")) then
			if getElementModel(thePlayer) == skin then
				outputChatBox(error .. "O Jogador Ja Possui Esta Skin!", thePlayer, 255, 255, 255, true)
				return
			end
			setElementModel(thePlayer, skin)
			outputChatBox("A Skin Foi Alterada Com Exitô", thePlayer, 255, 255, 255, true)
			
	end
end
addCommandHandler("setskin", setPlayerSkin2, false, false)