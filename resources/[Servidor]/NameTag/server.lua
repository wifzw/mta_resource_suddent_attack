function setCargo(player)
	if player then
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Console")) then
			setElementData(player, "NameTag:Processo", "       #6d6d6d[ #d10430Proprietário do servidor #6d6d6d] #ffffff")
		elseif  isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Moderator")) then
			setElementData(player, "NameTag:Processo", "   #E9E316[ #7f051fModerador #E9E316] #ffffff")
		elseif  isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then
			setElementData(player, "NameTag:Processo", "             #E98C16[ #FF0000Admin #6d6d6d] #E98C16")
		else
			setElementData(player, "NameTag:Processo", "   #6d6d6d[ #7f051fPlayer #6d6d6d] #ffffff")
		end
	end
end

setTimer(
function()
	for i, pl in pairs(getElementsByType("player")) do
		if pl ~= (false or nil) then
			setCargo(pl)
		end
	end
end,3000,0)

-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy