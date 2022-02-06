-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/


-- Discord : https://discord.gg/DzgEcvy

function limpar_chat(source)
    if ( hasObjectPermissionTo ( source, "command.mute", true ) ) then
    triggerClientEvent(root, "LimpouChat", root, getPlayerName( source ) )
	for i = 1,40 do
    i = outputChatBox(" ")
    end
    end
end
addCommandHandler("limpar", limpar_chat)


-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/


-- Discord : https://discord.gg/DzgEcvy