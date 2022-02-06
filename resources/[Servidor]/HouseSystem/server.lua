local handler
local dbpTime = 500 
local max_player_houses = 2
local sellhouse_value = 80
local open_key = "F9"
blip = {}

addEvent("onHouseSystemHouseCreate", true)
addEvent("onHouseSystemHouseLock", true)
addEvent("onHouseSystemHouseDeposit", true)
addEvent("onHouseSystemHouseWithdraw", true)
addEvent("onHouseSystemWeaponDeposit", true)
addEvent("onHouseSystemWeaponWithdraw", true)
addEvent("onHouseSystemRentableSwitch", true)
addEvent("onHouseSystemRentalprice", true)
addEvent("onHouseSystemTenandRemove", true)
addEvent("onHouseSystemInfoBuy", true)
addEvent("onHouseSystemInfoRent", true)
addEvent("onHouseSystemInfoEnter", true)

local saveableValues = {
	["MONEY"] = "MONEY",
	["WEAP1"] = "WEAP1",
	["WEAP2"] = "WEAP2",
	["WEAP3"] = "WEAP3",
	["LOCKED"] = "LOCKED",
	["OWNER"] = "OWNER",
	["DONO"] = "DONO",
	["RENTABLE"] = "RENTABLE",
	["RENTALPRICE"] = "RENTALPRICE",
	["RENT1"] = "RENT1",
	["RENT2"] = "RENT2",
	["RENT3"] = "RENT3",
	["RENT4"] = "RENT4",
	["RENT5"] = "RENT5",
}

local created = false 
local houseid = 0 

local house = {} 
local houseData = {} 
local houseInt = {}
local houseIntData = {}

local buildStartTick
local buildEndTick

local rentTimer

addEventHandler("onResourceStop", getResourceRootElement(), function()
	for index, houses in pairs(house) do
		houses = nil
	end
	for index, houseDatas in pairs(houseData) do
		houseDatas = nil
	end
	for index, houseInts in pairs(houseInt) do
		houseInts = nil
	end
	for index, houseIntDatas in pairs(houseIntData) do
		houseIntDatas = nil
	end
	houseid = 0
	created = false
end)

--------------
-- COMMANDS --
--------------
-- /unrent --
addCommandHandler("unrent", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local id = tonumber(getElementData(thePlayer, "house:lastvisit"))
		if(isPlayerRentedHouse(thePlayer, id) == false) then
			outputChatBox("Você não é morador dessa casa!", thePlayer, 255, 0, 0)
			return
		end
		local sucess = removeHouseTenand(id, thePlayer)
		if(sucess == true) then
			outputChatBox("Você nao é mais morador dessa casa!", thePlayer, 0, 255, 0)
		else
			outputChatBox("Ocorreu um erro!", thePlayer, 255, 0, 0)
		end
	end
end)

-- /rent --
addCommandHandler("rent", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local id = tonumber(getElementData(thePlayer, "house:lastvisit"))
		  if isGuestAccount( getPlayerAccount( thePlayer )) then
             outputChatBox( '* Você precisa estar logado para alugar essa casa!', thePlayer, 255, 51, 36 ) return end
		if(houseData[id]["DONO"] == getAccountName(getPlayerAccount(thePlayer))) then
			outputChatBox("Você não pode alugar aqui! É a sua casa!", thePlayer, 255, 0, 0)
			return
		end
		if(tonumber(houseData[id]["RENTABLE"]) ~= 1) then
			outputChatBox("Essa casa não está em aluguel!", thePlayer, 255, 0, 0)
			return
		end
		--if(getPlayerRentedHouse(thePlayer) ~= false) then
		--	outputChatBox("Você ja alugou está casa! Use /unrent.", thePlayer, 255, 0, 0)
		--	return
		--end
		local sucess = addHouseTenand(thePlayer, id)
		if(sucess == true) then
			outputChatBox("Você é o novo morador dessa casa!", thePlayer, 0, 255, 0)
		else
			outputChatBox("Você não pode alugar esta casa!", thePlayer, 255, 0, 0)
		end
	end
end)

addEventHandler( 'onResourceStart', resourceRoot, function()
handler = dbConnect("sqlite", "Casas.db")
dbExec( handler, "CREATE TABLE IF NOT EXISTS houses (ID INTEGER PRIMARY KEY AUTOINCREMENT, X REAL, Y REAL, Z REAL, INTERIOR INTEGER( 10 ), INTX REAL, INTY REAL, INTZ REAL, MONEY INTEGER( 20 ), WEAP1 VARCHAR( 45 ), WEAP2 VARCHAR( 45 ), WEAP3 VARCHAR( 45 ), LOCKED INTEGER( 2 ), PRICE INTEGER( 10 ), OWNER VARCHAR( 32 ) , DONO VARCHAR( 32 ), RENTABLE INTEGER( 2 ), RENTALPRICE INTEGER( 10 ), RENT1 VARCHAR( 32 ), RENT2 VARCHAR( 32 ), RENT3 VARCHAR( 32 ), RENT4 VARCHAR( 32 ), RENT5 VARCHAR( 32 ))")
housesys_startup()
--[[
for index, houseDatas in pairs(houseData) do
local owner = houseDatas["DONO"]
for i, v in ipairs( getElementsByType( 'player' ) ) do
if owner == getAccountName( getPlayerAccount(v)) then
blip[v] = createBlip( 0, 0, 0, 32, 0, 0, 0, 255 )
setBlipVisibleDistance(blip[v], 7000)
attachElements (blip[v],houseDatas["PICKUP"])
setElementVisibleTo ( blip[v], source, true )
end
end
end]]
end )

-- /createhouse --
addCommandHandler("casa", function(thePlayer)
	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Console")) then
		if(getElementInterior(thePlayer) ~= 0) then
			outputChatBox("Não é possivel criar casas em interior!", thePlayer, 255, 0, 0)
			return
		end
		if(isPedInVehicle(thePlayer) == true) then
			outputChatBox("Não é possivel criar casas dentro de veiculos!", thePlayer, 255, 0, 0)
			return
		end
		triggerClientEvent(thePlayer, "onClientHouseSystemGUIStart", thePlayer)
	else
		outputChatBox("Você não tem permissão a esse comando!", thePlayer, 255, 0, 0)
	end
end)

-- /in --
addCommandHandler("in", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
			local id = tonumber(house)
			if(tonumber(houseData[id]["LOCKED"]) == 0) or (houseData[id]["DONO"] == getAccountName( getPlayerAccount(thePlayer))) or (isPlayerRentedHouse(thePlayer, id) == true) then
				local int, intx, inty, intz, dim = houseIntData[id]["INT"], houseIntData[id]["X"], houseIntData[id]["Y"], houseIntData[id]["Z"], id
				setElementData(thePlayer, "house:in", true)
				setInPosition(thePlayer, intx, inty, intz, int, false, dim)
				unbindKey(thePlayer, open_key, "down", togglePlayerInfomenue, id)
				outputChatBox ('#00FFFF●#FFFFFF¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯#00FFFF●', thePlayer, 255, 255, 255, true)
				outputChatBox("        #FFFFFFPressione #00fFFF"..open_key.." #FFFFFFpara abrir as informações da casa.", thePlayer, 0, 255, 255 , true)
				outputChatBox ('#00FFFF●#FFFFFF____________________________________________________#00FFFF●', thePlayer, 255, 255, 255, true)
				setElementData(thePlayer, "house:lastvisitINT", id)
				if(houseData[id]["DONO"] == getAccountName( getPlayerAccount(thePlayer))) or (isPlayerRentedHouse(thePlayer, id) == true) then
					bindKey(thePlayer, open_key, "down", togglePlayerHousemenue, id)
				end
			else
				outputChatBox("Casa fechada! Você não tem permissão para entrar!", thePlayer, 255, 0, 0)
			end
		end
	end
end)

-- /out --
addCommandHandler("out", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisitINT")) and (getElementData(thePlayer, "house:lastvisitINT") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisitINT")
		if(house) then
			local id = tonumber(house)
			local x, y, z = houseData[id]["X"], houseData[id]["Y"], houseData[id]["Z"]
			setElementData(thePlayer, "house:in", false)
			setInPosition(thePlayer, x, y, z, 0, false, 0)
		end
	end
end)
--[[
addEventHandler( 'onPlayerLogin', root, function()
	for _, houseDatas in pairs(houseData) do
	local owner = houseDatas["DONO"]
        if owner == getAccountName( getPlayerAccount(source)) then
        blip[source] = createBlip( 0, 0, 0, 32, 0, 0, 0, 255 )
        setBlipVisibleDistance(blip[source], 7000)
        attachElements (blip[source],houseDatas["PICKUP"])
        setElementVisibleTo ( blip[source], source, true )
		
addEventHandler( 'onPlayerLogout', source, function()
	for _, house2 in pairs(houseData) do
	local pick = house2["PICKUP"]
        for _, elem in ipairs( getAttachedElements( pick ) ) do
          if getElementType( elem ) == 'blip' then
            destroyElement( elem )
			--elem = nil
          end		
       end
	end
end)

addEventHandler( 'onPlayerQuit', source, function()
	for _, house2 in pairs(houseData) do
	local pick = house2["PICKUP"]
        for _, elem in ipairs( getAttachedElements( pick ) ) do
          if getElementType( elem ) == 'blip' then
            destroyElement( elem )
			--elem = nil
          end		
       end
	end
end)

end
end
end)]]

function destroyblip ()
	for _, house2 in pairs(houseData) do
	local owner = house2["DONO"]
	local pick = house2["PICKUP"]
	if getAccountName( getPlayerAccount(source)) == owner then
        for k, elem in ipairs( getAttachedElements( pick ) ) do
          if getElementType( elem ) == 'blip' then
            destroyElement( elem )
			elem = nil
          end		
       end
    end
end
end
--addEventHandler("onPlayerQuit", root, destroyblip)
--addEventHandler("onPlayerLogout", root, destroyblip)

-- /buyhouse --
addCommandHandler("buyhouse", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
		  if isGuestAccount( getPlayerAccount( thePlayer )) then
             outputChatBox( '* Você precisa estar logado para comprar essa casa!', thePlayer, 255, 51, 36 ) return end
			local id = house
			local owner = houseData[id]["OWNER"]
			local pick = houseData[id]["PICKUP"]
			if(owner ~= "Ninguém") then
				outputChatBox("Você não pode comprar esta casa!", thePlayer, 255, 0, 0)
			else
				local houses = 0
				for index, col in pairs(getElementsByType("colshape")) do
					if(getElementData(col, "house") == true) and (houseData[getElementData(col, "ID")]["DONO"] == getAccountName( getPlayerAccount(thePlayer))) then
						houses = houses+1
						if(houses == max_player_houses) then
							outputChatBox("Você já tem "..max_player_houses.." casas! Venda uma para comprar essa casa!", thePlayer, 255, 0, 0)
							return
						end
					end
				end
				local money = getPlayerMoney(thePlayer)
				local price = houseData[id]["PRICE"]
				if(money < price) then outputChatBox("Você tem dinheiro suficiente! Você precisa de $"..(price-money).."!", thePlayer, 255, 0, 0) return end
				setHouseData(id, "OWNER", getPlayerName(thePlayer))
				setHouseData(id, "DONO", getAccountName( getPlayerAccount(thePlayer)))				
				givePlayerMoney(thePlayer, -price)
				setHouseData(id, "RENTABLE", 0)
				outputChatBox("Parabéns! Você comprou a casa!", thePlayer, 0, 255, 0)
				
				--setElementModel(houseData[id]["PICKUP"], 1272)
			    --setElementModel(houseData[id]["BLIP"], 32)				
				--destroyElement(houseData[id]["BLIP"])
				
		    	destroyElement(houseData[id]["PICKUP"])
				x = houseData[id]["X"]
				y = houseData[id]["Y"]
				z = houseData[id]["Z"]
				houseData[id]["PICKUP"] = createPickup(x, y, z-0.5, 3, 1272, 100)		
				--houseData[id]["BLIP"] = createBlip(x, y, z, 32, 2, 255, 0, 0, 255, 0, 50)	

				--blip[id] = createBlip( 0, 0, 0, 32, 0, 0, 0, 255 )
				--setBlipVisibleDistance(blip[id], 7000)
				--attachElements (blip[id], houseData[id]["PICKUP"])
				--setElementVisibleTo ( blip[id], thePlayer, true )
				
			end
		end
	end
end)

-- /sellhouse --
addCommandHandler("sellhouse", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
		  if isGuestAccount( getPlayerAccount( thePlayer )) then
             outputChatBox( '* Você precisa estar logado para entrar em casa!', thePlayer, 255, 51, 36 ) return end
			local id = house
			local owner = houseData[id]["DONO"]
			if(owner ~= getAccountName( getPlayerAccount(thePlayer))) then
				outputChatBox("Você não pode vender esta casa!", thePlayer, 255, 0, 0)
			else
				local price = houseData[id]["PRICE"]
				setHouseData(id, "OWNER", "Ninguém")
				setHouseData(id, "RENTABLE", 0)
				setHouseData(id, "RENTALPRICE", 0)
				setHouseData(id, "DONO", "none")	
				for i = 1, 5, 1 do
					setHouseData(id, "RENT"..i, "Ninguém")
				end
				givePlayerMoney(thePlayer, math.floor(price/100*sellhouse_value))
				outputChatBox("Você vendeu a casa com sucesso e recebeu $"..math.floor(price/100*sellhouse_value).." devolta!", thePlayer, 0, 255, 0)
				
				--setElementModel(houseData[id]["PICKUP"], 1273)
				--setElementModel(houseData[id]["BLIP"], 31)				
				--destroyElement(houseData[id]["BLIP"])
				
		    	destroyElement(houseData[id]["PICKUP"])
				x = houseData[id]["X"]
				y = houseData[id]["Y"]
				z = houseData[id]["Z"]
				houseData[id]["PICKUP"] = createPickup(x, y, z-0.5, 3, 1273, 100)		
				--houseData[id]["BLIP"] = createBlip(x, y, z, 31, 2, 255, 0, 0, 255, 0, 50)	
				
				--if blip[id] and isElement(blip[id]) then
				--destroyElement(blip[id])
				--blip[id] = nil
				--end
				
			end
		end
	end
end)

-- /deletehouse --
addCommandHandler("deletehouse", function(thePlayer, cmd, id)
	if(hasObjectPermissionTo ( thePlayer, "command.mute", false ) ) then
		id = tonumber(id)
		if not(id) then return end
		if not(house[id]) then
			outputChatBox("Não há casa com o ID "..id.."!", thePlayer, 255, 0, 0)
			return
		end
		local query = dbQuery(handler, "DELETE FROM houses WHERE ID = '"..id.."';")
		local result = dbPoll(query, dbpTime)
		if(result) then
			--destroyElement(houseData[id]["BLIP"])
			destroyElement(houseData[id]["PICKUP"])
			destroyElement(houseIntData[id]["PICKUP"])
			houseData[id] = nil
			houseIntData[id] = nil
			destroyElement(house[id])
			destroyElement(houseInt[id])
			outputChatBox("Casa "..id.." destruída com sucesso!", thePlayer, 0, 255, 0)
			house[id] = false
			
			--if blip[id] and isElement(blip[id]) then
			--destroyElement(blip[id])
			--blip[id] = nil
			--end
						
		else
			--error("House ID "..id.." has been created Ingame, but House is not in the database! WTF")
		end
	else
		outputChatBox("Você não tem permissão a esse comando!", thePlayer, 255, 0, 0)
	end
end)

--------------------
-- BIND FUNCTIONS --
--------------------
function togglePlayerInfomenue(thePlayer, key, state, id)
	if (id) then
		local locked = houseData[id]["LOCKED"]
		local rentable = houseData[id]["RENTABLE"]
		local rentalprice = houseData[id]["RENTALPRICE"]
		local owner = houseData[id]["OWNER"]
		local dono = houseData[id]["DONO"]
		local price = houseData[id]["PRICE"]
		local x, y, z = getElementPosition(house[id])
		local house = getPlayerRentedHouse(thePlayer)
		if(house ~= false) then house = true end
		local isrentedin = isPlayerRentedHouse(thePlayer, id)
		triggerClientEvent(thePlayer, "onClientHouseSystemInfoMenueOpen", thePlayer, dono, owner, x, y, z, price, locked, rentable, rentalprice, id, house, isrentedin)
	end
end

function togglePlayerHousemenue(thePlayer, key, state, id)
	if(id) then
		if(getElementInterior(thePlayer) ~= 0) then
			local locked = houseData[id]["LOCKED"]
			local money = houseData[id]["MONEY"]
			local weap1 = houseData[id]["WEAPONS"][1]
			local weap2 = houseData[id]["WEAPONS"][2]
			local weap3 = houseData[id]["WEAPONS"][3]
			local rentable = houseData[id]["RENTABLE"]
			local rent = houseData[id]["RENTALPRICE"]
			local tenands = getHouseTenands(id)
			local owner = false
			if(getAccountName( getPlayerAccount(thePlayer)) == houseData[id]["DONO"]) then
				owner = true
			end
			local canadd = canAddHouseTenand(id)
			triggerClientEvent(thePlayer, "onClientHouseSystemMenueOpen", thePlayer, owner, locked, money, weap1, weap2, weap3, id, rentable, rent, tenands, canadd)
		end
	else
		triggerClientEvent(thePlayer, "onClientHouseSystemMenueOpen", thePlayer )
	end
end

-------------------------------
-- HOUSE CREATION ON STARTUP --
-------------------------------
addEventHandler("onPlayerLogin", getRootElement(),
	function()
		local accountName = getAccountName(getPlayerAccount(source))
		setElementData(source, "account-name", accountName)
	end
)

addEventHandler("onPlayerLogout", getRootElement(),
	function()
		setElementData(source, "account-name", "Não logado")
	end
)

-- BUILDHOUSE FUNCTION --
local function buildHouse(id, x, y, z, interior, intx, inty, intz, money, weapons, locked, price, owner, dono, rentable, rentalprice, rent1, rent2, rent3, rent4, rent5)
	if(id) and (x) and(y) and (z) and (interior) and (intx) and (inty) and (intz) and (money) and (weapons) and (owner) then
		houseid = id
		house[id] = createColSphere(x, y, z, 2) -- This is the house, hell yeah
		houseData[id] = {} 
		local house = house[id] -- I'm too lazy...
		setElementData(house, "house", true) -- Just for client code only 	
				
		local houseIntPickup = createPickup(intx, inty, intz, 3, 1318, 100)
		setElementInterior(houseIntPickup, interior)
		setElementDimension(houseIntPickup, id)
			
		houseInt[id] = createColSphere(intx, inty, intz, 1.5) -- And this is the Exit
		setElementInterior(houseInt[id], interior)
		setElementDimension(houseInt[id], id) -- The House Dimension is the house ID
		setElementData(houseInt[id], "house", false)
		--------------------
		-- EVENT HANDLERS --
		--------------------		
		-- IN --
		addEventHandler("onColShapeHit", house, function(hitElement)
			if(getElementType(hitElement) == "player") then
				setElementData(hitElement, "house:lastvisit", id)
				bindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
				outputChatBox ('#00FFFF●#FFFFFF¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯#00FFFF●', hitElement, 255, 255, 255, true)
				outputChatBox("           #FFFFFFPressione #00fFFF"..open_key.."#FFFFFF para abrir as informações desta casa.", hitElement, 0, 255, 255, true)
				outputChatBox ('#00FFFF●#FFFFFF____________________________________________________#00FFFF●', hitElement, 255, 255, 255, true)
			end
		end)
		
		addEventHandler("onColShapeLeave", house, function(hitElement)
			if(getElementType(hitElement) == "player") then
				setElementData(hitElement, "house:lastvisit", false)
				unbindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
				--outputChatBox(id)
			end
		end)
		
		-- OUT --		
		addEventHandler("onColShapeHit", houseInt[id], function(hitElement, dim)
			if(dim == true) then
				if(getElementType(hitElement) == "player") then
					unbindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
					setElementData(hitElement, "house:lastvisitINT", id)
					if(houseData[id]["DONO"] == getAccountName( getPlayerAccount(hitElement))) or (isPlayerRentedHouse(hitElement, id) == true) then
						bindKey(hitElement, open_key, "down", togglePlayerHousemenue, id)
					end
					--outputChatBox(id)
				end
			end
		end)
		
		--[[addEventHandler("onColShapeLeave", houseInt[id], function(hitElement, dim)
			if(dim == true) then
				if(getElementType(hitElement) == "player") then
					setElementData(hitElement, "house:lastvisitINT", false)
					if(houseData[id]["OWNER"] == getPlayerName(hitElement)) or (isPlayerRentedHouse(hitElement, id) == true) then
						unbindKey(hitElement, open_key, "down", togglePlayerHousemenue, id)
					end
					--outputChatBox(id)
				end
			end
		end)]]
		
		-- Set data for HOUSE --
		houseData[id]["HOUSE"] = house
		houseData[id]["DIM"] = id
		houseData[id]["MONEY"] = money
		houseData[id]["WEAPONS"] = weapons
		houseData[id]["INTHOUSE"] = houseInt[id]
		houseData[id]["LOCKED"] = locked
		houseData[id]["PRICE"] = price
		houseData[id]["OWNER"] = owner
		houseData[id]["DONO"] = dono
		houseData[id]["X"] = x
		houseData[id]["Y"] = y
		houseData[id]["Z"] = z
		houseData[id]["RENTABLE"] = rentable
		houseData[id]["RENTALPRICE"] = rentalprice
		houseData[id]["RENT1"] = rent1
		houseData[id]["RENT2"] = rent2
		houseData[id]["RENT3"] = rent3
		houseData[id]["RENT4"] = rent4
		houseData[id]["RENT5"] = rent5
		
		-- HOUSE PICKUP --
		local housePickup
		if(owner ~= "Ninguém") then
			housePickup = createPickup(x, y, z-0.5, 3, 1272, 100)
		else
			housePickup = createPickup(x, y, z-0.5, 3, 1273, 100)
		end
		-- HOUSE BLIP --
		local houseBlip
		if(owner ~= "Ninguém") then
		--	houseBlip = createBlip(x, y, z, 32, 2, 255, 0, 0, 255, 0, 50)
		else
		--	houseBlip = createBlip(x, y, z, 31, 2, 255, 0, 0, 255, 0, 50)
		end
		
		-- SET THE DATA --
		houseData[id]["PICKUP"] = housePickup
		houseData[id]["BLIP"] = houseBlip
		
		setElementData(house, "PRICE", price)
		setElementData(house, "OWNER", owner)
		setElementData(house, "DONO", dono)
		setElementData(house, "LOCKED", locked)
		setElementData(house, "ID", id)
		setElementData(house, "RENTABLE", rentable)
		setElementData(house, "RENTALPRICE", rentalprice)
		
		-- SET DATA FOR HOUSEINTERIOR --
		houseIntData[id] = {}
		houseIntData[id]["OUTHOUSE"] = houseData[id]["HOUSE"]
		houseIntData[id]["INT"] = interior
		houseIntData[id]["X"] = intx
		houseIntData[id]["Y"] = inty
		houseIntData[id]["Z"] = intz
		houseIntData[id]["PICKUP"] = houseIntPickup
		outputServerLog("House with ID "..id.." created sucessfully!")
		buildEndTick = getTickCount()
		
		-- TRIGGER TO ALL CLIENTS THAT THE HOUSE HAS BEEN CREATEEEEEEEEEEEEEEEEEEEEEEED --
		setTimer(triggerClientEvent, 1000, 1, "onClientHouseSystemColshapeAdd", getRootElement(), house)
			
  addEventHandler( 'onPickupUse', houseIntPickup, function( player )
    if getElementType( player ) == 'player' then
      toggleAllControls( player, false )
      fadeCamera( player, false )
      setTimer( function( player )
        if getPedOccupiedVehicle( player ) then
		removePedFromVehicle( player )
		end
		local house = getElementData(player, "house:lastvisitINT")
		if(house) then
			local idd = tonumber(house)
			local x, y, z = houseData[idd]["X"], houseData[idd]["Y"], houseData[idd]["Z"]
			setElementData(player, "house:in", false)
			--setInPosition(player, x, y, z+1, 0, false, 0)
			toggleAllControls( player, true )
			setElementPosition( player, x, y, z )
			setElementInterior( player, 0 )
			setElementDimension( player, 0 )
		end
		if(getElementType(player) == "player") then
				setElementData(player, "house:lastvisitINT", false)
			if(houseData[id]["DONO"] == getAccountName( getPlayerAccount(player))) or (isPlayerRentedHouse(player, id) == true) then
				unbindKey(player, open_key, "down", togglePlayerHousemenue, id)
			end
		end
         fadeCamera( player, true )
      end, 1500, 1, player, source )
    end
  end )
  
	else
		if not(id) then
			error("Arguments @buildHouse not valid! There is no Houseid!")
		elseif not(x) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..x)
		elseif not(y) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..y)
		elseif not(z) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..z)
		elseif not(interior) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..interior)
		elseif not(intx) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..intx)
		elseif not(inty) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..inty)
		elseif not(intz) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..intz)
		elseif not(money) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..money)
		elseif not(weapons) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..weapons)
		elseif not(owner) then
			error("Arguments @buildHouse not valid! Houseid = "..id.." Argument "..owner)
		end
	end	
end

-- TAKE PLAYER RENT --
local function takePlayerRent()
	for index, player in pairs(getElementsByType("player")) do
		if(getPlayerRentedHouse(player) ~= false) then
			local id = getPlayerRentedHouse(player)
			local owner = houseData[id]["OWNER"]
			local rentable = tonumber(houseData[id]["RENTABLE"])
			if(rentable == 1) then
				local rentprice = tonumber(houseData[id]["RENTALPRICE"])
				takePlayerMoney(player, rentprice) -- Takes the player money for the rent
				outputChatBox("Você pagou $"..rentprice.." preço do aluguel!", player, 255, 255, 0, true)
				if(getPlayerFromName(owner)) then
					givePlayerMoney(getPlayerFromName(owner), rentprice) -- Gives the owner the rentalprice
					outputChatBox("Você recebeu $"..rentprice.." dos moradores da sua casa!", getPlayerFromName(owner), 255, 255, 0, true)
				end
			end
		end
	end
end

-- HOUSE DATABASE EXECUTION --
function housesys_startup()
	if(created == true) then
		error("Casas ja foram criadas!")
		return
	end
	buildStartTick = getTickCount()
	local query = dbQuery(handler, "SELECT * FROM houses;" )
	local result, numrows = dbPoll(query, dbpTime)
	if (result and numrows > 0) then
		for index, row in pairs(result) do
			local id = row['ID']
			local x, y, z = row['X'], row['Y'], row['Z']
			local int, intx, inty, intz = row['INTERIOR'], row['INTX'], row['INTY'], row['INTZ']
			local money, weap1, weap2, weap3 = row['MONEY'] or 0, row['WEAP1'] or 0, row['WEAP2'] or 0, row['WEAP3'] or 0
			local locked = row['LOCKED'] or 0
			local price = row['PRICE'] or 0
			local owner = row['OWNER'] or "Ninguém"
			local dono = row['DONO'] or "none"
			local rentable = row['RENTABLE'] or 0
			local rentalprice = row['RENTALPRICE'] or 100
			local rent1, rent2, rent3, rent4, rent5 = row['RENT1'] or "Ninguém" ,row['RENT2'] or "Ninguém" , row['RENT3'] or "Ninguém" , row['RENT4'] or "Ninguém" , row['RENT5'] or "Ninguém"
			local weapontable = {}
			weapontable[1] = weap1
			weapontable[2] = weap2
			weapontable[3] = weap3
			buildHouse(id, x, y, z, int, intx, inty, intz, money, weapontable, locked, price, owner, dono, rentable, rentalprice, rent1, rent2, rent3, rent4, rent5)
		end
		dbFree(query)
	else
		error("Houses Table not Found/empty!")
	end	
	created = true
	setTimer(function()
		local elapsed = (buildEndTick-buildStartTick)
		outputServerLog("It took "..(elapsed/1000).." seconds to build all houses.")
	end, 1000, 1)
	rentTimer = setTimer(takePlayerRent, 3600000, 0)
end

-- House Data array set --
function setHouseData(ID, typ, value)
	-- Security array -- 
	houseData[ID][typ] = value
	setElementData(house[ID], typ, value)
	if(saveableValues[typ]) then
		local query = dbQuery(handler, "UPDATE houses SET "..saveableValues[typ].." = '"..value.."' WHERE ID = '"..ID.."';" )
		local result = dbPoll(query, dbpTime)
		if(result) then
			dbFree(query)
		else
			error("Can't save Data: "..typ.." with the value: "..value.." for house ID "..ID.."!")
		end
	end
end

--------------------
-- EVENT HANDLERS --
--------------------
-- INFO RENT --
addEventHandler("onHouseSystemInfoRent", getRootElement(), function(id, value)
	if(houseData[id]) then
		if(value == true) then
			executeCommandHandler("rent", source)
		else
			executeCommandHandler("unrent", source)
		end
	end
end)

-- INFO ENTER --
addEventHandler("onHouseSystemInfoEnter", getRootElement(), function(id)
	if(houseData[id]) then
		executeCommandHandler("in", source)
	end
end)

-- INFO BUY --
addEventHandler("onHouseSystemInfoBuy", getRootElement(), function(id, value)
	if(houseData[id]) then
		if(value == true) then
			executeCommandHandler("buyhouse", source)
		else
			executeCommandHandler("sellhouse", source)
		end
	end
end)

-- TENAND REMOVE --
addEventHandler("onHouseSystemTenandRemove", getRootElement(), function(id, value)
	if(houseData[id]) then
		local sucess = removeHouseTenand(id, value)
		if(sucess == true) then
			outputChatBox("Você removeu com sucesso o morador "..value.."!", source, 0, 255, 0, true)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "TENANDS", getHouseTenands(id))
		end
	end
end)

-- SET RENTALPRICE --
addEventHandler("onHouseSystemRentalprice", getRootElement(), function(id, value)
	if(houseData[id]) then
		local oldvalue = tonumber(houseData[id]["RENTALPRICE"])
		if(oldvalue < value) then
			local tenands = getHouseTenands(id)
			local users = {}
			for i = 1, 5, 1 do
				if(tenands[i] ~= "Ninguém") then
					users[i] = tenands[i]
				end
			end
			if(#users > 0) then
				outputChatBox("Você não pode mudar o preço de aluguel para um valor mais alto, porque há moradores em sua casa!", source, 255, 0, 0)
				return
			end
		end
		setHouseData(id, "RENTALPRICE", value)
		outputChatBox("Você configurou com êxito o preço de aluguel para $"..value.."!", source, 0, 255, 0)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTALPRICE", value)
	end
end)

-- RENTABLE SWITCH --
addEventHandler("onHouseSystemRentableSwitch", getRootElement(), function(id)
	if(houseData[id]) then
		local state = tonumber(houseData[id]["RENTABLE"])
		if(state == 0) then
			setHouseData(id, "RENTABLE", 1)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTABLE", true)
			outputChatBox("A casa está alugavel!", source, 0, 255, 0)
		else
			setHouseData(id, "RENTABLE", 0)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTABLE", false)
			outputChatBox("A casa não está mais alugavel!", source, 0, 255, 0)
		end
	end
end)

-- CREATE HOUSE --
addEventHandler("onHouseSystemHouseCreate", getRootElement(), function(x, y, z, int, intx, inty, intz, price)
	local query = dbQuery(handler, "INSERT INTO houses (X, Y, Z, INTERIOR, INTX, INTY, INTZ, PRICE) values ('"..x.."', '"..y.."', '"..z.."', '"..int.."', '"..intx.."', '"..inty.."', '"..intz.."', '"..price.."');")
	local result, numrows = dbPoll(query, dbpTime)
	if(result) then
		local newid = houseid+1
		outputChatBox("Casa "..newid.." criada com sucesso!", source, 0, 255, 0)
		local weapontable = {}
		weapontable[1] = 0
		weapontable[2] = 0
		weapontable[3] = 0
		buildHouse(newid, x, y, z, int, intx, inty, intz, 0, weapontable, 0, price, "Ninguém", "none", 0, 0, "Ninguém", "Ninguém", "Ninguém", "Ninguém", "Ninguém")
	else
		outputChatBox("Ocorreu um erro durante a criação da casa!", source, 255, 0, 0)
		error("House "..(houseid+1).." could not create!")
	end
end)

-- WITHDRAW WEAPON --
addEventHandler("onHouseSystemWeaponWithdraw", getRootElement(), function(id, value)
	local weapons = houseData[id]["WEAPONS"]
	if(gettok(weapons[value], 1, ",")) then
		local weapon, ammo = gettok(weapons[value], 1, ","), gettok(weapons[value], 2, ",")
		giveWeapon(source, weapon, ammo, true)
		outputChatBox("Você retirou com sucesso a arma do slot "..value.."!", source, 0, 255, 0)
		weapons[value] = 0
		setHouseData(id, "WEAPONS", weapons)
		setHouseData(id, "WEAP1", weapons[1])
		setHouseData(id, "WEAP2", weapons[2])
		setHouseData(id, "WEAP3", weapons[3])
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "WEAPON", value, 0)
	end
end)

-- DEPOSIT WEAPON --
addEventHandler("onHouseSystemWeaponDeposit", getRootElement(), function(id, value)
	local weapons = houseData[id]["WEAPONS"]
	if((weapons[value]) ~= 0) then 
    outputChatBox("O slot de arma "..value..", ja tem uma arma guardada!", source, 255, 0, 0)
	return end
		local weapon = getPedWeapon(source)
		local ammo = getPedTotalAmmo(source)
		if(weapon) and (ammo) and(weapon ~= 0) and (ammo ~= 0) then 
			weapons[value] = weapon..", "..ammo
			takeWeapon(source, weapon)
			outputChatBox("Você guardou com sucesso a sua arma "..getWeaponNameFromID(weapon).." em sua caixa de arma!", source, 0, 255, 0)
			setHouseData(id, "WEAPONS", weapons)
			setHouseData(id, "WEAP1", weapons[1])
			setHouseData(id, "WEAP2", weapons[2])
			setHouseData(id, "WEAP3", weapons[3])
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "WEAPON", value, weapons[value])
		--else
			--outputChatBox("You don't have a weapon!", source, 255, 0, 0)
		else
			outputChatBox("Você precisa estar segurando uma arma!", source, 255, 0, 0)
	end
end)

-- LOCK HOUSE --
addEventHandler("onHouseSystemHouseLock", getRootElement(), function(id)
	local state = tonumber(houseData[id]["LOCKED"])
	if(state == 1) then
		setHouseData(id, "LOCKED", 0)
		outputChatBox("A casa foi destrancada.", source, 0, 255, 0)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "LOCKED", 0)
	else
		setHouseData(id, "LOCKED", 1)
		outputChatBox("A casa foi trancada!", source, 0, 255, 255)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "LOCKED", 1)
	end
end)

-- DEPOSIT MONEY --
addEventHandler("onHouseSystemHouseDeposit", getRootElement(), function(id, value)
	if(value > getPlayerMoney(source)-1) then return end
	setHouseData(id, "MONEY", tonumber(houseData[id]["MONEY"])+value)
	outputChatBox("Você depositou "..value.."$ no cofre da sua casa!", source, 0, 255, 0)
	triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "MONEY", tonumber(houseData[id]["MONEY"]))
	givePlayerMoney(source, -value)
end)

-- WITHDRAW MONEY --
addEventHandler("onHouseSystemHouseWithdraw", getRootElement(), function(id, value)
	local money = tonumber(houseData[id]["MONEY"])
	if(money < value) then
		outputChatBox("Você não "..value.." em seu cofre!", source, 255, 0, 0)
		return
	end
	setHouseData(id, "MONEY", tonumber(houseData[id]["MONEY"])-value)
	outputChatBox("Você sacou "..value.."$ do seu cofre!", source, 0, 255, 0)
	triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "MONEY", money-value)
	givePlayerMoney(source, value)
end)

----------------------------
-- SETTINGS AND FUNCTIONS --
----------------------------

-- FADE PLAYERS POSITION --
local fadeP = {}
function setInPosition(thePlayer, x, y, z, interior, typ, dim)
	if not(thePlayer) then return end
	if (getElementType(thePlayer) == "vehicle") then return end
	if(isPedInVehicle(thePlayer)) then return end
	if not(x) or not(y) or not(z) then return end
	if not(interior) then interior = 0 end
	if(fadeP[thePlayer] == 1) then return end
	fadeP[thePlayer] = 1
	fadeCamera(thePlayer, false)
	setElementFrozen(thePlayer, true)
	setTimer(
		function()
		fadeP[thePlayer] = 0
		setElementPosition(thePlayer, x, y, z)
		setElementInterior(thePlayer, interior)
		if(dim) then setElementDimension(thePlayer, dim) end
		fadeCamera(thePlayer, true)
		if not(typ) then
			setElementFrozen(thePlayer, false)
		else
			if(typ == true)  then
				setTimer(setElementFrozen, 1000, 1, thePlayer, false)
			end
		end
	end, 1000, 1)
end

-- canAddHouseTenand
-- Checks if there is a free slot in the house
function canAddHouseTenand(id)
	if not(houseData[id]) then return false end
	for i = 1, 5, 1 do
		local name = houseData[id]["RENT"..i]
		if(name == "Ninguém") then
			return true, i
		end
	end
	return false;
end

-- addHouseTenand
-- Adds a player to a house as tenand
function addHouseTenand(player, id)
	if not(houseData[id]) then return false end
	for i = 1, 5, 1 do
		local name = houseData[id]["RENT"..i]
		if(name == "Ninguém") then
			setHouseData(id,"RENT"..i, getAccountName( getPlayerAccount(player)))
			return true, i
		end
	end
	return false;
end

-- removeHouseTenand
-- Removes a player from a house
function removeHouseTenand(id, player)
	if not(houseData[id]) then return false end
	if(type(player) == "string") then
		for i = 1, 5, 1 do
			local name = houseData[id]["RENT"..i]
			if(name == player) then
				setHouseData(id,"RENT"..i,"Ninguém")
				return true
			end
		end
	else
		for i = 1, 5, 1 do
			local name = houseData[id]["RENT"..i]
			if(name == getAccountName( getPlayerAccount(player))) then
				setHouseData(id,"RENT"..i,"Ninguém")
				return true
			end
		end
	end
	return false;
end

-- getHouseTenands(houseid)
-- Returns a table within all tenands in this house 
function getHouseTenands(id)
	if not(houseData[id]) then return false end
	local rent = {}
	for i = 1, 5, 1 do
		rent[i] = houseData[id]["RENT"..i]
	end
	return rent;
end

-- getPlayerRentedHouse
-- Gets the House where a player is rented in --
function getPlayerRentedHouse(thePlayer)
	for index, house in pairs(getElementsByType("colshape")) do
		if(getElementData(house, "house") == true) and (getElementData(house, "ID")) then
			local id = tonumber(getElementData(house, "ID"))
			if not(id) then return false end
			local rent = {}
			for i = 1, 5, 1 do
				rent[i] = houseData[id]["RENT"..i]
			end
			for index, player in pairs(rent) do
				if(player == getAccountName( getPlayerAccount(thePlayer))) then
					return id;
				end
			end
		end
	end
	return false;
end

-- isPlayerRentedHouse
-- Checks if a player is rented in a specific house
function isPlayerRentedHouse(thePlayer, id)
	if not(houseData[id]) then return false end
	local rent = {}
	for i = 1, 5, 1 do
		rent[i] = houseData[id]["RENT"..i]
	end
	for index, player in pairs(rent) do
		if(player == getAccountName( getPlayerAccount(thePlayer))) then
			return true;
		end
	end
	return false;
end