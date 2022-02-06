function setCargo(player)
	if player then
		if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Console")) then
			setElementData(player, "NameTag:İslem", "       #6d6d6d[ #d10430Sunucu Sahibi #6d6d6d] #ffffff")
		elseif  isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Kurucu")) then
			setElementData(player, "NameTag:İslem", "   #6d6d6d[ #7f051fSunucu Kurucusu #6d6d6d] #ffffff") 
		elseif  isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("YardımcıKurucu")) then
			setElementData(player, "NameTag:İslem", "   #6d6d6d[ #3f6aafYardımcı Kurucu #6d6d6d] #ffffff")
		elseif  isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then
			setElementData(player, "NameTag:İslem", "             #6d6d6d[ #FF0000Admin #6d6d6d] #ffffff")
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