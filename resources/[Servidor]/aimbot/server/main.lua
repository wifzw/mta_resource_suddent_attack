AclPermitidas = { "Console", "Admin" } -- ACL grupo


local activeAim = false
local attacker_admin = {}

addCommandHandler('aimbot', function(thePlayer, _)
    local Player = getPlayerName(thePlayer)

    if isAdmin(thePlayer) then

        --local acc = getPlayerAccount(thePlayer)
        --local accName = getAccountName(acc)

        if activeAim == false then
            triggerClientEvent("playSoundActive", thePlayer)
            table.insert(attacker_admin, Player)
        else
            triggerClientEvent("playSoundDisable", thePlayer)
        end

        activeAim = not activeAim




        triggerClientEvent(thePlayer, 'verificaJogador', thePlayer, attacker_admin)
    else
        for _, v in ipairs(getElementsByType("player")) do
            local acc = getPlayerAccount(v)
            if acc and not isGuestAccount(acc) then
                local accName = getAccountName(acc)
                local isAdminn = isObjectInACLGroup("user." .. accName, aclGetGroup("Admin"))
                if isAdminn then
                    outputChatBox('O Player ' .. Player .. '#ffffff tentou acessar o script #00ff00/aimbot!', v, 255, 255, 255, true)
                end
            end
        end
    end
end)

function isAdmin (thePlayer)
    local account = getPlayerAccount(thePlayer)
    local access_script = false

    for _, acl_permitida in ipairs(AclPermitidas) do

        if isObjectInACLGroup("user." .. getAccountName(account), aclGetGroup(acl_permitida)) then
            access_script = true
            break
        end
    end

    return access_script
end


