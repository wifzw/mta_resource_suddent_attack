-- Türkçe Kaliteli Scriptin Adresi : https://sparrow-mta.blogspot.com
-- Her gün yeni script için sitemizi takip edin.
-- SparroW MTA İyi Oyunlar Diler...
-- Facebook : https://www.facebook.com/sparrowgta

-- MARKET --

function bekle(message)
   outputChatBox("Por favor, aguarde!", source, 223, 0, 0)
end
addEvent("bekleyin", true)
addEventHandler("bekleyin", getRootElement(), bekle)

function bekle(message)
   outputChatBox("Você não tem dinheiro suficiente", source, 223, 0, 0)
end
addEvent("ypara", true)
addEventHandler("ypara", getRootElement(), bekle)

--Can

function CanAl()
money = getPlayerMoney(source)
--if (money >= 5000) then
if (true) then
--outputChatBox("#ff0000Vida #ffffffComprado.", source, 190, 190, 190, true)
setElementHealth(source,200)
--takePlayerMoney(source, 5000)
else
outputChatBox("Para tirar a vida, você não tem dinheiro suficiente.", source, 0, 102, 255)
end
end
addEvent ("CanAl", true)
addEventHandler ("CanAl", getRootElement(), CanAl)

--Zırh

function ZirhAl()
money = getPlayerMoney(source)
--if (money >= 10000) then
if(true) then
--outputChatBox("#16B6E9Colete #ffffffComprado.", source, 190, 190, 190, true)
setPedArmor(source, 100)
--takePlayerMoney(source, 10000)
else
outputChatBox("#000000Você não tem dinheiro suficiente para comprar colete.", source, 0, 102, 255)
end
end
addEvent ("ZirhAl", true)
addEventHandler ("ZirhAl", getRootElement(), ZirhAl)

--Kas

function KasUygula()
if not (getElementModel(source) == 0) then
return outputChatBox("Você deve estar com o CJ", source, 0, 102, 255)
end
--outputChatBox("#000000Sobrancelha #ffffffVocê mudou seu nível.", source, 190, 190, 190, true)
setPedStat(source, 23, 999)
end
addEvent ("KasUygula", true)
addEventHandler ("KasUygula", getRootElement(), KasUygula)

--Kas Sil

function KasSil()
if not (getElementModel(source) == 0) then
return outputChatBox("Você deve estar com o CJ.", source, 0, 102, 255)
end
--outputChatBox("#00ff00Musculoso ON", source, 190, 190, 190, true)
setPedStat(source, 23, 1)
end
addEvent ("KasSil", true)
addEventHandler ("KasSil", getRootElement(), KasSil)

-- SILAHLAR --
do
	addEvent("onPlayerRequestWeaponSkill", true)
	addEvent("onPlayerRequestWeapon", true)
end


--Silah Satın Alındı

local weapons = {
	[22] = "Pistola",
	[23] = "Arma silenciada",
	[24] = "Deagle",
	[25] = "Shotgun",
	[26] = "Sawn Off",
	[27] = "Combat Shotgun",
	[28] = "Uzi",
	[29] = "MP5",
	[32] = "Tec-9",
	[30] = "AK-47",
	[31] = "M4",
	[34] = "Sniper"
}


addEventHandler("onPlayerRequestWeapon", root,
function (thePrice, weaponID, ammo)
	if (thePrice and weaponID and ammo) then
		local money = getPlayerMoney(source)
		local thePrice = tonumber(thePrice)
		--if (money >= thePrice) then
		if(true) then
			--outputChatBox ("#000000"..thePrice.."$ #ffffffKarşılığında #999999"..(weapons[weaponID] or "").." #ffffffSatın Aldın.", source, 250, 0, 0, true)
			giveWeapon(source, tonumber(weaponID), tonumber(ammo), true)
			--takePlayerMoney(source, thePrice)
		elseif (money < thePrice) then
			outputChatBox((weapons[weaponID] or "").." Você não tem dinheiro suficiente para comprar.", source, 0, 102, 255, true)
		end
	end
end
)

--Silah Yeteneği
addEvent("YetenekleriDoldur", true)
addEventHandler("YetenekleriDoldur",root,function()
para = getPlayerMoney(source)
--if (para >= 25000) then
if(true) then
--outputChatBox("#00000025000$ #ffffffVocê preencheu todas as habilidades.",source,255,255,255,true)
setPedStat(source,69,1000)
setPedStat(source,71,1000)
setPedStat(source,72,1000)
setPedStat(source,73,1000)
setPedStat(source,74,1000)
setPedStat(source,75,1000)
setPedStat(source,76,1000)
setPedStat(source,77,1000)
setPedStat(source,78,1000)
setPedStat(source,79,1000)
--takePlayerMoney(source,25000)
else
outputChatBox("Você não tem dinheiro suficiente para preencher todas as suas habilidades.", source, 0, 102, 255, true)
end
end)

-- AÇMA KAPAMA --
bindKey = get("bindKey")
addEventHandler("onResourceStart", resourceRoot, function()
setElementData(resourceRoot, "bindKey", bindKey)
end)