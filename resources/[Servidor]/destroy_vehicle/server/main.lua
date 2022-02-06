addEventHandler("onPlayerQuit", root, function ( )
    for i, veh in ipairs (getElementsByType("vehicle")) do
       if getElementData(veh, "Owner") == source then
          destroyVehicle ( veh )
       end
    end
 end)
 
 function destroyVehicle ( theVehicle )
    if isElement( theVehicle ) then
       destroyElement( theVehicle )
    end
 end