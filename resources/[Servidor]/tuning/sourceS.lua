--ALTER TABLE `vehicles` ADD `tuning` JSON NULL DEFAULT NULL AFTER `parkedPosition`; 

local using = {}
local createdTuningMarkers = {}

local export = exports['a_infobox']

local table_HandEffets = getHandEffects()
local table_hand_tuing = getHandsVehicle()

addEventHandler("onResourceStart", resourceRoot, function(res)
	createTuningMarkers()
end)

addEvent("applyTuning", true)
addEventHandler("applyTuning", root, function(effect, level, price)
	if (getPlayerMoney(client) >= price) then 
		if (level > 0) then
			if (effect == "paintjob") then
				setElementData(source, "vehicle."..effect, level)
			elseif (effect == "airride") then
				setElementData(source, "vehicle.tuning."..effect, level)
			elseif (effect == 'neon') then 
				setElementData(source, "vehicle.neonstate", true)
				setElementData(source, "vehicle.tuning."..effect, level)
			else
				if (table_HandEffets[effect]) then 
					local model = getElementModel(source)
					if (table_hand_tuing[model]) then 
						for index, value in pairs(table_HandEffets[effect]) do 
							local data = table_hand_tuing[model][index]
							if (tonumber(data) and index ~= 'suspensionLowerLimit') then 
								setVehicleHandling(source, index, data, false)
								setVehicleHandling(source, index, data + value[level], false)
							else
								setVehicleHandling(source, index, value[level], false)
							end
						end 
					else
						for index, value in pairs(table_HandEffets[effect]) do 
							local data = getModelHandling(model)[index]
							if (tonumber(data) and index ~= 'suspensionLowerLimit') then 
								setVehicleHandling(source, index, data, false)
								setVehicleHandling(source, index, data + value[level], false)
							else
								setVehicleHandling(source, index, value[level], false)
							end
						end
					end
				end
			end
			triggerEvent('tr4jado.onVehicleTunning', source, source)
			takePlayerMoney(client, price)
			exports.a_infobox:addBox(client, 'success',  "Ayarları başarılı bir şekilde uyguladınız.")
		else
			if (effect == "neon") then
				setElementData(source, "vehicle.neonstate", false)
			elseif (effect == "paintjob") then
				setElementData(source, "vehicle." .. effect, 0)
			end
			exports.a_infobox:addBox(client, 'success',  "Ayarları başarılı bir şekilde sildiniz.")
		end
	else
		exports.a_infobox:addBox(client, 'error',  "Paranız yetersiz!")
	end
end)

addEvent("recolorVehicle", true)
addEventHandler("recolorVehicle", root, function(colorTable, price)
	if (getPlayerMoney(client) >= price) then 
		takePlayerMoney(client, price)
		setVehicleColor(source, unpack(colorTable))
		triggerClientEvent(client, "changeLastColor", source, colorTable)
		exports.a_infobox:addBox(client, 'success',  "Aracınızı başarılı bir şekilde boyadınız!")
	else
		exports.a_infobox:addBox(client, 'error',  "Paranız yetersiz!")
	end
end)

function createTuningMarkers()
	for k, v in pairs(tuningMarkers) do
		createTuningMarker(k)
	end
end

function createTuningMarker(id)
	local v = tuningMarkers[id]
	if v then
		local tuningMarker = createMarker(v[1], v[2], v[3] - 1, "cylinder", 3, 255, 130, 243, 90)
		createdTuningMarkers[tuningMarker] = {id, false}
	end
end

function deleteTuningMarker(marker) 
	if isElement(marker) then
		destroyElement(marker)
	end
end

addEvent("enterTuning", true)
addEventHandler("enterTuning", root, function(id)
	local tX, tY, tZ, tRZ = unpack(tuningMarkers[id])
	local vX, vY, vZ = getElementPosition(source)
	setElementFrozen(source, true)
	setVehicleDamageProof(source, true)
	setElementVelocity(source, 0, 0, 0)
	setElementRotation(source, 0, 0, tRZ)
	setElementPosition(source, tX, tY, vZ)
	setElementAngularVelocity(source, 0, 0, 0)
end)

addEvent("leaveTuning", true)
addEventHandler("leaveTuning", root, function(id)
	if using[client] then 
		for i, marker in pairs(createdTuningMarkers) do
			if marker[1] == id then
				createdTuningMarkers[i] = nil
			end
		end
		using[client] = nil 
		setElementFrozen(source, false)
		setVehicleDamageProof(source, false)
		setTimer(createTuningMarker, 5000, 1, id)
	end
end)

addEventHandler("onMarkerHit", resourceRoot, function(hitElement, dimMatch)
	if createdTuningMarkers[source] then
		if not createdTuningMarkers[source][2] then
			if getElementType(hitElement) == "vehicle" and getVehicleType(hitElement) ~= "BMX" then
				local controller = getVehicleController(hitElement)
				if (controller and not using[controller]) then
					using[controller] = true 
					createdTuningMarkers[source][2] = controller
					deleteTuningMarker(source) 
					triggerClientEvent(controller, "showTuning", controller, hitElement, createdTuningMarkers[source][1])
				end
			end
		end
	end
end)

addEventHandler("onPlayerQuit", root, function()
	if using[source] then 
		for marker, v in pairs(createdTuningMarkers) do
			if v[2] == source then
				setTimer(createTuningMarker, 5000, 1, v[1])
			end
		end
		using[source] = nil 
	end
end)


----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy










----- TÜRKÇE ÇEVİRİ SPARROW MTA ! 