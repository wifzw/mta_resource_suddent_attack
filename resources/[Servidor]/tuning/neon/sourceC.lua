local _destroyElement = destroyElement

function destroyElement(element)
	if isElement(element) then
		return _destroyElement(element)
	end

	return false
end

local availableNeons = {
	[1] = {18215, "red"},
	[2] = {5681, "blue"},
	[3] = {18448, "green"},
	[4] = {18214, "yellow"},
	[5] = {18213, "pink"},
	[6] = {5764, "white"},
	[7] = {14400, "lightblue"},
	[8] = {14401, "rasta"},
	[9] = {14402, "ice"},
}

local createdNeons = {}

addEventHandler("onClientResourceStart", resourceRoot, function ()
	for k, v in pairs(availableNeons) do
		local dff = engineLoadDFF("files/neon/" .. v[2] .. ".dff")
		local col = engineLoadCOL("files/neon/neon.col")

		if dff and col then
			engineReplaceCOL(col, v[1])
			engineReplaceModel(dff, v[1])
		end
	end

	for k, v in pairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(v) then
			if getElementData(v, "vehicle.tuning.neon") then
				applyNeon(v)
			end
		end
	end

	bindKey("U", "down", "togneon") ---- Neon aç kapa tuşu 
end)

addEventHandler("onClientElementDataChange", root, function(key, oldValue, newValue)
	if getElementType(source) == "vehicle" then
		if key == "vehicle.tuning.neon" then
			applyNeon(source)
		elseif key == "vehicle.neonstate" then
			if newValue then
				applyNeon(source)
			else
				removeNeon(source)
			end
		end
	end
end)

function applyNeon(vehicle)
	local id = tonumber(getElementData(vehicle, "vehicle.tuning.neon"))
	if vehicle and id then
		if getElementData(vehicle, "vehicle.neonstate") == false then
			return
		end

		if id > #availableNeons or id < 1 then
			removeNeon(vehicle)
			return
		end
		
		if createdNeons[vehicle] then
			removeNeon(vehicle)
		end

		local x, y, z = getElementPosition(vehicle)
		local rx, ry, rz = getElementRotation(vehicle)
		if availableNeons[id] then
			local neon1 = createObject(availableNeons[id][1], x, y, z, rx, ry, rz)
			local neon2 = createObject(availableNeons[id][1], x, y, z, rx, ry, rz)

			if isElement(neon1) and isElement(neon2) then
				setObjectScale(neon1, 0)
				setObjectScale(neon2, 0)

				attachElements(neon1, vehicle, 0.8, 0, -0.55)
				attachElements(neon2, vehicle, -0.8, 0, -0.55)

				createdNeons[vehicle] = {neon1, neon2} 
			end
		end
	end
end


function removeNeon(vehicle)
	if createdNeons[vehicle] then
		destroyElement(createdNeons[vehicle][1])
		destroyElement(createdNeons[vehicle][2])
	end
end

addCommandHandler("togneon", function(cmd)

	if isPedInVehicle(localPlayer) then

		local vehicle = getPedOccupiedVehicle(localPlayer)

		if tonumber(getElementData(vehicle, "vehicle.tuning.neon")) then

			if getElementData(vehicle, "vehicle.neonstate") then

				setElementData(vehicle, "vehicle.neonstate", false)

				outputChatBox("[TUNNIG] - Neon kapattınız.", 255, 255, 255, true)

			else

				setElementData(vehicle, "vehicle.neonstate", true)

				outputChatBox("[TUNNIG] - Neon açtınız.", 255, 255, 255, true)

			end

		end

	end

end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
		local neon = tonumber(getElementData(source, "vehicle.tuning.neon"))
		if neon then
			applyNeon(source)
		end
	end
end)			

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
		local neon = tonumber(getElementData(source, "vehicle.tuning.neon"))
		if neon then
			removeNeon(source)
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		local neon = tonumber(getElementData(source, "vehicle.tuning.neon"))
		if neon then
			removeNeon(source)
		end
	end
end)

--[[
	--outputChatBox(exports.crp_core:getServerTag("info") .. "#d75959Kikapcsoltad #ffffffa neont.", 255, 255, 255, true)
	--outputChatBox(exports.crp_core:getServerTag("info") .. "#6fcc9fBekapcsoltad #ffffffa neont.", 255, 255, 255, true)
]]
