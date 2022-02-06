customCarNames = -- новые названия
{
	
}

shopsVehSpawns = {
	[1] = { 740.357, -1355.666, 13.065, 0,0,359 },
	[2] = { 592.707, -1959.439, 0.79 },
	[3] = { 1907.791, -2384.369, 13.727, 0,0,350 },
	[4] = { -1988, 272, 36, 0,0,259 },
	[5] = { -1642, 1213, 7.17, 0,0, 227 },
	[6] = { 531.64141845703, -1929.9896240234, -0.55000001192093, 0, 0, 0}
}

function getFreeID()
	local result = dbPoll(dbQuery(db, "SELECT ID FROM VehicleList ORDER BY ID ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["ID"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function getVehicleByID(id)
	v = false
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "ID") == id then
			v = veh
			break
		end
	end
	return v
end

function updateVehicleInfo(player)
	if isElement(player) then
		local result = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(player))), -1)
		if type(result) == "table" then
			setElementData(player, "VehicleInfo", result)
		end
	end
end

addEventHandler("onResourceStart", resourceRoot,
function()
	db = dbConnect("sqlite", "database.db")
	dbExec(db, "CREATE TABLE IF NOT EXISTS VehicleList (ID, Account, Model, X, Y, Z, RotZ, Colors, Upgrades, Paintjob, Cost, HP, new_hydr)")
	for i, player in ipairs(getElementsByType("player")) do
		updateVehicleInfo(player)
	end
end)

addEvent("onOpenGui", true)
addEventHandler("onOpenGui", root,
function()
	updateVehicleInfo(source)
end)

function destroyVehicle(theVehicle)
	if isElement(theVehicle) then
		local Owner = getElementData(theVehicle, "Owner")
		if Owner then
			local x, y, z = getElementPosition(theVehicle)
			local _, _, rz = getElementRotation(theVehicle)
			local r1, g1, b1, r2, g2, b2 = getVehicleColor(theVehicle, true)
			local color = r1..","..g1..","..b1..","..r2..","..g2..","..b2
			upgrade = ""
			for _, upgradee in ipairs (getVehicleUpgrades(theVehicle)) do
				if upgrade == "" then
					upgrade = upgradee
				else
					upgrade = upgrade..","..upgradee
				end
			end
			local Paintjob = getVehiclePaintjob(theVehicle) or 3
			local id = getElementData(theVehicle, "ID")
			dbExec(db, "UPDATE VehicleList SET X = ?, Y = ?, Z = ?, RotZ = ?, HP = ?, Colors = ?, Upgrades = ?, Paintjob = ?, new_hydr = ? WHERE Account = ? AND ID = ?", x, y, z, rz, getElementHealth(theVehicle), color, upgrade, Paintjob, getElementData ( theVehicle, "NewHydr") and 1 or 0, getAccountName(getPlayerAccount(Owner)), id)
			updateVehicleInfo(Owner)
			local attached = getAttachedElements(theVehicle)
			if (attached) then
				for k,element in ipairs(attached) do
					if getElementType(element) == "blip" then
						destroyElement(element)
					end
				end
			end
		end
		destroyElement(theVehicle)
	end
end
addEvent("onBuyNewVehicle", true)
addEventHandler("onBuyNewVehicle", root, 




function(Model, cost, r1, g1, b1, r2, g2, b2)
	abc = false
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(source))), -1)
	for i, data in ipairs (data) do
		if data["Model"] == Model then
			abc = true
			break
		end
	end
	if #data >= 10 then exports.Scripts_Dxmessages:outputDx ( source, "Desculpe, mas você só pode comprar 10 veículos.","error" ) return end
	if abc then exports.Scripts_Dxmessages:outputDx ( source, "você já tem este veículo", "error" ) return end
	if getPlayerMoney(source) >= tonumber(cost) then
		takePlayerMoney ( source, cost )
		local x, y, z = getElementPosition(source)
		local _, _, rz = getElementRotation(source)
		local shopID = getElementData ( source, "atVehShop")
		local color = r1..","..g1..","..b1..","..r2..","..g2..","..b2
		if shopID and shopsVehSpawns[shopID] then
			vehicle = createVehicle(Model, shopsVehSpawns[shopID][1], shopsVehSpawns[shopID][2], shopsVehSpawns[shopID][3], shopsVehSpawns[shopID][4], shopsVehSpawns[shopID][5], shopsVehSpawns[shopID][6])
		else
			vehicle = createVehicle(Model, x-5, y+5, z, 0, 0, rz)
		end
		setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
		setElementData(vehicle, "Owner", source)
		local NewID = getFreeID()
		setElementData(vehicle, "ID", NewID)
		dbExec(db, "INSERT INTO VehicleList VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", NewID, getAccountName(getPlayerAccount(source)), Model, x-5, y+5, z, rz, color, "", 3, cost, 1000, 0)
		exports.Scripts_Dxmessages:outputDx ( source, "Comprou este carro por: R$"..cost, "success" )
		updateVehicleInfo(source)
		setElementData(vehicle, "ownercar", getAccountName(getPlayerAccount(source)))
		warpPedIntoVehicle ( source, vehicle )
		vv[vehicle] = setTimer(function(source)
			if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
			if isElement(source) and getElementHealth(source) <= 255 then
				setElementHealth(source, 255.5)
				setVehicleDamageProof(source, true)
				setVehicleEngineState(source, false)
			end
		end, 150, 0, vehicle)
		addEventHandler("onVehicleDamage", vehicle,
		function(loss)
			local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
			setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
		end)
		addEventHandler("onVehicleEnter", vehicle,
		function(player)
			if getElementHealth(source) <= 255.5 then 
				setVehicleEngineState(source, false)
			else
				if isVehicleDamageProof(source) then
					setVehicleDamageProof(source, false)
				end
			end
		end)
	else
		exports.Scripts_Dxmessages:outputDx ( source, "Você não tem grana para comprar este veiculo.", "error" )
	end
end)

vv = {}

addEvent("SpawnMyVehicle", true)
addEventHandler("SpawnMyVehicle", root, 
function(id)
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
	if type(data) == "table" and #data ~= 0 then
		if getVehicleByID(id) then
			exports.Scripts_Dxmessages:outputDx ( source, "seu veiculo "..(customCarNames[data[1]["Model"]] or getVehicleNameFromModel(data[1]["Model"])).." já está spawnado", "error" )
		else
			local color = split(data[1]["Colors"], ',')
			r1 = color[1] or 255
			g1 = color[2] or 255
			b1 = color[3] or 255
			r2 = color[4] or 255
			g2 = color[5] or 255
			b2 = color[6] or 255
			vehicle = createVehicle(data[1]["Model"], data[1]["X"], data[1]["Y"], data[1]["Z"], 0, 0, data[1]["RotZ"])
			setElementData(vehicle, "ID", id)
			local upd = split(tostring(data[1]["Upgrades"]), ',')
			for i, upgrade in ipairs(upd) do
				addVehicleUpgrade(vehicle, upgrade)
			end
			local Paintjob = data[1]["Paintjob"] or 3
			setVehiclePaintjob(vehicle, Paintjob) 
			setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
			if tonumber(data[1]["HP"]) <= 255.5 then data[1]["HP"] = 255 end
			if data[1]["new_hydr"] and data[1]["new_hydr"] == 1 then
				setElementData(vehicle, "NewHydr", true)
			else
				setElementData(vehicle, "NewHydr", false)
			end
			setElementData(vehicle, "ownercar", getAccountName(getPlayerAccount(source)))
			setElementHealth(vehicle, data[1]["HP"])
			setElementData(vehicle, "Owner", source)
			vv[vehicle] = setTimer(function(source)
				if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
				if isElement(source) and getElementHealth(source) <= 255 then
					setElementHealth(source, 255.5)
					setVehicleDamageProof(source, true)
					setVehicleEngineState(source, false)
				end
			end, 50, 0, vehicle)
			addEventHandler("onVehicleDamage", vehicle,
			function(loss)
				local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
				setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
			end)
			addEventHandler("onVehicleEnter", vehicle,
			function(player)
				if getElementHealth(source) <= 255.5 then 
					setVehicleEngineState(source, false)
				else
					if isVehicleDamageProof(source) then
						setVehicleDamageProof(source, false)
					end
				end
			end)
			exports.Scripts_Dxmessages:outputDx ( source, "seu veiculo "..(customCarNames[data[1]["Model"]] or getVehicleNameFromModel(data[1]["Model"])).." foi spawnado", "success" ) 		end
	else
		exports.Scripts_Dxmessages:outputDx ( source, "Há um problema com o veiculo, notifique o administrador. ","error")

	end
end)
addEvent("DestroyMyVehicle", true)
addEventHandler("DestroyMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
		if type(data) == "table" and #data ~= 0 then
			destroyVehicle(vehicle)
			outputMessage ("#c1c1c1O seu veiculo #00FF66"..(customCarNames[data[1]["Model"]] or getVehicleNameFromModel(data[1]["Model"])).." #c1c1c1foi removido.", source, 38, 122, 216, true)
		else
			outputMessage("#c1c1c1Selecione um veiculo.", source, 38, 122, 216, true)
		end
	else
		outputMessage("#c1c1c1O seu veiculo não foi spawnado.", source, 38, 122, 216, true)
	end
end)

addEvent("LightsMyVehicle", true)
addEventHandler("LightsMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local Vehicle = getPedOccupiedVehicle(source)
		if Vehicle == vehicle then
			if getVehicleOverrideLights(vehicle) ~= 2 then
				setVehicleOverrideLights(vehicle, 2)
				exports.Scripts_Dxmessages:outputDx ( source, "seu veículo  "..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).. " teve as luzes acesas.", "success" )
			elseif getVehicleOverrideLights(vehicle) ~= 1 then
				setVehicleOverrideLights(vehicle, 1)
				exports.Scripts_Dxmessages:outputDx ( source, "seu veículo  "..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).. " as luzes apagadas.", "success" )
			end
		else
			exports.Scripts_Dxmessages:outputDx ( source, "Você não está no veiculo! ", "error" )
		end
	else
		exports.Scripts_Dxmessages:outputDx ( source, "Seu veiculo não está spawnado!", "error" )
	end
end)

addEvent("LockMyVehicle", true)
addEventHandler("LockMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, true)
			setVehicleDoorsUndamageable(vehicle, true)
			setVehicleDoorState(vehicle, 0, 0)
			setVehicleDoorState(vehicle, 1, 0)
			setVehicleDoorState(vehicle, 2, 0)
			setVehicleDoorState(vehicle, 3, 0) 
			exports.Scripts_Dxmessages:outputDx ( source, "Seu veículo "..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." foi fechado", "success" )
		elseif isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, false)
			setVehicleDoorsUndamageable(vehicle, false)
			exports.Scripts_Dxmessages:outputDx ( source, "Seu veículo "..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." foi aberto.", "success")
		end
	else
		exports.Scripts_Dxmessages:outputDx ( source, "Seu veículo não foi spawnado", "error")
	end
end)

addEvent("BlipMyVehicle", true)
addEventHandler("BlipMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not getElementData(vehicle, "ABlip") then
			setElementData(vehicle, "ABlip", true)
			createBlipAttachedTo(vehicle, 0, 2, 255, 0, 0, 255, 0, 65535, source)
			exports.Scripts_Dxmessages:outputDx ( source, "seu veiculo "..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).. "foi marcado no radar/mapa para ver no mapa tecle f11.", "success" )

		else
			local attached = getAttachedElements(vehicle)
			if (attached) then
				for k,element in ipairs(attached) do
					if getElementType(element) == "blip" then
						destroyElement(element)
					end
				end
			end
			setElementData(vehicle, "ABlip", false)
			exports.Scripts_Dxmessages:outputDx ( source, "Seu veículo "..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).." Teve o blip removido", "success" )
		end
	else
		exports.Scripts_Dxmessages:outputDx ( source, "seu veiculo não está spawnado. ", "error" )
	end
end)

addEvent("FixMyVehicle", true)
addEventHandler("FixMyVehicle", root, 
function(id)
	if getPlayerMoney(source) >= tonumber(200) then
		takePlayerMoney ( source, 200 )
		local vehicle = getVehicleByID(id)
		if isElement(vehicle) then
			fixVehicle(vehicle)
			setVehicleEngineState(vehicle, true)
			if isVehicleDamageProof(vehicle) then
				setVehicleDamageProof(vehicle, false)
			end
		end
		dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND ID = ?", 1000, getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		exports.Scripts_Dxmessages:outputDx ( source, "Seu veículo não foi spawnado!", "error" )

	else
		exports.Scripts_Dxmessages:outputDx ( source, "Preço: $200", "error" )	end
end)

addEvent("WarpMyVehicle", true)
addEventHandler("WarpMyVehicle", root, 
function(id)
    if not isPedInVehicle (source) then
	if getElementInterior(source) == 0 then
		if getPlayerMoney(source) >= tonumber(200) then
			local vehicle = getVehicleByID(id)
			if isElement(vehicle) then
				randomizar = math.random(1,14)
				takePlayerMoney ( source, 200 )
				local x, y, z = getElementPosition(source)
				if randomizar == 1 then
					setElementPosition(vehicle, 1650.1873779297, -1079.98046875, 24)
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 2 then
					setElementPosition ( vehicle, 1650, -1084.5, 24 )
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 3 then
					setElementPosition ( vehicle, 1650.0380859375, -1088.8176269531, 24 )
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 4 then
					setElementPosition ( vehicle, 1650.6478271484, -1093.6756591797, 24 )
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 5 then
					setElementPosition ( vehicle, 1650.2822265625, -1098.005859375, 24)
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 6 then
					setElementPosition ( vehicle, 1650.3765869141, -1102.4530029297, 24 )
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 7 then
					setElementPosition ( vehicle, 1649.8811035156, -1106.9301757813, 24 )
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 8 then
					setElementPosition ( vehicle, 1650.0562744141, -1111.576171875, 24)
					setVehicleRotation(vehicle, 0,0,90)
				elseif randomizar == 9 then
					setElementPosition ( vehicle, 1629.3199462891, -1085.0458984375, 24 )
					setVehicleRotation(vehicle, 0,0,270)
				elseif randomizar == 10 then
					setElementPosition ( vehicle, 1629.0223388672, -1089.7844238281, 24 )
					setVehicleRotation(vehicle, 0,0,270)
				elseif randomizar == 11 then
					setElementPosition ( vehicle, 1628.6702880859, -1094.4211425781, 24 )
					setVehicleRotation(vehicle, 0,0,270)
				elseif randomizar == 12 then
					setElementPosition ( vehicle, 1628.34375, -1098.7193603516, 24)
					setVehicleRotation(vehicle, 0,0,270)
				elseif randomizar == 13 then
					setElementPosition ( vehicle, 1628.1042480469, -1103.1959228516, 24 )
					setVehicleRotation(vehicle, 0,0,270)
				elseif randomizar == 14 then
					setElementPosition ( vehicle, 1628.5856933594, -1107.6346435547, 24 )
					setVehicleRotation(vehicle, 0,0,270)
				end
				exports.Scripts_Dxmessages:outputDx ( source, "Seu veículo "..(customCarNames[getElementModel(vehicle)] or getVehicleNameFromModel(getElementModel(vehicle))).. " foi teletransportado para o patio por $200", "success" )
			else
				exports.Scripts_Dxmessages:outputDx ( source, "seu veiculo não está spawnado. ", "error" )
			end
		else
			exports.Scripts_Dxmessages:outputDx ( source, "Você não tem dinheiro o suficiente para enviar o carro para o patio!","error" ) 

		end
	else
		exports.Scripts_Dxmessages:outputDx ( source, "Você só poderá mudar de veículo caso saia do atual!","error" )
	end
     else
		exports.Scripts_Dxmessages:outputDx ( source, "Saia do carro para conseguir mover o carro para o patio!","error" )
    end
end)
	
addEvent("SellMyVehicle", true)
addEventHandler("SellMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
	if type(data) == "table" and #data ~= 0 then
		local Money = math.ceil((data[1]["Cost"]*.9)*math.floor(data[1]["HP"])/100/10)
		givePlayerMoney (source, Money)
		if isElement(vehicle) then destroyElement(vehicle) end
		dbExec(db, "DELETE FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		exports.Scripts_Dxmessages:outputDx ( source, "Você vendeu o seu veículo por $"..Money,"success" )	end
end)

function getDataOnLogin(_, account)
	updateVehicleInfo(source)
end
addEventHandler("onPlayerLogin", root, getDataOnLogin)

function SaveVehicleDataOnQuit()
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "Owner") == source then
			destroyVehicle(veh)
		end
	end
end
addEventHandler("onPlayerQuit", root,SaveVehicleDataOnQuit)


addEvent("inviteToBuyCarSended", true)
addEventHandler("inviteToBuyCarSended", root, 
function(player, price, veh_name, veh_id)
	if player and price and veh_name and veh_id then
		local pl = getPlayerFromName ( player )
		if pl then
			triggerClientEvent ( pl, "recieveInviteToBuyCar", pl, getPlayerName (source), getAccountName(getPlayerAccount(source)), price, veh_name, veh_id )
		else
			exports.Scripts_Dxmessages:outputDx ( source, "jogador não foi encontrado, a venda foi cancelada","success" )
			triggerClientEvent ( source, "cleanCarInvitations", source )
		end
	end
end)


addEvent("invitationBuyCarNotAccepted", true)
addEventHandler("invitationBuyCarNotAccepted", root, 
function(player, acc, price, veh_name, veh_id)
	local pl = getPlayerFromName ( player )
	if pl then
		triggerClientEvent ( pl, "cleanCarInvitations", pl )
		exports.Scripts_Dxmessages:outputDx ( source, "Você não tem dinheiro suficiente!","error" )
	end 
end)

addEvent("invitationBuyCarAccepted", true)
addEventHandler("invitationBuyCarAccepted", root, 
function(player, acc, price, veh_name, veh_id)
	local pl = getPlayerFromName ( player )
	local avail = false
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(source))), -1)
	for i, data in ipairs (data) do
		if data["Model"] == Model then
			abc = true
			break
		end
	end
	if #data >= 10 then exports.Scripts_Dxmessages:outputDx ( source, "Desculpe, mas você só pode comprar 10 veículos.","error" ) return end	
	if pl and getAccountName ( getPlayerAccount (pl)) == acc then
		avail = true
		triggerClientEvent ( pl, "cleanCarInvitations", pl )
	else
		for i, v in ipairs( getElementsByType ( 'player' ) ) do
			if getAccountName(getPlayerAccount ( v )) == acc then
				avail = true
				pl = v
				break
			end
		end
	end
	price = tonumber(price) or 0
	if avail then
		if isGuestAccount ( getPlayerAccount ( source ) ) then
			triggerClientEvent ( pl, "cleanCarInvitations", pl )
			exports.Scripts_Dxmessages:outputDx ( source, "Você não está logado em sua conta, a transação foi cancelada","error" )
			return true
		end
		if getPlayerMoney ( source ) >= price then
			local vehicle = getVehicleByID(tonumber(veh_id))
			local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(pl)), veh_id), -1)
			if type(data) == "table" and #data ~= 0 and isElement ( vehicle ) then
				givePlayerMoney ( pl, price )
				takePlayerMoney ( source, price )		
				dbExec(db, "UPDATE VehicleList SET Account = ? WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), getAccountName(getPlayerAccount(pl)), veh_id)
				updateVehicleInfo(source)
				updateVehicleInfo(pl)
				setElementData(vehicle, "Owner", source)
				setElementData(vehicle, "ownercar", getAccountName(getPlayerAccount(source)))
				exports.Scripts_Dxmessages:outputDx ( source, "Você vendeu o seu veiculo por $"..price,"success" )
				triggerClientEvent ( pl, "cleanCarInvitations", pl )
			else
				exports.Scripts_Dxmessages:outputDx ( source, "Veículo não encontrado, negócio cancelado!","error" )
				triggerClientEvent ( pl, "cleanCarInvitations", pl )
			end
		else
			exports.Scripts_Dxmessages:outputDx ( source, "Você não tem dinheiro suficiente, a transação foi cancelada","success" )
		end
	else
		exports.Scripts_Dxmessages:outputDx ( source, "O jogador não foi encontrado, a operação foi cancelada","success" )
	end
end)


