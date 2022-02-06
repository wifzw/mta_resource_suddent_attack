
 function telepToObj(player)
local vehicle = getPedOccupiedVehicle(player)
setElementPosition(player, 4094,-5510,6 )
if vehicle then
setElementVelocity(vehicle,0,0,0)
setElementPosition(vehicle, 4094,-5510,6 )
end
end
addCommandHandler("drift3", telepToObj)