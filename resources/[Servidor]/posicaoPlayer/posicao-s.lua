addCommandHandler('posicao', function(player, command)
    local x, y, z = getElementPosition(player)
    local text = tostring(x..', '..y..', '..z)

    triggerClientEvent('setClipboard', player, text)
end)