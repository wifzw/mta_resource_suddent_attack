-- Armas, que serão geradas
local weaponIDs = { 1, 22, 25, 28, 30, 33, 35, 16, 42, 10, 44, 40 } -- Weapon IDs

function givePlayerWeapons (thePlayer, commandName)
    -- Faz um loop em cada ID e seta uma arma

    for i = 1, #weaponIDs do
        giveWeapon(thePlayer, weaponIDs[i], 1)
    end

    -- Seleciona uma das armas (aleatóriamente)
    setPedWeaponSlot(thePlayer, math.random(1, 12))
end

addCommandHandler("armas", givePlayerWeapons)

function outputWeaponSlot (source, commandName, weaponID)
    local weaponSlot = getSlotFromWeapon(weaponID)

    if (weaponSlot) then
        outputChatBox("Weapon ID " .. weaponID .. " está no slot de arma " .. weaponSlot)
    else
        outputChatBox("ID de arma inválido")
    end
end

addCommandHandler("armaAtual", outputWeaponSlot)

addCommandHandler("resetar",
        function(player, commandName)
            takeAllWeapons(player)
            outputChatBox("#00ff00Armas resetadas com sucesso!", player, 255, 255, 255, true)
        end
)

function getM4(thePlayer, commandName)
    giveWeapon(thePlayer, 31, 9999)
    setPedWeaponSlot(thePlayer, 5)
end

addCommandHandler("m4", getM4)

function getAK(thePlayer, commandName)
    giveWeapon(thePlayer, 30, 9999)
    setPedWeaponSlot(thePlayer, 5)
end

addCommandHandler("ak", getAK)

function getHealth(player, commandName)
    local playerName = getPlayerName(player)
    setElementHealth(player, 100)
    outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff Pegou vida digitando #00ff00/vida #ffffff', getRootElement(), 255, 0, 0, true)
end

addCommandHandler("vida", getHealth)

function getArmor(player, commandName)
    local playerName = getPlayerName(player)
    setPedArmor(player, 100)
    outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff Pegou colete digitando #00ff00/colete #ffffff', getRootElement(), 255, 0, 0, true)
end

addCommandHandler("colete", getArmor)

function cmdClearChat(p, cmd)
    if not isPlayerStaff(p) then
        return
    end
    clearChatBox()
end
addCommandHandler("clear", cmdClearChat)


---- Utility function
local staffACLs = {
    aclGetGroup("Admin"),
    aclGetGroup("Moderator"),
    aclGetGroup("Console")
}

function isPlayerStaff(p)
    if isElement(p) and getElementType(p) == "player" and not isGuestAccount(getPlayerAccount(p)) then
        local object = getAccountName(getPlayerAccount(p))

        for _, group in ipairs(staffACLs) do
            if isObjectInACLGroup("user." .. object, group) then
                return true
            end
        end
    end
    return false
end

addCommandHandler( "sf",
        function (player, command, command2 )
            local playerName = getPlayerName(player)
            local positions =
            {
                { -1351.7279052734, 39.669273376465, 14.1484375 },
                { -1351.7279052734, 39.669273376465, 14.1484375 },
                { -1351.7279052734, 39.669273376465, 14.1484375 },
            }

            local calc = math.random ( #positions )
            setElementPosition(player, unpack ( positions [ calc ] ) )
            outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff foi para San Fierro digitando #00ff00/sf #ffffff', getRootElement(), 255, 0, 0, true)
        end
)

addCommandHandler( "lv",
        function (player, command, command2 )
            local playerName = getPlayerName(player)
            local positions =
            {
                { 1499.0567626953, 1480.5650634766, 10.824301719666 },
                { 1499.0567626953, 1480.5650634766, 10.824301719666 },
                { 1499.0567626953, 1480.5650634766, 10.824301719666 },
            }

            local calc = math.random ( #positions )
            setElementPosition(player, unpack ( positions [ calc ] ) )
            outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff foi para Las Venturas digitando #00ff00/lv #ffffff', getRootElement(), 255, 0, 0, true)
        end
)

addCommandHandler( "ls",
        function (player, command, command2 )
            local playerName = getPlayerName(player)
            local positions =
            {
                { 1999.9569091797, -2463.5356445312, 13.546875 },
                { 1999.9569091797, -2463.5356445312, 13.546875 },
                { 1999.9569091797, -2463.5356445312, 13.546875 },
            }

            local calc = math.random ( #positions )
            setElementPosition(player, unpack ( positions [ calc ] ) )
            outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff foi para Los Santos digitando #00ff00/ls #ffffff', getRootElement(), 255, 0, 0, true)
        end
)


addCommandHandler( "treinar34",
        function (player, command, command2 )
            if ( getElementDimension ( player ) == 0 ) then
                local positions =
                {
                    { 2831.1232910156, 2499.6752929688, 17.671875 },
                    { 2831.1232910156, 2499.6752929688, 17.671875 },
                    { 2831.1232910156, 2499.6752929688, 17.671875 },
                }

                local calc = math.random ( #positions )
                setElementPosition(player, unpack ( positions [ calc ] ) )
                setElementDimension ( player, 34 )
            end
        end
)


addCommandHandler( "praia",
        function (player, command, command2 )
            local playerName = getPlayerName(player)
            local positions =
            {
                { 337.04904174805, -1786.8078613281, 4.959939956665 },
                { 337.04904174805, -1786.8078613281, 4.959939956665 },
                { 337.04904174805, -1786.8078613281, 4.959939956665 },
            }

            local calc = math.random ( #positions )
            setElementPosition(player, unpack ( positions [ calc ] ) )
            outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff foi para Praia digitando #00ff00/praia #ffffff', getRootElement(), 255, 0, 0, true)
        end
)


addCommandHandler('cj', function(player, command)
    local playerName = getPlayerName(player)
    local positions = {
        {2493.4658203125, -1669.41015625, 13.335947036743},
        {2493.4658203125, -1669.41015625, 13.335947036743},
        {2493.4658203125, -1669.41015625, 13.335947036743}
    }

    local calc = math.random ( #positions )
    setElementPosition(player, unpack ( positions [ calc ] ) )
    outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff foi para o CJ digitando #00ff00/cj #ffffff', getRootElement(), 255, 0, 0, true)
end)


addCommandHandler('spotls', function(player, command)
    local playerName = getPlayerName(player)
    local positions = {
        {630.5234375, -1343.3330078125, 13.3828125},
        {630.5234375, -1343.3330078125, 13.3828125},
        {630.5234375, -1343.3330078125, 13.3828125}
    }

    local calc = math.random ( #positions )
    setElementPosition(player, unpack ( positions [ calc ] ) )
    outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff foi para Spotls digitando #00ff00/spotls #ffffff', getRootElement(), 255, 0, 0, true)
end)

addCommandHandler('placa', function(player, command)
    local playerName = getPlayerName(player)
    local positions = {
        {726.42578125, 2623.244140625, 21.405347824097},
        {726.42578125, 2623.244140625, 21.405347824097},
        {726.42578125, 2623.244140625, 21.405347824097}
    }

    local calc = math.random ( #positions )
    setElementPosition(player, unpack ( positions [ calc ] ) )
    outputChatBox('#ffffffO Player ' .. playerName .. '#ffffff foi para Placa (#337DFFTreinar Back-entry#ffffff) digitando #00ff00/placa #ffffff', getRootElement(), 255, 0, 0, true)
end)


