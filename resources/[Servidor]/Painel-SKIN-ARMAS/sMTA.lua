--[[      © Creditos do script: #Mods MTA:SA

	      © Creditos da pagina postadora: DropMTA
	
	      © Discord DropMTA: https://discord.gg/GZ8DzrmxUV
	
	      Acesse nosso site de mods: https://dropmta.blogspot.com/            ]]--


Grupo = { "Everyone"  }  -- ACL grupo
 
function FM_2020 ( thePlayer )
    local account = getPlayerAccount ( thePlayer )
    local inGroup = false
    for _, group in ipairs ( Grupo ) do
        if isObjectInACLGroup ( "user.".. getAccountName ( account ), aclGetGroup ( group ) ) then
            inGroup = true
            break
        end
    end
    return inGroup
end 

function permissaoSkins()
for i, player in pairs (getElementsByType("player")) do

if FM_2020 ( player ) then
setElementData(player, "FM_PermissaoSkinsArmas" , true)
else 
setElementData(player, "FM_PermissaoSkinsArmas" , false)
end 
end 
end 
setTimer(permissaoSkins, 50, 0) 


function setStickerOnWeapon(player,shader,image)
	triggerClientEvent(getRootElement(), "setWeaponStickerC", getRootElement(), player, shader, image)
end

function Ak_1 ()
setStickerOnWeapon(source , "ak", "ak1")		
end 
addEvent("FM_Ak_1", true)
addEventHandler("FM_Ak_1", getRootElement(), Ak_1)

function Ak_2 ()
setStickerOnWeapon(source , "ak", "ak2")		
end 
addEvent("FM_Ak_2", true)
addEventHandler("FM_Ak_2", getRootElement(), Ak_2)

function Ak_3 ()
setStickerOnWeapon(source , "ak", "ak3")		
end 
addEvent("FM_Ak_3", true)
addEventHandler("FM_Ak_3", getRootElement(), Ak_3)

function M4_1 ()
setStickerOnWeapon(source , "m4", "m41")		
end 
addEvent("FM_M4_1", true)
addEventHandler("FM_M4_1", getRootElement(), M4_1)

function M4_2 ()
setStickerOnWeapon(source , "m4", "m42")		
end 
addEvent("FM_M4_2", true)
addEventHandler("FM_M4_2", getRootElement(), M4_2)

function M4_3 ()
setStickerOnWeapon(source , "m4", "m43")		
end 
addEvent("FM_M4_3", true)
addEventHandler("FM_M4_3", getRootElement(), M4_3)

function removeWeaponStickers(player)
	triggerClientEvent(getRootElement(), "removeWeaponStickerC", getRootElement(), player)
end

function RemoveSkin ()
removeWeaponStickers(source)	
end 
addEvent("FM_RemoveSkin", true)
addEventHandler("FM_RemoveSkin", getRootElement(), RemoveSkin)

function setObjectPaintjob(object,shader,image)
	triggerClientEvent(getRootElement(), "setObjectPaintjobC", getRootElement(), object, shader, image)
end
addEvent("setObjectPaintjob", true)
addEventHandler("setObjectPaintjob", getRootElement(), setObjectPaintjob)

function removeStickerFromObject(object)
	triggerClientEvent(getRootElement(), "removeStickerFromObjectC", getRootElement(), object)
end