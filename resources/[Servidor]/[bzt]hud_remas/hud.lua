local sx,sy = guiGetScreenSize()
local px,py = 1600,900
local x,y =  (sx/px), (sy/py)	

	local noreloadweapons = {}
	noreloadweapons[17] = false
	noreloadweapons[19] = true
	noreloadweapons[39] = false
	noreloadweapons[41] = true
	noreloadweapons[42] = false

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
	meleespecialweapons[43] = true
	meleespecialweapons[44] = true
	meleespecialweapons[45] = true
	meleespecialweapons[46] = true	
	
function HUD ()

local oxigenio = getPedOxygenLevel ( getLocalPlayer() )
	if isElementInWater (getLocalPlayer()) then
	dxDrawRectangle(x*1288, y*163, x*134, y*19, tocolor(0, 0, 0, 255), false)--fundo preto
	dxDrawRectangle(x*1290, y*165, x*130, y*15, tocolor(86, 101, 120, 255), false)--fundo
	dxDrawRectangle(x*1290, y*165, x*130/1000*oxigenio, y*15, tocolor(172, 203, 241, 255), false)
	end

local vida = getElementHealth ( getLocalPlayer() ) + 0.40000152596
	if getPedStat ( getLocalPlayer(), 24 ) < 1000 then
	dxDrawRectangle(x*1288, y*113, x*134, y*19, tocolor(0, 0, 0, 255), false)--fundo preto
	dxDrawRectangle(x*1290, y*115, x*130, y*15, tocolor(90, 12, 14, 255), false)--fundo
	dxDrawRectangle(x*1290, y*115, x*130/100*vida, y*15, tocolor(255, 40, 49, 255), false)
	else
	dxDrawRectangle(x*1288, y*113, x*134, y*19, tocolor(0, 0, 0, 255), false)--fundo preto
	dxDrawRectangle(x*1290, y*115, x*130, y*15, tocolor(90, 12, 14, 255), false)--fundo
	dxDrawRectangle(x*1290, y*115, x*130/200*vida, y*15, tocolor(255, 40, 49, 255), false)
	end

local armour = getPedArmor ( getLocalPlayer() )
	if armour>0 then
	dxDrawRectangle(x*1288, y*138, x*134, y*19, tocolor(0, 0, 0, 255), false)--fundo preto
	dxDrawRectangle(x*1290, y*140, x*130, y*15, tocolor(112, 112, 112, 255), false) --fundo
	dxDrawRectangle(x*1290, y*140, x*130/100*armour, y*15, tocolor(255, 255, 255, 255), false)

	end

local altura = 190
local imageL, imageA = 30,30
local star01, star02, star03, star04, star05, star06 = 1500, 1460, 1415, 1370, 1325, 1280

local wanted = getPlayerWantedLevel (getLocalPlayer())
	if wanted == 1 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, "img/star.png") -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 02 --fundo
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 03 --fundo
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 04 --fundo
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end
	if wanted == 2 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, "img/star.png") -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, "img/star.png") -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 03 --fundo
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 04 --fundo
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end

	if wanted == 3 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, "img/star.png") -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, "img/star.png") -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, "img/star.png") -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 04 --fundo
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
 
	end
	
	if wanted == 4 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, "img/star.png") -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, "img/star.png") -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, "img/star.png") -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, "img/star.png") -- star 04
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 05 --fundo
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end

	if wanted == 5 then
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, "img/star.png") -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, "img/star.png") -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, "img/star.png") -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, "img/star.png") -- star 04
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, "img/star.png") -- star 05
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, "img/star.png", 0,0,0, tocolor(0, 0, 0, 150)) -- star 06 --fundo
	end
	if wanted == 6 then 
	dxDrawImage(x*star01, y*altura, x*imageL, y*imageA, "img/star.png") -- star 01
	dxDrawImage(x*star02, y*altura, x*imageL, y*imageA, "img/star.png") -- star 02
	dxDrawImage(x*star03, y*altura, x*imageL, y*imageA, "img/star.png") -- star 03
	dxDrawImage(x*star04, y*altura, x*imageL, y*imageA, "img/star.png") -- star 04
	dxDrawImage(x*star05, y*altura, x*imageL, y*imageA, "img/star.png") -- star 05
	dxDrawImage(x*star06, y*altura, x*imageL, y*imageA, "img/star.png") -- star 06
	end

local hour, mins = getTime ()
local time = hour .. ":" .. (((mins < 10) and "0"..mins) or mins)
	dxDrawBorderedText(time,x*1365, y*040, x*1358, y*40,tocolor(255,255,255,215),1.0,"pricedown","left","top",false,false,false)


local money = getPlayerMoney ( getLocalPlayer() )
	dxDrawBorderedText("$"..money,x*1365, y*075, x*1420, y*90,tocolor(111,174,84,255),1.0,"pricedown","right","top",false,false,false)
	

weapon = getPedWeapon ( getLocalPlayer() )
dxDrawImage(x*1440, y*039, x*120, y*120, "img/".. tostring( weapon ) ..".png")

local showammo1 = getPedAmmoInClip (localPlayer,getPedWeaponSlot(localPlayer))
local showammo2 = getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer)
local showammo3 = getPedTotalAmmo(getLocalPlayer())
	if noreloadweapons [getPedWeapon(getLocalPlayer())] then
		dxDrawText(tostring (showammo3),x*1200, y*100, x*1200, y*40,tocolor(255,255,255,255),0.55,"bankgothic","left","top",false, false,false)
	elseif meleespecialweapons [getPedWeapon(getLocalPlayer())] then
	else
		dxDrawBorderedText(tostring (showammo2).."-"..tostring (showammo1),x*1440, y*136, x*1540, y*40,tocolor(149,176,209,255),1.2,"default-bold","right","top",false,false,false)
	end
end
addEventHandler("onClientRender", getRootElement(), HUD)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

local hudTable = { "ammo", "armour", "clock", "health", "money", "weapon", "wanted", "area_name", "vehicle_name", "breath", "clock" }
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		for id, hudComponents in ipairs(hudTable) do
			showPlayerHudComponent(hudComponents, false)
		end
    end
)

addEventHandler("onClientResourceStop", resourceRoot,
function()
		for id, hudComponents in ipairs(hudTable) do
			showPlayerHudComponent(hudComponents, true)
		end
	end
)