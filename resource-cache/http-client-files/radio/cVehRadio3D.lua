radioSound = { }

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		bindKey("r", "down", clientToggleRadio)
		bindKey("mouse_wheel_up", "down", volumeUp)
		bindKey("mouse_wheel_down", "down", volumeDown)
	end
)

addEventHandler("onClientVehicleEnter", root,
	function(thePlayer, seat)
		if thePlayer == getLocalPlayer() then
			local msg = "Pressione R para ligar a radio. Use a roda do mouse para alterar o volume."
			if radioSound[source] == nil then
				outputChatBox(msg, 124, 252, 0)
			else
				if radioSound[source].soundElement == nil then
					outputChatBox(msg, 124, 252, 0)
				end
			end
		end
	end
)

addEventHandler("onClientSoundStream", root,
	function(success, length, streamName)
		if streamName then
			local veh = getPedOccupiedVehicle(getLocalPlayer())
			if veh then
				if radioSound[veh] == nil then return end
				if radioSound[veh].soundElement == source then
					outputChatBox("#696969Rádio: #22AA22 " .. streamName, 0, 0, 0, true)
				end
			end
		end
	end
)
addEventHandler("onClientSoundChangedMeta", root,
	function(streamTitle)
		if streamTitle then
			local veh = getPedOccupiedVehicle(getLocalPlayer())
			if veh then
				if radioSound[veh] == nil then return end
				if radioSound[veh].soundElement == source then
					outputChatBox("#696969Música: #AA2222 " .. streamTitle, 0, 0, 0, true)
				end
			end
		end
	end
)

addEvent("onServerToggleRadio", true)
addEventHandler("onServerToggleRadio", getLocalPlayer(), 
	function(toggle, url, veh, volume)	
		if not isElement(veh) then
			if radioSound[veh] ~= nil then
				stopSound(radioSound[veh].soundElement)
				radioSound[veh].soundElement = nil
			end
			return
		end
		
		if toggle == true then
			local x, y, z = getElementPosition(veh)
			if radioSound[veh] ~= nil then
				stopSound(radioSound[veh].soundElement)

				local sound = playSound3D(url, x, y, z)
				if volume ~= nil then
					setSoundVolume(sound, volume)
				end
				setSoundMinDistance(sound, 6.0)
				setSoundMaxDistance(sound, 25.0)
				attachElements(sound, veh)
				
				radioSound[veh] = { }
				radioSound[veh].soundElement = sound
			else
				local sound = playSound3D(url, x, y, z)
				if volume ~= nil then
					setSoundVolume(sound, volume)
				end
				setSoundMinDistance(sound, 6.0)
				setSoundMaxDistance(sound, 25.0)
				attachElements(sound, veh)
				
				radioSound[veh] = { }
				radioSound[veh].soundElement = sound
			end
		else
			if radioSound[veh] ~= nil then
				stopSound(radioSound[veh].soundElement)
				radioSound[veh].soundElement = nil
			end
		end
	end
)

addEvent("onServerRadioURLChange", true)
addEventHandler("onServerRadioURLChange", getLocalPlayer(), 
	function(newurl, veh, volume)
		if radioSound[veh] ~= nil then
			stopSound(radioSound[veh].soundElement)
		
			local x, y, z = getElementPosition(veh)
			local sound = playSound3D(newurl, x, y, z)
			if volume ~= nil then
				setSoundVolume(sound, volume)
			end
			setSoundMinDistance(radioSound, 6.)
			setSoundMaxDistance(radioSound, 25.0)
			attachElements(sound, veh)
		
			radioSound[veh] = { }
			radioSound[veh].soundElement = sound
		end
	end
)

addEvent("onServerVolumeChangeAccept", true)
addEventHandler("onServerVolumeChangeAccept", getLocalPlayer(), 
	function(veh, newVolume)
		if veh then
			if radioSound[veh] ~= nil then
				setSoundVolume(radioSound[veh].soundElement, newVolume)
			end
		end
	end
)

function clientToggleRadio()
	triggerServerEvent("onPlayerToggleRadio", getLocalPlayer())
end

function volumeUp()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if veh then
		if radioSound[veh] ~= nil then
			local volume = getSoundVolume(radioSound[veh].soundElement)
			if volume ~= false then
				triggerServerEvent("onPlayerRadioVolumeChange", getLocalPlayer(), volume, true)
			end
		end
	end
end

function volumeDown()
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if veh then
		if radioSound[veh] ~= nil then
			local volume = getSoundVolume(radioSound[veh].soundElement)
			if volume ~= false then
				triggerServerEvent("onPlayerRadioVolumeChange", getLocalPlayer(), volume, false)
			end
		end
	end
end
