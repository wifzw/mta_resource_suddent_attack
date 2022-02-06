--[[

© Creditos do script: #Mods MTA:SA

© Creditos da pagina postadora: DropMTA

© Discord DropMTA: https://discord.gg/GZ8DzrmxUV

Acesse nosso site de mods: https://dropmta.blogspot.com/

]]--

addEventHandler("onPlayerLogin", root, function (_,account)
    if not account.guest then
        source:setData("ID", account.id)
    end
end)

addEventHandler ("onResourceStart", resourceRoot, function()
for i, v in ipairs (getElementsByType ("player")) do
	local acc = getPlayerAccount (v)
	if not acc.guest then
		v:setData("ID", acc.id)
	end
end
end)


addEventHandler ( "onResourceStart" , resourceRoot ,
    function ( )
        for index , player in ipairs ( getElementsByType ( "player" ) ) do
            local pAccount = getPlayerAccount ( player )
            if not isGuestAccount ( pAccount ) then
                local minutes = getAccountData ( pAccount , "Online.minutes" )
                if minutes then
                    local hours = getAccountData ( pAccount , "Online.hours" )
                    if # tostring ( minutes ) == 1 then
                        minutes = "0" .. minutes
                    end
                    if # tostring ( hours ) == 1 then
                        hours = "0" .. hours
                    end
                    setElementData ( player , "Play Time" , hours .. ":" .. minutes .. "" )
                    local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
                    setElementData ( player , "Online.timer" , timer )
                else
                    setAccountData ( pAccount , "Online.minutes" , 0 )
     
              setAccountData ( pAccount , "Online.hours" , 0 )
                    setElementData ( player , "Play Time" , "00:00 " )
                    local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
                    setElementData ( player , "Online.timer" , timer )
                end
            else
                setElementData ( player , "Play Time" , "N/A" )
            end
        end
    end
)
 
addEventHandler ( "onResourceStop" , resourceRoot ,
    function ( )
        for index , player in ipairs ( getElementsByType ( "player" ) ) do
            local pAccount = getPlayerAccount ( player )
            if not isGuestAccount ( pAccount ) then
                local timer = getElementData ( player , "Online.timer" )
                if isTimer ( timer ) then
                    killTimer ( timer )
                end
            end
        end
    end
)
 
addEventHandler ( "onPlayerLogin" , root ,
    function ( _ , pAccount )
        local minutes = getAccountData ( pAccount , "Online.minutes" )
        if minutes then
            local hours = getAccountData ( pAccount , "Online.hours" )
            if # tostring ( minutes ) == 1 then
                minutes = "0" .. minutes
            end
            if # tostring ( hours ) == 1 then
                hours = "0" .. hours
            end
            setElementData ( source , "Play Time" , hours .. ":" .. minutes .. "" )
            local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , source )
            setElementData ( source , "Online.timer" , timer )
        else
            setAccountData ( pAccount , "Online.minutes" , 0 )
            setAccountData ( pAccount , "Online.hours" , 0 )
            setElementData ( source , "Play Time" , "00:00" )
            local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , source )
            setElementData ( source , "Online.timer" , timer )
        end
    end
)
 
addEventHandler ( "onPlayerLogout" , root ,
    function ( pAccount )
        local timer = getElementData ( source , "Online.timer" )
        if isTimer ( timer ) then
            killTimer ( timer )
        end
    end
)
 
addEventHandler ( "onPlayerJoin" , root ,
    function ( )
        setElementData ( source , "Play Time" , "N/A" )
    end
)
 
addEventHandler ( "onPlayerQuit" , root ,
    function ( )
        local pAccount = getPlayerAccount ( source )
        if not isGuestAccount ( pAccount ) then
            local timer = getElementData ( source , "Online.timer" )
            if isTimer ( timer ) then
                killTimer ( timer )
            end
        end
    end
)
 
function actualizarJugadorOn ( player )
    local pAccount = getPlayerAccount ( player )
    local minutes = getAccountData ( pAccount , "Online.minutes" )
    local hours = getAccountData ( pAccount , "Online.hours" )
    minutes = tostring ( tonumber ( minutes ) + 1 )
    if minutes == "60" then
        hours = tostring ( tonumber ( hours ) + 1 )
        minutes = "00"
    end
    setAccountData ( pAccount , "Online.minutes" , tonumber ( minutes ) )
    setAccountData ( pAccount , "Online.hours" , tonumber ( hours ) )
    if # tostring ( minutes ) == 1 then minutes = "0" .. minutes end
    if # tostring ( hours ) == 1 then hours = "0" .. hours end
    setElementData ( player , "Play Time" , hours .. ":" .. minutes .. "" )
    local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
    setElementData ( player , "Online.timer" , timer )
end

addEventHandler ( "onPlayerWasted", root,
    function( totalAmmo, killer, killerWeapon, bodypart, stealth )
        if killer then
            local account = getPlayerAccount ( killer )
            if killer ~= source then
                setAccountData( account,"totalkillsdeaths.Kills",tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) or 0 ) +1 )
                setElementData( killer, "T/K", tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) ) )
            end 
        else
            local accountSource = getPlayerAccount ( source )
            setAccountData( accountSource,"totalkillsdeaths.Deaths",tonumber( getAccountData(accountSource,"totalkillsdeaths.Deaths") or 0 ) +1 )
            setElementData( source, "T/D", tonumber( getAccountData( accountSource,"totalkillsdeaths.Deaths" ) ) )
        end
    end
)      
 
addEventHandler( "onPlayerLogin",root,
    function( thePreviousAccount, theCurrentAccount, autoLogin )
        local account = getPlayerAccount ( source )
        if not getAccountData( account,"totalkillsdeaths.Kills" ) and not getAccountData( account,"totalkillsdeaths.Deaths" ) then
            setAccountData( account,"totalkillsdeaths.Kills",0 )
            setAccountData( account,"totalkillsdeaths.Deaths",0 )
        end
        setElementData( source,"T/D",tonumber( getAccountData( account,"totalkillsdeaths.Deaths" ) or 0 ) )
        setElementData( source,"T/K",tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) or 0 ) )
    end
 )
 
 function onPlayerLogin ()
    local account = getPlayerAccount(source)
	if account then
	    setElementData(source,"RecordDrift",getAccountData(account,"RecordDrift"))
	end
end
addEventHandler("onPlayerLogin",getRootElement(),onPlayerLogin)

function onPlayerQuit ()
    local account = getPlayerAccount(source)
	if account then
	    setAccountData(account,"RecordDrift",getElementData(source,"RecordDrift"))
	end
end
addEventHandler("onPlayerQuit",getRootElement(),onPlayerQuit)