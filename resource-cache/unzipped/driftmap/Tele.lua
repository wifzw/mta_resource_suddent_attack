local posicoes =
    {
        { 4741.05,-3804.71,1526.30 },
    }
	
function PosicaoPlayer ( thePlayer, command )
    local azar = math.random ( #posicoes )
	local veh = getPedOccupiedVehicle(thePlayer)
		if (veh) then
			setElementPosition(veh, unpack ( posicoes [ azar ] ) )
		else
			setElementPosition(thePlayer, unpack ( posicoes [ azar ] ) )
		end	
end
addCommandHandler ( "drift2", PosicaoPlayer  )