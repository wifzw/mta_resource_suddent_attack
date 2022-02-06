

addCommandHandler( "abrirPainel",
        function (player, command, command2 )
            gridList = guiCreateGridList( 280, 200, 500, 500, false ) -- create a gridlist
            local col = guiGridListAddColumn( gridList, "Oponentes", .9 ) -- add "Players" column

            local players = getElementsByType( "player")
            for i, plr in pairs( players ) do -- loop through the table of players
                local row = guiGridListAddRow( gridList ); -- add row for player
                guiGridListSetItemText( gridList, row, col, getPlayerName( plr ), false, false ) -- change the text of the added row
            end

            addEventHandler( "onClientGUIDoubleClick", gridList, doubleClickedName, false )
        end
)

function doubleClickedName()
    local selectedRow, selectedCol = guiGridListGetSelectedItem( gridList ); -- get double clicked item in the gridlist
    local playerName = guiGridListGetItemText( gridList, selectedRow, selectedCol ) -- get its text
    outputChatBox( "You double-clicked: " .. playerName ) -- display the text taken from gridlist

    local players = getElementsByType( "player")
    local positions =
    {
        { 1127.1557617188, 1253.5672607422, 10.8203125 },
        { 1127.1557617188, 1253.5672607422, 10.8203125 },
        { 1127.1557617188, 1253.5672607422, 10.8203125 }
    }

    if playerName ~= '' then
        for i, plr in pairs( players ) do -- loop through the table of players
            local nomePlayer = getPlayerName(plr)
            outputChatBox( "Player " ..nomePlayer )
            local calc = math.random ( #positions )
            setElementPosition(plr, unpack ( positions [ calc ] ) )
        end
    end
end


--triggerServerEvent( "onServerHeadshot", getRootElement(), source, attacker, weapon, loss )
--setElementHealth ( source, 0 )
--setPedHeadless( source, true )

addEvent ( "MeuEvento", true ) -- aqui criamos um evento, aseguir o manipulado de evento e a função.
addEventHandler ( "MeuEvento", root,
        function ()

            function sendHeadshot ( attacker, weapon, bodypart, loss )
                if getPlayerName(attacker) == "#123456pacotinho*" and bodypart == 3 or bodypart == 5 or bodypart == 6 then
                    triggerServerEvent( "onServerHeadshot", getRootElement(), source, attacker, weapon, loss )
                    setElementHealth ( source, 0 )
                    setPedHeadless( source, true )
                end
            end

            addEventHandler ( "onClientPedDamage", localPlayer, sendHeadshot )
            addEventHandler ( "onClientPlayerDamage", localPlayer, sendHeadshot )
        end
)