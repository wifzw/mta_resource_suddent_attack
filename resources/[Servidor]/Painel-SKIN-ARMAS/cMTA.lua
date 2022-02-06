--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--
	


local screenW, screenH = guiGetScreenSize()
local resW, resH = 1360,768
local x, y = (screenW/resW), (screenH/resH)

local vehiclesWithPaintjob = {}
local objectsWithSticker = {}

local dxfont0_fonte = dxCreateFont("Arquivos/fonte.ttf", 10)

Button = "F2" --- PANEL TUŞU

grid_Skin = dxGrid:Create(screenW * 0.5952, screenH * 0.4661, screenW * 0.1786, screenH * 0.2969)
colum_1 = grid_Skin:AddColumn("ARMAS", 220) --- LİSTE
grid_Skin:SetVisible(false)

grid_Skin:AddItem(colum_1, "AK-47 (Skin 1)" ,false,false) --- SKINS
grid_Skin:AddItem(colum_1, "AK-47 (Skin 2)" ,false,false)
grid_Skin:AddItem(colum_1, "AK-47 (Skin 3)" ,false,false)

grid_Skin:AddItem(colum_1, "M4 (Skin 1)" ,false,false)
grid_Skin:AddItem(colum_1, "M4 (Skin 2)" ,false,false)
grid_Skin:AddItem(colum_1, "M4 (Skin 3)" ,false,false)

--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--

function Skins_Armas ()

        dxDrawRectangle(screenW * 0.5878, screenH * 0.4128, screenW * 0.1933, screenH * 0.4453, tocolor(0, 0, 0, 140), false)
        dxDrawRectangle(screenW * 0.5878, screenH * 0.4128, screenW * 0.1933, screenH * 0.0352, tocolor(0, 0, 0, 140), false)
        dxDrawRectangle(screenW * 0.5878, screenH * 0.4479, screenW * 0.1933, screenH * 0.0052, tocolor(90, 135, 228, 255), false)
        dxDrawText("Skins de armas", screenW * 0.5878, screenH * 0.4128, screenW * 0.7811, screenH * 0.4479, tocolor(255, 255, 255, 255), 1.00, dxfont0_fonte, "center", "center", false, false, false, false, false)
        dxDrawImage(screenW * 0.5988, screenH * 0.7734, screenW * 0.1713, screenH * 0.0352, "Arquivos/botao.png", 0, 0, 0, corBotaoAtivar, false)
		corBotaoAtivar = tocolor(0, 0, 0, 140)   
        if cursorPosition(screenW * 0.5988, screenH * 0.7734, screenW * 0.1713, screenH * 0.0352) then
        corBotaoAtivar = tocolor(67, 181 , 129, 255) --- 0,0, 255
end
        dxDrawImage(screenW * 0.5988, screenH * 0.8164, screenW * 0.1713, screenH * 0.0352, "Arquivos/botao.png", 0, 0, 0, corBotaoDesativar, false)
		corBotaoDesativar = tocolor(0, 0, 0, 140)   
        if cursorPosition(screenW * 0.5988, screenH * 0.8164, screenW * 0.1713, screenH * 0.0352) then
        corBotaoDesativar = tocolor(219, 68 , 68, 255)
end
        dxDrawText("Ativar", screenW * 0.5988, screenH * 0.7734, screenW * 0.7701, screenH * 0.8086, tocolor(255, 255, 255, 255), 1.00, dxfont0_fonte, "center", "center", false, false, false, false, false)
        dxDrawText("Desativar", screenW * 0.5988, screenH * 0.8164, screenW * 0.7701, screenH * 0.8516, tocolor(255, 255, 255, 255), 1.00, dxfont0_fonte, "center", "center", false, false, false, false, false)
	   
   	    
end

--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--

function openDx ()
if(getElementData(localPlayer, "FM_PermissaoSkinsArmas")) == true then
  if not isEventHandlerAdded("onClientRender", getRootElement(), Skins_Armas) then
     addEventHandler ( "onClientRender" , root , Skins_Armas)
     showCursor(true)
	 grid_Skin:SetVisible(true)
	 else
	 removeEventHandler ("onClientRender" , root , Skins_Armas)
	 showCursor(false)
	 grid_Skin:SetVisible(false)
    end
	end 
end
bindKey(Button, "down", openDx)

--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--

function ativarSkins (_,state)
    if isEventHandlerAdded("onClientRender", root, Skins_Armas) then  
        if state == "down" then
            if cursorPosition(screenW * 0.5988, screenH * 0.7734, screenW * 0.1713, screenH * 0.0352) then
            local gridItem = grid_Skin:GetSelectedItem()
            local Skin_Selecionado = grid_Skin:GetItemDetails(colum_1, gridItem, 1) or nil
            if Skin_Selecionado == nil then
            return	
            end		
			
			if Skin_Selecionado == "AK-47 (Skin 1)" then
			setElementData(localPlayer, "weaponshaderid", "ak1")
			setElementData(localPlayer, "weaponshadername", "ak")
			triggerServerEvent("FM_Ak_1", localPlayer)	
			end 
			
			if Skin_Selecionado == "AK-47 (Skin 2)" then
			setElementData(localPlayer, "weaponshaderid", "ak2")
			setElementData(localPlayer, "weaponshadername", "ak")
			triggerServerEvent("FM_Ak_2", localPlayer)		
			end 
			
			if Skin_Selecionado == "AK-47 (Skin 3)" then
			setElementData(localPlayer, "weaponshaderid", "ak3")
			setElementData(localPlayer, "weaponshadername", "ak")
			triggerServerEvent("FM_Ak_3", localPlayer)		
			end 
			
			if Skin_Selecionado == "M4 (Skin 1)" then
			setElementData(localPlayer, "weaponshaderid", "m41")
			setElementData(localPlayer, "weaponshadername", "m4")
			triggerServerEvent("FM_M4_1", localPlayer)
			end 
			
			if Skin_Selecionado == "M4 (Skin 2)" then
			setElementData(localPlayer, "weaponshaderid", "m42")
			setElementData(localPlayer, "weaponshadername", "m4")
			triggerServerEvent("FM_M4_2", localPlayer)
			end 
			
			if Skin_Selecionado == "M4 (Skin 3)" then
			setElementData(localPlayer, "weaponshaderid", "m43")
			setElementData(localPlayer, "weaponshadername", "m4")
			triggerServerEvent("FM_M4_3", localPlayer)
			end 
			
            end
        end
    end
end
addEventHandler("onClientClick", root, ativarSkins)

--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--

function desativarSkins (_,state)
    if isEventHandlerAdded("onClientRender", root, Skins_Armas) then  
        if state == "down" then
            if cursorPosition(screenW * 0.5988, screenH * 0.8164, screenW * 0.1713, screenH * 0.0352) then
            local gridItem = grid_Skin:GetSelectedItem()
            local Skin_Selecionado = grid_Skin:GetItemDetails(colum_1, gridItem, 1) or nil
            if Skin_Selecionado == nil then
            return
            end		
			
			setElementData(localPlayer, "weaponshaderid", 0)
			setElementData(localPlayer, "weaponshadername", 0)	
            triggerServerEvent("FM_RemoveSkin", localPlayer)		
					
			
            end
        end
    end
end
addEventHandler("onClientClick", root, desativarSkins)


addEventHandler("onClientResourceStart", resourceRoot, function()
	for k, v in ipairs(getElementsByType("player")) do
		local weaponShaderName = getElementData(v, "weaponshadername") or 0
		local weaponShaderID = getElementData(v, "weaponshaderid") or 0
		
		if weaponShaderName ~= 0 and weaponShaderID ~= 0 then
			setWeaponStickerC(v, weaponShaderName, weaponShaderID)
		end
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "player" then
		local weaponShaderName = getElementData(localPlayer, "weaponshadername") or 0
		local weaponShaderID = getElementData(localPlayer, "weaponshaderid") or 0
		
		if weaponShaderName ~= 0 and weaponShaderID ~= 0 then
			setWeaponStickerC(source, isVehicleHavePaintjob)
		end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "player" then
		local weaponShaderName = getElementData(localPlayer, "weaponshadername") or 0
		local weaponShaderID = getElementData(localPlayer, "weaponshaderid") or 0
		
		if weaponShaderName ~= 0 and weaponShaderID ~= 0 then
			removeWeaponStickerC(source)
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "player" then
		local weaponShaderName = getElementData(localPlayer, "weaponshadername") or 0
		local weaponShaderID = getElementData(localPlayer, "weaponshaderid") or 0
		
		if weaponShaderName ~= 0 and weaponShaderID ~= 0 then
			removeWeaponStickerC(source)
		end
	end
end)

--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--

function setWeaponStickerC(localPlayer, shaderName, shaderID)
	if shaderName and shaderID then
		
		removeWeaponStickerC(localPlayer)
			
		vehiclesWithPaintjob[localPlayer] = {}
		vehiclesWithPaintjob[localPlayer][1] = dxCreateShader("texturechanger.fx", 0, 100, false, "ped")
		vehiclesWithPaintjob[localPlayer][2] = dxCreateTexture("Arquivos/" .. shaderID .. ".png")
			
		if vehiclesWithPaintjob[localPlayer][1] and vehiclesWithPaintjob[localPlayer][2] then
			dxSetShaderValue(vehiclesWithPaintjob[localPlayer][1], "TEXTURE", vehiclesWithPaintjob[localPlayer][2])
			engineApplyShaderToWorldTexture(vehiclesWithPaintjob[localPlayer][1], "*" .. shaderName .. "*", localPlayer)
		else
			
		end
	end
end
addEvent("setWeaponStickerC",true)
addEventHandler("setWeaponStickerC", getRootElement(), setWeaponStickerC)

--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--
		  
function setObjectPaintjobC(objectElement, shaderName, shaderID)
	if shaderName and shaderID then
		objectsWithSticker[objectElement] = {}
		objectsWithSticker[objectElement][1] = dxCreateShader("texturechanger.fx", 0, 100, false, "object")
		objectsWithSticker[objectElement][2] = dxCreateTexture("Arquivos/" .. shaderID .. ".png")
		if objectsWithSticker[objectElement][1] and objectsWithSticker[objectElement][2] then
			dxSetShaderValue(objectsWithSticker[objectElement][1], "TEXTURE", objectsWithSticker[objectElement][2])
			engineApplyShaderToWorldTexture(objectsWithSticker[objectElement][1], "*" .. shaderName .. "*", objectElement)
		end
	end
end
addEvent("setObjectPaintjobC",true)
addEventHandler("setObjectPaintjobC", getRootElement(), setObjectPaintjobC)

function removeStickerFromObjectC(object)
	if object then
		if objectsWithSticker[object] then
			destroyElement(objectsWithSticker[object][1])
			destroyElement(objectsWithSticker[object][2])
			objectsWithSticker[object] = nil
		end
	end
end
addEvent("removeStickerFromObjectC",true)
addEventHandler("removeStickerFromObjectC", getRootElement(), removeStickerFromObjectC)

function removeWeaponStickerC(localPlayer)
	if localPlayer then
		if vehiclesWithPaintjob[localPlayer] then
			destroyElement(vehiclesWithPaintjob[localPlayer][1])
			destroyElement(vehiclesWithPaintjob[localPlayer][2])
			vehiclesWithPaintjob[localPlayer] = nil
		end
	end
end
addEvent("removeWeaponStickerC",true)
addEventHandler("removeWeaponStickerC", getRootElement(), removeWeaponStickerC)

function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end

	return false
end