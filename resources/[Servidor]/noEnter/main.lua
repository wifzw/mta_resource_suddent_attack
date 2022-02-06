


function bloquear (player, command)
    function enterVehicle ( player, seat, jacked )
        cancelEvent( true )
        outputChatBox ( "Veiculos bloqueados!", player )
    end
    addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )
end

addCommandHandler("bloquear", bloquear)