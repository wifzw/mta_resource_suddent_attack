-- Teleport command to map location ( /drift )

--local positions =
--    {
--        { -2930.5, 475.60546875, 4.9065704345703 },
--        { -2930.5, 475.60546875, 4.9065704345703 },
--        { -2930.5, 475.60546875, 4.9065704345703 },
--    }

local positions =
{
	{ -3311.5776367188, 872.22998046875, 320.201171875 },
	{ -3311.5776367188, 872.22998046875, 320.201171875 },
	{ -3311.5776367188, 872.22998046875, 320.201171875 },
}
	
function TPPlayer ( thePlayer, command )
    local calc = math.random ( #positions )
	local veh = getPedOccupiedVehicle(thePlayer)
		if (veh) then
			if (getPedOccupiedVehicleSeat(thePlayer) ~= 0) then return end
			setElementPosition(veh, unpack ( positions [ calc ] ) )
		else
			setElementPosition(thePlayer, unpack ( positions [ calc ] ) )
		end	
end
addCommandHandler ( "drift1", TPPlayer  )