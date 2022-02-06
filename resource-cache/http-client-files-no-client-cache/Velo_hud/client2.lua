
-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy


local screenW,screenH = guiGetScreenSize()
local resW,resH = 1366,768
local x,y =  (screenW/resW), (screenH/resH)

local font = dxCreateFont("files/fonts/font.ttf", 10)
local MaxFuel = 100

function getVehicleFuel(v)
	local fuel = getElementData(v, "fuel")	
	if (fuel) then
		return fuel
	end
	return 0
end
function onPlayerRequestHUD()
	local asd = getPedOccupiedVehicle(localPlayer)
	local seat = getPedOccupiedVehicleSeat(localPlayer)

	if (seat ~= 0) then
		return
	end

	if not	(asd) then
		return
	else
		local fuel = getVehicleFuel(asd)
		   dxDrawText(""..math.floor(fuel).."%", screenW * 0.9478, screenH * 0.9128, screenW * 0.9743, screenH * 0.9388, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "top", false, false, false, false, false)
		  -- dxDrawImage(screenW * 0.7463, screenH * -0.0586, screenW * 0.3647, screenH * 0.3477, "files/img/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
end
addEventHandler("onClientRender", root, onPlayerRequestHUD)

function dxDrawRecLine(x,y,w,h,color)
    dxDrawRectangle(x,y,w,1,color) -- h
	dxDrawRectangle(x,y+h-1,w,1,color) -- h
	dxDrawRectangle(x,y,1,h,color) -- v
	dxDrawRectangle(x+w-1,y,1,h,color) -- v
end



-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy