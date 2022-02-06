-- Türkçe Kaliteli Scriptin Adresi : https://sparrow-mta.blogspot.com
-- Her gün yeni script için sitemizi takip edin.
-- SparroW MTA İyi Oyunlar Diler...
-- Facebook : https://www.facebook.com/sparrowgta

-- PANEL ORTALAMA --

sGenislik,sUzunluk = guiGetScreenSize()
Genislik,Uzunluk = 590,420
X = (sGenislik/2) - (Genislik/2)
Y = (sUzunluk/2) - (Uzunluk/2)

-- PANEL --

panel = guiCreateWindow(X, Y, Genislik, Uzunluk, " Painel de Armas ", false)
guiSetVisible(panel, false)

-- MARKET --

--Can

can_Resim = guiCreateStaticImage(470, 25, 80, 80, "silahlar/can.png", false, panel)

canal_buton = guiCreateButton(450, 110, 120, 25, "Vida", false, panel)
guiSetFont(canal_buton, "default-bold-small")



--Zırh

zirh_Resim = guiCreateStaticImage(470, 140, 80, 80, "silahlar/zirh.png", false, panel)

zirh_buton = guiCreateButton(450, 230, 120, 25, "Colete", false, panel)
guiSetFont(zirh_buton, "default-bold-small")

--Kas

kas_Resim = guiCreateStaticImage(470, 260, 80, 80, "silahlar/kas.png", false, panel)

kas_buton = guiCreateButton(450, 350, 120, 25, "Musculoso On", false, panel)
guiSetFont(kas_buton, "default-bold-small")

kassil_buton = guiCreateButton(450, 385, 120, 25, "Musculoso Off", false, panel)
guiSetFont(kassil_buton, "default-bold-small")

-- SILAHLAR --

--Tabanca
Pistol_Resim = guiCreateStaticImage(35, 25, 80, 80, "silahlar/pistol.png", false, panel)

Pistol_Al = guiCreateButton(15, 110, 120, 25, "Pistola", false, panel)
guiSetFont(Pistol_Al, "default-bold-small")

--Susturuculu Pistol
Susturuculu_Resim = guiCreateStaticImage(180, 25, 80, 80, "silahlar/susturuculu.png", false, panel)

Susturuculu_Pistol = guiCreateButton(160, 110, 120, 25, "Pistola Silenciada", false, panel)
guiSetFont(Susturuculu_Pistol, "default-bold-small")

--Deagle

Deagle_Resim = guiCreateStaticImage(325, 25, 80, 80, "silahlar/deagle.png", false, panel)

Deagle_Al = guiCreateButton(305, 110, 120, 25, "Deagle", false, panel)
guiSetFont(Deagle_Al, "default-bold-small")

--Uzi

--uzi_Resim = guiCreateStaticImage(35, 140, 80, 80, "silahlar/uzi.png", false, panel)

--Uzi_Al = guiCreateButton(15, 230, 120, 25, "Satın Al | 3.000$", false, panel)
--guiSetFont(Uzi_Al, "default-bold-small")

--MP5

mp5_Resim = guiCreateStaticImage(180, 140, 80, 80, "silahlar/mp5.png", false, panel)

MP5_Al = guiCreateButton(160, 230, 120, 25, "MP5", false, panel)
guiSetFont(MP5_Al, "default-bold-small")

--TEC-9

tec9_Resim = guiCreateStaticImage(325, 140, 80, 80, "silahlar/tec9.png", false, panel)

TEC9_Al = guiCreateButton(305, 230, 120, 25, "TEC-9", false, panel)
guiSetFont(TEC9_Al, "default-bold-small")

--AK47

ak47_Resim = guiCreateStaticImage(35, 260, 80, 80, "silahlar/ak47.png", false, panel)

AK47_Al = guiCreateButton(15, 350, 120, 25, "AK-47", false, panel)
guiSetFont(AK47_Al, "default-bold-small")

--M4

m4_Resim = guiCreateStaticImage(180, 260, 80, 80, "silahlar/m4.png", false, panel)

M4_Al = guiCreateButton(160, 350, 120, 25, "M4-16", false, panel)
guiSetFont(M4_Al, "default-bold-small")

--Sniper

sniper_Resim = guiCreateStaticImage(325, 260, 80, 80, "silahlar/sniper.png", false, panel)

Sniper_Al = guiCreateButton(305, 350, 120, 25, "Sniper", false, panel)
guiSetFont(Sniper_Al, "default-bold-small")

Yetenekler = guiCreateButton(15, 385, 410, 25, "Habilidades no máximo", false, panel)
guiSetFont(Yetenekler, "default-bold-small")

-- AYARLAR --

send = nil
local sure = 0

send1 = nil
local sure1 = 0

addEventHandler("onClientGUIClick", getRootElement(),
function ()
if source == canal_buton then
    --if getPlayerMoney(source) >= 5000 then
	  if (true) then
        if send == false or send == nil then
            send = true
            triggerServerEvent("CanAl", localPlayer)
            guiSetEnabled(canal_buton, false)
            zaman1 = nil
            zaman2 = nil
            suren = sure*0
            addEventHandler("onClientRender", root, function()
            if not zaman1 then
               zaman1 = getTickCount ()
            end
            zaman2 = getTickCount ()
            local zamanlama = tostring(math.floor((suren - (zaman2 - zaman1))/1000))
            guiSetText( canal_buton, ""..zamanlama.." Aguarde segundos..." )
			guiSetAlpha(canal_buton, 0.5)
               if tonumber(zamanlama) <= 0 then
                  guiSetText(canal_buton, "Vida")
				  guiSetAlpha(canal_buton, 1)
                  guiSetEnabled(canal_buton, true)
                  send = false
               end
            end)
         else
            triggerServerEvent("bekleyin", localPlayer)
         end
    else
        triggerServerEvent("ypara", localPlayer)
	end
elseif source == zirh_buton then
    --if getPlayerMoney(source) >= 10000 then
	  if (true) then
        if send1 == false or send1 == nil then
            send1 = true
            triggerServerEvent("ZirhAl", localPlayer)
            guiSetEnabled(zirh_buton, false)
            zaman11 = nil
            zaman21 = nil
            suren1 = sure1*1000
            addEventHandler("onClientRender", root, function()
            if not zaman11 then
               zaman11 = getTickCount ()
            end
            zaman21 = getTickCount ()
            local zamanlama1 = tostring(math.floor((suren1 - (zaman21 - zaman11))/1000))
            guiSetText( zirh_buton, ""..zamanlama1.." Aguarde segundos..." )
			guiSetAlpha(zirh_buton, 0.5)
               if tonumber(zamanlama1) <= 0 then
                  guiSetText(zirh_buton, "Colete")
				  guiSetAlpha(zirh_buton, 1)
                  guiSetEnabled(zirh_buton, true)
                  send1 = false
               end
            end)
         else
            triggerServerEvent("bekleyin", localPlayer)
         end
    else
        triggerServerEvent("ypara", localPlayer)
    end
elseif source == kas_buton then
triggerServerEvent("KasUygula", localPlayer)
elseif source == kassil_buton then
triggerServerEvent("KasSil", localPlayer)
elseif source == Yetenekler then
triggerServerEvent("YetenekleriDoldur", localPlayer)
end
end)

function buyWeapon()
local money = getPlayerMoney(player)
local player = localPlayer
		if (source == Pistol_Al) then  -- Buy: Pistol
			local priceWeapon_Pistol = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_Pistol, 22, 100)			
		elseif (source == Susturuculu_Pistol) then	-- Buy: Silenced pistol
			local priceWeapon_SilencedPistol = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_SilencedPistol, 23, 100)	
		elseif (source == Deagle_Al) then  -- Buy: Desert eagle
			local priceWeapon_DesertEagle = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_DesertEagle, 24, 100)
		elseif (source == Shotgun_Al) then  -- Buy: Shotgun
			local priceWeapon_Shotgun = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_Shotgun, 25, 100)
		
		elseif (source == Sawnoff_Al) then  -- Buy: Sawn-off
			local priceWeapon_SawnOff = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_SawnOff, 26, 100)

		elseif (source ==  SPAZ12_Al) then  -- Buy: SPAZ-12
			local priceWeapon_SPAZ12 = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_SPAZ12, 27, 100)

		--elseif (source == Uzi_Al) then  -- Buy: Micro Uzi
			--local priceWeapon_Uzi = 3000
			--triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_Uzi, 28, 100)

		elseif (source == MP5_Al) then  -- Buy: MP5
			local priceWeapon_MP5 = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_MP5, 29, 100)

		elseif (source == TEC9_Al) then  -- Buy: TEC-9
			local priceWeapon_TEC9 = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_TEC9, 32, 100)

		elseif (source == AK47_Al) then  -- Buy: AK-47
			local priceWeapon_AK47 = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_AK47, 30, 100)

		elseif (source == M4_Al) then  -- Buy: M4
			local priceWeapon_M4 = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_M4, 31, 100)

		elseif (source == Sniper_Al) then  -- Buy: Sniper
			local priceWeapon_Sniper = 0
			triggerServerEvent("onPlayerRequestWeapon", player, priceWeapon_Sniper, 34, 100)
		end
end
addEventHandler("onClientGUIClick", root, buyWeapon)


-- LAZER --
lazeregit = guiCreateButton(X+600, Y, 25, Uzunluk, ">", false)
guiSetVisible(lazeregit, false)

marketdon = guiCreateButton(X-35, Y, 25, Uzunluk, "<", false)
guiSetVisible(marketdon, false)

GUIEditor = {
    checkbox = {},
    button = {},
}

local dots = {} 
picklasercolor = 0
laserWidth = 2 -- dx line
dotSize	= .05	-- sizee
localPlayer = getLocalPlayer()
oldcolors = {r=255,g=0,b=0,a=255}

addEventHandler("onClientResourceStart", getRootElement(), function(res)
	if res == getThisResource() then
		SetLaserEnabled(localPlayer, false)
		SetLaserColor(localPlayer, oldcolors.r,oldcolors.g,oldcolors.b,oldcolors.a)
		
		if colorPickerInitialized == 0 then 
			initColorPicker()			
		end
		
	elseif res == getResourceFromName("colorpicker") then
		if colorPickerInitialized == 0 then 
			initColorPicker()
		end
	end
end )
addEventHandler("onClientResourceStop", getRootElement(), function(res)
	if res == getThisResource() then
		SetLaserEnabled(localPlayer, false)		
	end
end )

addEventHandler("onClientResourceStop", getRootElement(), function(res)
	if res == getThisResource() then
		SetLaserEnabled(localPlayer, false)		
	end
end )

GUIEditor = {
    checkbox = {},
    button = {},
}

local player = localPlayer

function shopInterface()
	lazerpanel = guiCreateWindow(X, Y, Genislik, Uzunluk, " Lazer Panel ", false)
	guiSetVisible(lazerpanel, false)

	mavi1png = guiCreateStaticImage(125, 100, 60, 60, "lazer/mavi1.png", false, lazerpanel)
	GUIEditor.checkbox[1] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, mavi1png)
	guiSetProperty(GUIEditor.checkbox[1], "NormalTextColour", "FF0005FF")
--
	sari1png = guiCreateStaticImage(195, 100, 60, 60, "lazer/sari1.png", false, lazerpanel)
	GUIEditor.checkbox[2] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, sari1png)
	guiSetProperty(GUIEditor.checkbox[2], "NormalTextColour", "FFFFF600")
--
	yesil1png = guiCreateStaticImage(265, 100, 60, 60, "lazer/yesil1.png", false, lazerpanel)
	GUIEditor.checkbox[3] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, yesil1png)
	guiSetProperty(GUIEditor.checkbox[3], "NormalTextColour", "FF41FF00")
--
	kirmizi1png = guiCreateStaticImage(335, 100, 60, 60, "lazer/kirmizi1.png", false, lazerpanel)
	GUIEditor.checkbox[4] = guiCreateCheckBox(-18, 0, 999, 999, "", true, false, kirmizi1png)
	guiSetProperty(GUIEditor.checkbox[4], "NormalTextColour", "FFFF0000")
--
	cyan1png = guiCreateStaticImage(405,  100, 60, 60, "lazer/cyan1.png", false, lazerpanel)
	GUIEditor.checkbox[5] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, cyan1png)
	guiSetProperty(GUIEditor.checkbox[5], "NormalTextColour", "FF00FFFB")
--
	pembe1png = guiCreateStaticImage(125, 170, 60, 60, "lazer/pembe1.png", false, lazerpanel)
	GUIEditor.checkbox[6] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, pembe1png)
	guiSetProperty(GUIEditor.checkbox[6], "NormalTextColour", "FFFF00FC")
--
	turuncu1png = guiCreateStaticImage(195, 170, 60, 60, "lazer/turuncu1.png", false, lazerpanel)
	GUIEditor.checkbox[7] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, turuncu1png)
	guiSetProperty(GUIEditor.checkbox[7], "NormalTextColour", "FFFF3C00")
--
	mavi2png = guiCreateStaticImage(265, 170, 60, 60, "lazer/mavi2.png", false, lazerpanel)
	GUIEditor.checkbox[8] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, mavi2png)
	guiSetProperty(GUIEditor.checkbox[8], "NormalTextColour", "FF1E4F56")
--
	pembe3png = guiCreateStaticImage(335, 170, 60, 60, "lazer/pembe3.png", false, lazerpanel)
	GUIEditor.checkbox[9] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, pembe3png)
	guiSetProperty(GUIEditor.checkbox[9], "NormalTextColour", "FFA94DE9")
--
	mor1png = guiCreateStaticImage(405, 170, 60, 60, "lazer/mor1.png", false, lazerpanel)
	GUIEditor.checkbox[10] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, mor1png)
	guiSetProperty(GUIEditor.checkbox[10], "NormalTextColour", "FF4C07E4")
--
	bordo1png = guiCreateStaticImage(125, 240, 60, 60, "lazer/bordo1.png", false, lazerpanel)
	GUIEditor.checkbox[11] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, bordo1png)
	guiSetProperty(GUIEditor.checkbox[11], "NormalTextColour", "FFAE000000")
--
	siyah1png = guiCreateStaticImage(195, 240, 60, 60, "lazer/siyah1.png", false, lazerpanel)
	GUIEditor.checkbox[12] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, siyah1png)
	guiSetProperty(GUIEditor.checkbox[12], "NormalTextColour", "FF000000")
--
	beyaz1png = guiCreateStaticImage(265, 240, 60, 60, "lazer/beyaz1.png", false, lazerpanel)
	GUIEditor.checkbox[13] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, beyaz1png)
	guiSetProperty(GUIEditor.checkbox[13], "NormalTextColour", "FFFFFFFF")
--
	gri1png = guiCreateStaticImage(335, 240, 60, 60, "lazer/gri1.png", false, lazerpanel)
	GUIEditor.checkbox[14] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, gri1png)
	guiSetProperty(GUIEditor.checkbox[14], "NormalTextColour", "FF404040")
--
	koyuyesil1png = guiCreateStaticImage(405, 240, 60, 60, "lazer/koyuyesil1.png", false, lazerpanel)
	GUIEditor.checkbox[15] = guiCreateCheckBox(-18, 0, 999, 999, "", false, false, koyuyesil1png)
	guiSetProperty(GUIEditor.checkbox[15], "NormalTextColour", "FF005900")
	
	GUIEditor.button[1] = guiCreateButton(195, 320, 200, 30, "Lazeri Aç", false, lazerpanel)
	guiSetFont(GUIEditor.button[1], "default-bold-small")
	addEventHandler("onClientGUIClick", GUIEditor.button[1], lazerackapa, false)
end
addEventHandler("onClientResourceStart", resourceRoot, shopInterface)

function lazerackapa( )
	ToggleLaserEnabled()
end

addEventHandler("onClientMouseEnter",root,
	function ( )
		for k,v in ipairs(getElementsByType("gui-checkbox",resourceRoot)) do
			if source == v then
				playSoundFrontEnd(3)
			end
		end
	end
)

addEventHandler("onClientGUIClick", getResourceGUIElement(getThisResource()), function(buttonN,state)
    if(buttonN == "left" and state == "up") and getElementType(source) == "gui-checkbox" then
		if IsLaserEnabled(localPlayer) == false then
			return
		end
		for i = 1,#GUIEditor.checkbox do
			if GUIEditor.checkbox[i] ~= source then
				guiCheckBoxSetSelected(GUIEditor.checkbox[i],false)
			end	
		end	
        if ( guiCheckBoxGetSelected(source) ) then
			local GetColor = guiGetProperty(source, "NormalTextColour")
			if GetColor then
				local hex = '#'..GetColor
				hex = hex:gsub("#","")
				local r,g,b = tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)), tonumber("0x"..hex:sub(7,8))
				playSoundFrontEnd(1)
				ChangeLaserColor(cmd, r,g,b,255)
			end	
		end
	end
end
)

addEventHandler("onClientElementDataChange", localPlayer,
	function(dataName, oldValue)
		if getElementType(source) == "player" and source == localPlayer and dataName == "laser.on" then
			local newValue = getElementData(source, dataName)
			if oldValue == true and newValue == false then
				unbindKey("aim_weapon", "both", AimKeyPressed)
			elseif oldValue == false and newValue == true then
				bindKey("aim_weapon", "both", AimKeyPressed)		
			end
		end
	end
)

addEventHandler( "onClientRender",  getRootElement(),
	function()
		local players = getElementsByType("player")
		for k,v in ipairs(players) do
			if getElementData(v, "laser.on") then
				DrawLaser(v)
			end
		end
	end
)
addEventHandler( "onClientPreRender",  getRootElement(),
	function()
		local players = getElementsByType("player")
		for k,v in ipairs(players) do
			if getElementData(v, "laser.on") then
				--DrawLaser(v)
			end
		end
	end
)

function AimKeyPressed(key, state) 
	if state == "down" then
		setElementData(localPlayer, "laser.aim", true, true)
	elseif state == "up" then
		setElementData(localPlayer, "laser.aim", false, true)
	end
end

function DrawLaser(player)
	if getElementData(player, "laser.on") then
		local targetself = getPedTarget(player)
		if targetself and targetself == player then
			targetself = true
		else
			targetself = false
		end		
		
		if getElementData(player, "laser.aim") and IsPlayerWeaponValidForLaser(player) == true and targetself == false then
			local x,y,z = getPedWeaponMuzzlePosition(player)
			if not x then
				outputDebugString("getPedWeaponMuzzlePosition failed")
				x,y,z = getPedTargetStart(player)
			end
			local x2,y2,z2 = getPedTargetEnd(player)
			if not x2 then
				--outputDebugString("getPedTargetEnd failed")
				return
			end			
			local x3,y3,z3 = getPedTargetCollision(player)
			local r,g,b,a = GetLaserColor(player)
			if x3 then -- collision detected, draw til collision and add a dot
				dxDrawLine3D(x,y,z,x3,y3,z3, tocolor(r,g,b,a), laserWidth)
				DrawLaserDot(player, x3,y3,z3)
			else
				dxDrawLine3D(x,y,z,x2,y2,z2, tocolor(r,g,b,a), laserWidth)
				DestroyLaserDot(player)
			end
		else
			DestroyLaserDot(player) 
		end
	else
		DestroyLaserDot(player)
	end
end
function DrawLaserDot (player, x,y,z)
	if not dots[player] then
		dots[player] = createMarker(x,y,z, "corona", .05, GetLaserColor(player))
	else
		setElementPosition(dots[player], x,y,z)
	end
end
function DestroyLaserDot(player)
	if dots[player] and isElement(dots[player]) then
		destroyElement(dots[player])
		dots[player] = nil
	end
end

function SetLaserColor(player,r,g,b,a)
	setElementData(player, "laser.red", r)
	setElementData(player, "laser.green", g)
	setElementData(player, "laser.blue", b)
	setElementData(player, "laser.alpha", a)
	return true
end
function GetLaserColor(player)
	r = getElementData(player, "laser.red")
	g = getElementData(player, "laser.green")
	b = getElementData(player, "laser.blue")
	a = getElementData(player, "laser.alpha")

	return r,g,b,a
end
function IsPlayerWeaponValidForLaser(player) 
	local weapon = getPedWeapon(player)
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 then
		return true
	end
	return false
end

function SetLaserEnabled(player, state) 
	if not player or isElement(player) == false then return false end
	if getElementType(player) ~= "player" then return false end
	if state == nil then return false end
	
	if state == true then -- enable laser
		setElementData(player, "laser.on", true, true)
		setElementData(player, "laser.aim", false, true)
		--bindKey("aim_weapon", "both", AimKeyPressed)   -- done in onClientElementDataChange
		return true
	elseif state == false then -- disable laser
		setElementData(player, "laser.on", false, true)
		setElementData(player, "laser.aim", false, true)
		--unbindKey("aim_weapon", "both", AimKeyPressed)   -- done in onClientElementDataChange
		return true
	end
	return false
end
function IsLaserEnabled(player) -- returns true or false based on player elementdata "laser.on"
	if getElementData(player, "laser.on") == true then
		return true
	else
		return false
	end
end

function ToggleLaserEnabled(cmd)
	local text = ''
	player = localPlayer
	if IsLaserEnabled(player) == false then	
		SetLaserEnabled(player, true)
		outputChatBox("#aabbccLazer #00ff00açıldı.", 255, 255, 255, true)
		text = 'Lazeri Kapat'
	else
		SetLaserEnabled(player, false)
		outputChatBox("#aabbccLazer #ff0000kapatıldı.", 255, 255, 255, true)
		text = 'Lazeri Aç'
	end
	guiSetText(GUIEditor.button[1],text)
end

function ChangeLaserColor(cmd, r,g,b,a)
	local player = localPlayer
	if colorPickerInitialized == 1 and getResourceFromName("colorpicker") then
		oldcolors.r, oldcolors.g, oldcolors.b, oldcolors.a = GetLaserColor(player)
		picklasercolor = 1
		if exports.colorpicker:requestPickColor(true,true,"Choose Laser Color",oldcolors.r,oldcolors.g,oldcolors.b,oldcolors.a) == false then
			exports.colorpicker:cancelPickColor()
			return false
		end
		return true
	else
		if r and g and b and a then
			r,g,b,a = tonumber(r), tonumber(g), tonumber(b), tonumber(a)
			if r and g and b and a then
				if r < 0 or g < 0 or b < 0 or a < 0 or r > 255 or g > 255 or b > 255 or a > 255 then
					outputChatBox("Cor Invalida: (0-255) usage: /" ..CMD_LASERCOLOR.. " r g b a", 245,0,0)
					return false
				else
					outputChatBox("Lazer rengi değiştirildi.",r,g,b)
					SetLaserColor(player,r,g,b,a)
					return true
				end
			end
		end	
	end
	return false
end
addCommandHandler("", ToggleLaserEnabled)
addCommandHandler("", ChangeLaserColor)

function initColorPicker()
	if getResourceFromName("colorpicker") == false then
		return false
	end
	
	addEventHandler("onClientPickedColor", localPlayer, function(r,g,b,a)
		if picklasercolor == 1 then
			SetLaserColor(source,r,g,b,a)
		end		
	end	)
	
	addEventHandler("onClientCancelColorPick", localPlayer, function()
		if picklasercolor == 1 then
			SetLaserColor(source,oldcolors.r,oldcolors.g,oldcolors.b,oldcolors.a)
			picklasercolor = 0
		end
	end )
	
	colorPickerInitialized = 1
	return true
end	
	

addEventHandler("onClientGUIClick", root,
function()
if source == lazeregit then
guiSetVisible(panel, false)
guiSetVisible(lazeregit, false)
guiSetVisible(lazerpanel, true)
guiSetVisible(marketdon, true)
end
end)

addEventHandler("onClientGUIClick", root,
function()
if source == marketdon then
guiSetVisible(panel, true)
guiSetVisible(lazeregit, true)
guiSetVisible(lazerpanel, false)
guiSetVisible(marketdon, false)
end
end)

-- AÇMA KAPAMA --
bindKey(tostring(getElementData(resourceRoot, "bindKey")), "down", 
function()
guiSetVisible(panel, not guiGetVisible(panel))
guiSetVisible(lazeregit, not guiGetVisible(lazeregit))
showCursor(guiGetVisible(panel))
end
)

function ackapat()
if (guiGetVisible (lazerpanel) == true) then
guiSetVisible(lazerpanel, false)
guiSetVisible(marketdon, false)
guiSetVisible(panel, false)
guiSetVisible(lazeregit, false)
showCursor(false)
end
end
bindKey("F3", "down", ackapat)
