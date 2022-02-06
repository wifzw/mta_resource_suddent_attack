function sentenceDuel(player, weap, data, count, target)
    outputChatBox("‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾",getPlayerFromName(player),255,255,255,true)
    outputChatBox("O jogador #FFFF00"..getPlayerName(target).." #FFFFFFConvidou você para um duelo.",getPlayerFromName(player),255,255,255,true)
    outputChatBox("Arma usada no duelo: #1E90FF"..weap,getPlayerFromName(player),255,255,255,true)
    outputChatBox("Valor: #00FF00"..count.." #FFFFFFр.",getPlayerFromName(player),255,255,255,true)
    outputChatBox("________________________________________________",getPlayerFromName(player),255,255,255,true)
    triggerClientEvent(getPlayerFromName(player), "wndSentence", getPlayerFromName(player), player, weap, data, count, target)
end
addEvent("sentenceDuel", true)
addEventHandler("sentenceDuel", resourceRoot, sentenceDuel)

function decisionDuel(player, weap, data, count, target, num)
    if num == 1 then
        outputChatBox("Você finalizou um duelo com sucesso.",getPlayerFromName(player),0,255,0,true)
        outputChatBox("O jogador "..player.." #FFFFFFAceitou sua proposta para o duelo.",target,0,255,0,true)
        
        removePedFromVehicle(getPlayerFromName(player))
        removePedFromVehicle(target)
        
        setElementFrozen(getPlayerFromName(player), true)
        setElementFrozen(target, true)
        
        setElementPosition(getPlayerFromName(player), playerOne[1], playerOne[2], playerOne[3])
        setElementPosition(target, playerTwo[1], playerTwo[2], playerTwo[3])
        
        setElementRotation(getPlayerFromName(player),0,0,220)
        setElementRotation(target,0,0,20)
        
        setElementHealth(getPlayerFromName(player),100)
        setElementHealth(target,100)

        giveWeapon(getPlayerFromName(player), data[1], 200)
        giveWeapon(target, data[1], 200)
        
        setPedWeaponSlot(getPlayerFromName(player), data[2])
        setPedWeaponSlot(target, data[2])
        
        toggleControl(getPlayerFromName(player), "aim_weapon", false)
        toggleControl(target, "aim_weapon", false)
        
        toggleControl(getPlayerFromName(player), "next_weapon", false)
        toggleControl(target, "next_weapon", false)
        toggleControl(getPlayerFromName(player), "previous_weapon", false)
        toggleControl(target, "previous_weapon", false)
        
        setElementData(getPlayerFromName(player),"Duel",true)
        setElementData(target,"Duel",true)
        
        triggerClientEvent(getPlayerFromName(player), "duelTimer", getPlayerFromName(player))
        triggerClientEvent(target, "duelTimer", target)
        
        setTimer(function()
            setElementFrozen(getPlayerFromName(player), false)
            setElementFrozen(target, false)
            
            toggleControl(getPlayerFromName(player), "aim_weapon", true)
            toggleControl(target, "aim_weapon", true)
            
            outputChatBox("O duelo começou boa sorte.",getPlayerFromName(player),0,255,0,true)
            outputChatBox("O duelo começou boa sorte.",target,0,255,0,true)
        end, duelTimeLimit*1000, 1)
        
        function player_Wasted(ammo, attacker, weapon)
            if (attacker) then
                for i, v in pairs ( getElementsByType( "player" ) ) do
                    if getElementData(v,"Duel") then
                        if ( getElementType ( attacker ) == "player" ) then
                            outputChatBox(getPlayerName(attacker).." #FFFFFFMorto "..getPlayerName(source).." #FFFFFFVenceu o duelo.",getPlayerFromName(player),0,255,0,true)
                            outputChatBox(getPlayerName(attacker).." #FFFFFFMorto "..getPlayerName(source).." #FFFFFFVenceu o duelo.",target,0,255,0,true)
                            
                            outputChatBox("Seus ganhos: #00FF00"..count.." #FFFFFF.",attacker,255,255,255,true)
                            outputChatBox("Você deu #FF0000"..count.." #FFFFFF.",source,255,255,255,true)
                            
                            takeWeapon(getPlayerFromName(player), data[1])
                            takeWeapon(target, data[1])
                            
                            givePlayerMoney(attacker,count)
                            takePlayerMoney(source,count)
                            
                            setTimer(function()
                                setElementPosition(getPlayerFromName(player), CompletionDuel[1], CompletionDuel[2], CompletionDuel[3])
                                setElementPosition(target, CompletionDuel[1], CompletionDuel[2], CompletionDuel[3])
                            end, 5000, 1)
                            
                            toggleControl(getPlayerFromName(player), "next_weapon", true)
                            toggleControl(target, "next_weapon", true)
                            toggleControl(getPlayerFromName(player), "previous_weapon", true)
                            toggleControl(target, "previous_weapon", true)
                            
                            setElementData(getPlayerFromName(player),"Duel",false)
                            setElementData(target,"Duel",false)
                        end
                    end
                end
            end
        end
        addEventHandler("onPlayerWasted", getRootElement(), player_Wasted)

    elseif num == 2 then
        outputChatBox("Você recusou um duelo.",getPlayerFromName(player),255,0,0,true)
        outputChatBox("O jogador "..player.." #FFFFFFRecusou o duelo.",target,255,0,0,true)
    end
end
addEvent("decisionDuel", true)
addEventHandler("decisionDuel", resourceRoot, decisionDuel)