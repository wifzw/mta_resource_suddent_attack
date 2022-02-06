function updateLocationData()
	for k,v in pairs(getElementsByType("player")) do
		local country = exports.admin:getPlayerCountry( v ) or "Unknown"
		setElementData(v,"country",tostring(country))
		setElementData(root,"maxPlayers",getMaxPlayers())
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(), updateLocationData )

function updateClientLocationData()
	local country = exports.admin:getPlayerCountry( source ) or "Unknown"
	setElementData(source,"country",tostring(country))
	setElementData(source,"id",getFreeID())
end
addEventHandler ( "onPlayerJoin", getRootElement(), updateClientLocationData)

function getPlayerByID(id)
	local players = getElementsByType("player")
	for k,v in pairs(players) do
		if getElementData(v,"id") and getElementData(v,"id") == tonumber(id) then
			return v
		end
	end
end

function getFreeID()
	local id = 0
	repeat 
		id=id+1
	until not getPlayerByID(id)
	return id
end