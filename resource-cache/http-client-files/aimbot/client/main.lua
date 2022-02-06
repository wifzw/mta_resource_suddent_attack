permission_accept = false
local attacker_admin = {}

addEvent('activeAimbot', true)
addEvent('playSoundActive', true)
addEvent('playSoundDisable', true)

addEvent('verificaJogador', true)

function setPlayerSoundOn(thePlayer)
    local namePlayer = getPlayerName(thePlayer)
    local sound = playSound("sfx/sound1.mp3", thePlayer)
    setSoundVolume(sound, 0.1)
end

function setPlayerSoundOff(thePlayer, command)
    local sound = playSound("sfx/sound0.mp3", thePlayer)
    setSoundVolume(sound, 0.1)
end



function verificaAdmin (lista)
    attacker_admin = lista
end


function sendHeadshot (attacker, weapon, bodypart, loss)
    local PlayerName = getPlayerName(attacker)
    outputChatBox(inspect(PlayerName))
    outputChatBox(inspect(attacker_admin))

    for _, player_permitido in ipairs(attacker_admin) do
        if player_permitido ~= '' and player_permitido ~= nil and PlayerName == player_permitido then
            triggerServerEvent( "onServerHeadshot", getRootElement(), source, attacker, weapon, loss )
            setElementHealth ( source, 0 )
            setPedHeadless( source, true )
            break
        end
    end


    --outputChatBox(inspect(attacker))
    --triggerServerEvent( "onServerHeadshot", getRootElement(), source, attacker, weapon, loss )
    --setElementHealth ( source, 0 )
    --setPedHeadless( source, true )

end

addEventHandler("onClientPedDamage", root, sendHeadshot)
addEventHandler("onClientPlayerDamage", root, sendHeadshot)

addEventHandler('playSoundActive', localPlayer, setPlayerSoundOn)
addEventHandler('playSoundDisable', localPlayer, setPlayerSoundOff)
addEventHandler("verificaJogador", localPlayer , verificaAdmin)
