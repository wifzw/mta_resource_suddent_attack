function addBox(player, type, message)
    if (isElement(player)) and (tostring(type)) and (tostring(message)) then 
        triggerClientEvent(player, 'addBox', player, type, message)
    end 
end