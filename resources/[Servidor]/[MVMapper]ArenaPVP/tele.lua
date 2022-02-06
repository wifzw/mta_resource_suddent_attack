local posicoes =
    {
        { 3451.5905761719, 457.06326293945, 136.50219726563},		
    }
	
function PosicaoPlayer ( thePlayer, command )
    local azar = math.random ( #posicoes )
	local veh = getPedOccupiedVehicle(thePlayer)
		if (veh) then
			setElementPosition(veh, unpack ( posicoes [ azar ] ) )
		else
			setElementPosition(thePlayer, unpack ( posicoes [ azar ] ) )
		end	
			outputChatBox ( "#ffffff[ #fff000Teleporte #ffffff] ".. getPlayerName(thePlayer) .." #ffffffFoi Para o PVP (Ele ta achando que é bom)", root, 0, 0, 0, true )
end
addCommandHandler ( "pvp", PosicaoPlayer  )