local airrideLevels = {
	[1] = 0.01,
	[2] = -0.1,
	[3] = -0.2,
	[4] = -0.3,
	[5] = -0.45,
}

addCommandHandler("airride", function(player, cmd, level) --- air süspansiyon

	if isPedInVehicle(player) then

		local vehicle = getPedOccupiedVehicle(player)

		if getElementData(vehicle, "vehicle.tuning.airride") then
			
			local level = tonumber(level)

			if not level or level > 5 or level < 0 then

				outputChatBox("[TUNNIG] - "..cmd.." Level (0-5)", player, 255, 255, 255, true)

			else

				local model = getElementModel(vehicle)
				local currentHandling = getModelHandling(model)

				triggerClientEvent(getElementsByType("player"), "playAirrideSound", vehicle)

				setTimer(function()

					setVehicleHandling(vehicle, "suspensionLowerLimit", airrideLevels[level] or currentHandling["suspensionLowerLimit"])
					
				end, 2000, 1)

			end

		end

	end
	
end)


----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy