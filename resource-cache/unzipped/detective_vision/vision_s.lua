function theHand()
	for i,player in ipairs(getElementsByType("player")) do
	local plweap = getPedWeapon(player,11)
		if plweap == 45 or plweap == 44 then
		takeWeapon(player,plweap)
		giveWeapon(player,plweap)
		end
	end
end

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),function()
local mtaVersion = tonumber(string.sub(getVersion()["mta"],1,3))
	if mtaVersion < 1.1 then
	theHand()
	end
end)
