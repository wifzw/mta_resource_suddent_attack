function collect()
	local count = collectgarbage("count")
	--outputDebugString ("game_veh_vinils count garbage "..count.."KB")
	if count > 300 then
		collectgarbage ("collect")
		local count2 = collectgarbage("count")
		outputDebugString ("hud_radar cleared "..count-count2.."KB")
	end
end
setTimer (collect, 1000*60*5, 0)


--- Sitemiz : https://sparrow-mta.blogspot.com/

--- Facebook : https://facebook.com/sparrowgta/
--- İnstagram : https://instagram.com/sparrowmta/
--- YouTube : https://youtube.com/c/SparroWMTA/

--- Discord : https://discord.gg/DzgEcvy