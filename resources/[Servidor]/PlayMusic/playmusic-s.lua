addCommandHandler('musica', function(thePlayer, commandName, nome_musica)
    if(not nome_musica) then
        return outputChatBox('Você deve selecionar uma musica! Digite #00ff00/lista #ffffffpara saber as musicas existentes', thePlayer, 255,255,255, true)
    end

    triggerClientEvent(root, 'onPlayerMusic', root , nome_musica)
end)