﻿
local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366,768
local x, y = (screenW/resW), (screenH/resH)
local components = { "area_name", "radio", "vehicle_name" }

local font = dxCreateFont('files/fonts/font.ttf', 10, false);
local font2 = dxCreateFont('files/fonts/font.ttf', 14, false);


function f_hud( ... )
    if (not isPlayerMapVisible()) then

--===========================================================================================================================================================

-------------------------------------------------------------[ Vida/Colete e Fome/Sede ]---------------	

	local Vida = math.floor ( getElementHealth ( localPlayer ) )
	local Colete = math.floor ( getPedArmor ( localPlayer ) )
	local fome = getElementData(getLocalPlayer(), "lyFome") or 0   ---{Função da FOME}
	local sede = getElementData(getLocalPlayer(), "lySede") or 0   ---{Função da SEDE}
	local oxigenio= getPedOxygenLevel (getLocalPlayer())		
	
	if fome > 0 then
		fome = math.floor ( fome )
	else
		fome = 0
	end
		if sede > 0 then
    	sede = math.floor ( sede )
	else
	    sede = 0
	end	

	dxDrawRectangle(x*1164, y*50, x*133, y*22, tocolor ( 189, 197, 195, 30 ) ) -- Preto1 atras do Colete
	dxDrawRectangle(x*1165, y*50, x*132, y*21, tocolor ( 189, 197, 195, 30 ) ) -- Preto2 atras da Colete
    dxDrawRectangle(x*1165, y*50, x*132/100*Colete, y*21, tocolor ( 129, 0, 172, 255 ) )



	dxDrawRectangle(x*1164, y*90, x*133, y*22, tocolor ( 0, 0, 0, 150 ) ) -- Preto1 atras da Vida
	dxDrawRectangle(x*1165, y*90, x*132, y*21, tocolor ( 0, 0, 0, 50 ) ) -- Preto2 atras da Vida
    dxDrawRectangle(x*1165, y*90, x*132/100*Vida, y*21, tocolor ( 49, 197, 195, 255 ) )
	
	dxDrawImage(x*1169, y*86, x*28, y*28, "files/img/hud_h.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)  --- Vida
	dxDrawImage(x*1169, y*47, x*28, y*28, "files/img/hud_co.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)	--- Colete

-------------------------------------------------------------[ Vida/Colete e Fome/Sede ]---------------		


-------------------------------------------------------------[ ARMAS ]---------------	
						
	
	local weaponClip = getPedAmmoInClip(getLocalPlayer(), getPedWeaponSlot(getLocalPlayer()))
	local weaponAmmo = getPedTotalAmmo(getLocalPlayer()) - getPedAmmoInClip(getLocalPlayer())
	local armaId = getPedWeapon(getLocalPlayer())
	local arma = getPedWeapon(getLocalPlayer())
	local noreloadweapons = {}
	noreloadweapons[16] = true
	noreloadweapons[17] = true
	noreloadweapons[18] = true
	noreloadweapons[19] = true
	noreloadweapons[25] = true
	noreloadweapons[33] = true
	noreloadweapons[34] = true
	noreloadweapons[35] = true
	noreloadweapons[36] = true
	noreloadweapons[37] = true
	noreloadweapons[38] = true
	noreloadweapons[39] = true
	noreloadweapons[41] = true
	noreloadweapons[42] = true
	noreloadweapons[43] = true
	local meleespecialweapons = {}
	meleespecialweapons[0] = true
	meleespecialweapons[1] = true
	meleespecialweapons[2] = true
	meleespecialweapons[3] = true
	meleespecialweapons[4] = true
	meleespecialweapons[5] = true
	meleespecialweapons[6] = true
	meleespecialweapons[7] = true
	meleespecialweapons[8] = true
	meleespecialweapons[9] = true
	meleespecialweapons[10] = true
	meleespecialweapons[11] = true
	meleespecialweapons[12] = true
	meleespecialweapons[13] = true
	meleespecialweapons[14] = true
	meleespecialweapons[15] = true
	meleespecialweapons[40] = true
	meleespecialweapons[44] = true
	meleespecialweapons[45] = true
	meleespecialweapons[46] = true

		dxDrawImage(x*1000, y*60, x*150, y*80, "files/img/"..tostring(arma)..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText("#FFFFFF"..weaponClip.." #FFFFFF/ #FFFFFF"..weaponAmmo, x*855, y*45, x*1366, y*178, tocolor(255, 255, 255, 255), x*1.10, "default-bold", "center", "center", false, false, false, true, false)
	
-------------------------------------------------------------[ ARMAS ]---------------			
		
-------------------------------------------------------------[ Dinheiro ]---------------	
	
        local money = convertNumber(getPlayerMoney(getLocalPlayer()))

        dxDrawText("$ "..money, x*1170, y*125, x*1366, y*720, tocolor(255, 255, 255, 230),  1.04, "default-bold", "left", "top", false, false, false, false, false)

-------------------------------------------------------------[ Dinheiro ]---------------		
end		
end


------------------------------------------------------------------------ [[ RETIRAR HUD ORIGINAL ]] ------------------------------------------------------------------------ 


function toggleF11()
	if isVisible then
		addEventHandler("onClientRender", root, f_hud)
	else
		removeEventHandler("onClientRender", root, f_hud)
    end
	isVisible = not isVisible
end
bindKey ("F11", "down", toggleF11)

function setHud()
    addEventHandler("onClientRender", getRootElement(), f_hud)
    setPlayerHudComponentVisible("armour", false)
    setPlayerHudComponentVisible("wanted", false)
    setPlayerHudComponentVisible("weapon", false)
    setPlayerHudComponentVisible("money", false)
    setPlayerHudComponentVisible("health", false)
    setPlayerHudComponentVisible("clock", false)
    setPlayerHudComponentVisible("breath", false)
    setPlayerHudComponentVisible("ammo", false)
    setPlayerHudComponentVisible("radar", false)

    for _, component in ipairs( components ) do
        setPlayerHudComponentVisible( component, false )
    end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), setHud)

function removeHud()
    setPlayerHudComponentVisible("armour", true)
    setPlayerHudComponentVisible("wanted", true)
    setPlayerHudComponentVisible("weapon", true)
    setPlayerHudComponentVisible("money", true)
    setPlayerHudComponentVisible("health", true)
    setPlayerHudComponentVisible("clock", true)
    setPlayerHudComponentVisible("breath", true)
    setPlayerHudComponentVisible("ammo", true)
    setPlayerHudComponentVisible("radar", true)
end
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), removeHud)

function convertNumber ( number )   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end

function getPedMaxHealth(ped)
	assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
	local stat = getPedStat(ped, 24)
	local maxhealth = 100 + (stat - 569) / 4.31
	return math.max(1, maxhealth)
end

function hideall(player)
	showPlayerHudComponent ( "ammo", false )
	showPlayerHudComponent ( "area_name", false )
	showPlayerHudComponent ( "armour", false )
	showPlayerHudComponent ( "breath", false )
	showPlayerHudComponent ( "clock", false )
	showPlayerHudComponent ( "health", false )
	showPlayerHudComponent ( "money", false )
	showPlayerHudComponent ( "vehicle_name", false )
	showPlayerHudComponent ( "weapon", false )
	showPlayerHudComponent ( "radio", false )
	showPlayerHudComponent ( "radar", false )
        showPlayerHudComponent ( "wanted", false )
end
addEventHandler ( "onClientResourceStart", getRootElement(), hideall )

function showall(player)
	showPlayerHudComponent ( "ammo", true )
	showPlayerHudComponent ( "area_name", true )
	showPlayerHudComponent ( "armour", true )
	showPlayerHudComponent ( "breath", true )
	showPlayerHudComponent ( "clock", true )
	showPlayerHudComponent ( "health", true )
	showPlayerHudComponent ( "money", true )
	showPlayerHudComponent ( "vehicle_name", true )
	showPlayerHudComponent ( "weapon", true )
	showPlayerHudComponent ( "radio", true )
	showPlayerHudComponent ( "radar", true )
        showPlayerHudComponent ( "wanted", false )
end
addEventHandler ( "onClientResourceStop", resourceRoot, showall )