function getFont (font, side)
	if font == 'medium' then
		return dxCreateFont('files/fonts/medium.ttf', side)
	elseif font == 'regular' then
		return dxCreateFont('files/fonts/regular.ttf', side)
	end
end

function getSound (sound)
	if sound == 'click' then
		return playSound('files/sounds/click.ogg')
	elseif sound == 'click2' then
		return playSound('files/sounds/click2.ogg')
	end
end



-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy