

-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy

local screenW, screenH = guiGetScreenSize()
local resW, resH = 1360,768
local x, y = (screenW/resW), (screenH/resH) 
 
local dxfont0_fonte = dxCreateFont("files/fonts/font.ttf", 15)
local dxfont1_fonte = dxCreateFont("files/fonts/font.ttf", 11)
local dxfont2_fonte = dxCreateFont("files/fonts/font.ttf", 10) 

function dxVelo ()
        
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then 
	    local seat = getPedOccupiedVehicleSeat(localPlayer)

	    if (seat ~= 0)then
		return
        end 
		
		local speedX, speedY, speedZ = getElementVelocity ( vehicle  )
		local actualSpeed = (speedX^2 + speedY^2 + speedZ^2)^(0.5) 
	    local KMH = math.floor(actualSpeed*180)	
		if ( getElementHealth( vehicle ) >= 1000 ) then
		vehiclehealth = 100
		else
		--vehiclehealth = math.floor(getElementHealth ( vehicle )/10)
		end
	
	    local fuel = math.floor(getElementData(vehicle,"veh:fuel") or 0)

        --dxDrawImage(screenW * 0.1171, screenH * 0.1901, screenW * 0.8755, screenH * 0.8216, "Arquivos/fundo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        
		if(getVehicleEngineState(vehicle) == true) then	
		dxDrawImage(screenW * 0.9463, screenH * 0.8346, screenW * 0.0235, screenH * 0.0326, "files/img/motor.png", 0, 0, 0, tocolor(0, 255, 150, 255), false)
		else 
		dxDrawImage(screenW * 0.9463, screenH * 0.8346, screenW * 0.0235, screenH * 0.0326, "files/img/motor.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end 
       
	    if(isVehicleLocked(vehicle) == true) then
		dxDrawImage(screenW * 0.9596, screenH * 0.8724, screenW * 0.0176, screenH * 0.0286,"files/img/cadiado.png", 0, 0, 0, tocolor(0, 255, 150, 255), false)
		else 
		dxDrawImage(screenW * 0.9596, screenH * 0.8724, screenW * 0.0176, screenH * 0.0286, "files/img/cadiado.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end 
		
        --dxDrawText(""..KMH.." KM/H", screenW * 0.8280, screenH * 0.8216, screenW * 0.9436, screenH * 0.8594, tocolor(0, 255, 150, 255), 1.00, dxfont0_fonte, "center", "center", false, false, false, false, false)
        --dxDrawText(""..vehiclehealth.."%", screenW * 0.8580, screenH * 0.8646, screenW * 0.9100, screenH * 0.8854, tocolor(87, 87, 87, 255), 1.00, dxfont1_fonte, "center", "center", false, false, false, false, false)
        
		if(getVehicleOverrideLights(vehicle) == 2) then	
	   dxDrawImage(screenW * 0.9390, screenH * 0.8724, screenW * 0.0176, screenH * 0.0286, "files/img/luz.png", 0, 0, 0, tocolor(0, 255, 150, 255), false)
		else 
		dxDrawImage(screenW * 0.9390, screenH * 0.8724, screenW * 0.0176, screenH * 0.0286, "files/img/luz.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end 
		
        --dxDrawRectangle(screenW * 0.8393, screenH * 0.9407, screenW * 0.0864/100*fuel, screenH * 0.0183, tocolor(0, 255, 150, 255), false)
        --dxDrawImage(screenW * 0.8433, screenH * 0.9410, screenW * 0.0110, screenH * 0.0169, "Arquivos/gasolina.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        --dxDrawText(""..fuel.."%", screenW * 0.9004, screenH * 0.9416, screenW * 0.9209, screenH * 0.9596, tocolor(255, 255, 255, 200), 1.00, dxfont2_fonte, "left", "center", false, false, false, false, false)

        end 
end
addEventHandler("onClientRender", root, dxVelo)




-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy