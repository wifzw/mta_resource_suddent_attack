 --[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_spectator.lua
*
*	Original File by lil_Toady
*
**************************************]]

aSpectator = { Offset = 5, AngleX = 0, AngleZ = 30, Spectating = nil }

function aSpectate ( player )
	--if ( player == getLocalPlayer() ) then
	--	aMessageBox ( "Aviso", "Voce só pode ver a outros jogadores!" )
		--return
	--end
	aSpectator.Spectating = player
    setElementFrozen ( getLocalPlayer(), true )
	if ( ( not aSpectator.Actions ) or ( not guiGetVisible ( aSpectator.Actions ) ) ) then
		aSpectator.Initialize ()
	end
end

function aSpectator.Initialize ()
	if ( aSpectator.Actions == nil ) then
		local x, y = guiGetScreenSize()
		aSpectator.Actions		= guiCreateWindow ( x - 190, y / 2 - 200, 160, 400, "Ações", false )
						guiSetProperty(aSpectator.Actions, "CaptionColour", "FF00ffff") 
		aSpectator.Ban			= guiCreateButton ( 0.10, 0.09, 0.80, 0.05, "Banir", true, aSpectator.Actions )
				guiSetProperty(aSpectator.Ban, "NormalTextColour", "FF00FFBB")
		aSpectator.Kick			= guiCreateButton ( 0.10, 0.15, 0.80, 0.05, "Expulsar", true, aSpectator.Actions )
				guiSetProperty(aSpectator.Kick, "NormalTextColour", "FF00FFBB")
		aSpectator.Freeze			= guiCreateButton ( 0.10, 0.21, 0.80, 0.05, "Congelar", true, aSpectator.Actions )
				guiSetProperty(aSpectator.Freeze, "NormalTextColour", "FF00FFBB")
		aSpectator.SetSkin		= guiCreateButton ( 0.10, 0.27, 0.80, 0.05, "Skin", true, aSpectator.Actions )
				guiSetProperty(aSpectator.SetSkin, "NormalTextColour", "FF00FFBB")
		aSpectator.SetHealth		= guiCreateButton ( 0.10, 0.33, 0.80, 0.05, "Vida", true, aSpectator.Actions )
				guiSetProperty(aSpectator.SetHealth, "NormalTextColour", "FF00FFBB")
		aSpectator.SetArmour		= guiCreateButton ( 0.10, 0.39, 0.80, 0.05, "Colete", true, aSpectator.Actions )
				guiSetProperty(aSpectator.SetArmour, "NormalTextColour", "FF00FFBB")
		aSpectator.SetStats		= guiCreateButton ( 0.10, 0.45, 0.80, 0.05, "Habilidades", true, aSpectator.Actions )
				guiSetProperty(aSpectator.SetStats, "NormalTextColour", "FF00FFBB")
		aSpectator.Slap			= guiCreateButton ( 0.10, 0.51, 0.80, 0.05, "Slap! "..aCurrentSlap.."hp", true, aSpectator.Actions )
				guiSetProperty(aSpectator.Slap	, "NormalTextColour", "FF00FFBB")
		aSpectator.Slaps			= guiCreateGridList ( 0.10, 0.51, 0.80, 0.48, true, aSpectator.Actions )	
					  		  guiGridListAddColumn( aSpectator.Slaps, "", 0.85 )
					  		  guiSetVisible ( aSpectator.Slaps, false )
		local i = 0
		while i <= 10 do
			guiGridListSetItemText ( aSpectator.Slaps, guiGridListAddRow ( aSpectator.Slaps ), 1, tostring ( i * 10 ), false, false )
			i = i + 1
		end
		
		aSpectator.Skip			= guiCreateCheckBox ( 0.08, 0.85, 0.84, 0.04, "Jogadores mortos", false, true, aSpectator.Actions )
				guiSetFont ( aSpectator.Skip, "default-bold-small" )
		guiSetProperty(aSpectator.Skip, "NormalTextColour", "FFFF0000")
					  		  guiCreateLabel ( 0.08, 0.89, 0.84, 0.04, "____________________", true, aSpectator.Actions )
		aSpectator.Back			= guiCreateButton ( 0.10, 0.93, 0.80, 0.05, "Voltar", true, aSpectator.Actions )
					guiSetProperty(aSpectator.Back		, "NormalTextColour", "FF00FFBB")
		aSpectator.Players		= guiCreateWindow ( 30, y / 2 - 200, 160, 400, "Jogadores", false )
			guiSetProperty(aSpectator.Players, "CaptionColour", "FF00ffff") 
			  	  	  		  guiWindowSetSizable ( aSpectator.Players, false )
		aSpectator.PlayerList		= guiCreateGridList ( 0.03, 0.07, 0.94, 0.92, true, aSpectator.Players )
		guiSetFont ( aSpectator.PlayerList, "default-bold-small" )
					  		  guiGridListAddColumn( aSpectator.PlayerList, "Nomes", 0.85 )
		for id, player in ipairs ( getElementsByType ( "player" ) ) do
			local row = guiGridListAddRow ( aSpectator.PlayerList )
			guiGridListSetItemPlayerName ( aSpectator.PlayerList, row, 1, getPlayerName ( player ), false, false )
			if ( player == aSpectator.Spectating ) then guiGridListSetSelectedItem ( aSpectator.PlayerList, row, 1 ) end
		end
		aSpectator.Prev			= guiCreateButton ( x / 2 - 100, y - 50, 70, 30, "< Voltar", false )
							guiSetProperty(aSpectator.Prev		, "NormalTextColour", "FF00FFBB")
		aSpectator.Next			= guiCreateButton ( x / 2 + 30,  y - 50, 70, 30, "Próximo >", false )
							guiSetProperty(aSpectator.Next			, "NormalTextColour", "FF00FFBB")

		addEventHandler ( "onClientGUIClick", _root, aSpectator.ClientClick )
		addEventHandler ( "onClientGUIDoubleClick", _root, aSpectator.ClientDoubleClick )

		aRegister ( "Spectator", aSpectator.Actions, aSpectator.ShowGUI, aSpectator.Close )
	end

	bindKey ( "arrow_l", "down", aSpectator.SwitchPlayer, -1 )
	bindKey ( "arrow_r", "down", aSpectator.SwitchPlayer, 1 )
	bindKey ( "mouse_wheel_up", "down", aSpectator.MoveOffset, -1 )
	bindKey ( "mouse_wheel_down", "down", aSpectator.MoveOffset, 1 )
	bindKey ( "mouse2", "both", aSpectator.Cursor )
    toggleControl ( "fire", false )
    toggleControl ( "aim_weapon", false )
	addEventHandler ( "onClientPlayerWasted", _root, aSpectator.PlayerCheck )
	addEventHandler ( "onClientPlayerQuit", _root, aSpectator.PlayerCheck )
	addEventHandler ( "onClientCursorMove", _root, aSpectator.CursorMove )
	addEventHandler ( "onClientPreRender", _root, aSpectator.Render )
	
	guiSetVisible ( aSpectator.Actions, true )
	guiSetVisible ( aSpectator.Players, true )
	guiSetVisible ( aSpectator.Next, true )
	guiSetVisible ( aSpectator.Prev, true )
	aAdminMenuClose ( false )
end

function aSpectator.Cursor ( key, state )
	if state == "down" then
		showCursor(true)
	else
		showCursor(false)
	end
end

function aSpectator.Close ( destroy )
    if ( aSpectator.Spectating ) then
        unbindKey ( "arrow_l", "down", aSpectator.SwitchPlayer, -1 )
        unbindKey ( "arrow_r", "down", aSpectator.SwitchPlayer, 1 )
        unbindKey ( "mouse_wheel_up", "down", aSpectator.MoveOffset, -1 )
        unbindKey ( "mouse_wheel_down", "down", aSpectator.MoveOffset, 1 )
        unbindKey ( "mouse2", "both", aSpectator.Cursor )
        toggleControl ( "fire", true )
        toggleControl ( "aim_weapon", true )
        removeEventHandler ( "onClientPlayerWasted", _root, aSpectator.PlayerCheck )
        removeEventHandler ( "onClientPlayerQuit", _root, aSpectator.PlayerCheck )
        removeEventHandler ( "onClientMouseMove", _root, aSpectator.CursorMove )
        removeEventHandler ( "onClientPreRender", _root, aSpectator.Render )

        if ( ( destroy ) or ( guiCheckBoxGetSelected ( aPerformanceSpectator ) ) ) then
            if ( aSpectator.Actions ) then
                removeEventHandler ( "onClientGUIClick", _root, aSpectator.ClientClick )
                removeEventHandler ( "onClientGUIDoubleClick", _root, aSpectator.ClientDoubleClick )
                destroyElement ( aSpectator.Actions )
                destroyElement ( aSpectator.Players )
                destroyElement ( aSpectator.Next )
                destroyElement ( aSpectator.Prev )
                aSpectator.Actions = nil
            end
        else
            guiSetVisible ( aSpectator.Actions, false )
            guiSetVisible ( aSpectator.Players, false )
            guiSetVisible ( aSpectator.Next, false )
            guiSetVisible ( aSpectator.Prev, false )
        end
        setCameraTarget ( getLocalPlayer() )
        local x, y, z = getElementPosition(getLocalPlayer())
        setElementPosition(getLocalPlayer(), x, y, z+1)
        setElementVelocity (getLocalPlayer(), 0, 0, 0)
        setElementFrozen ( getLocalPlayer(), false )
        aSpectator.Spectating = nil
        showCursor ( true )
        aAdminMenu()
    end
end

function aSpectator.ClientDoubleClick ( button )
	if ( source == aSpectator.Slaps ) then
		if ( guiGridListGetSelectedItem ( aSpectator.Slaps ) ~= -1 ) then
			aCurrentSlap = guiGridListGetItemText ( aSpectator.Slaps, guiGridListGetSelectedItem ( aSpectator.Slaps ), 1 )
			guiSetText ( aTab1.Slap, "Slap! "..aCurrentSlap.."hp" )
			guiSetText ( aSpectator.Slap, "Slap! "..aCurrentSlap.."hp" )
		end
		guiSetVisible ( aSpectator.Slaps, false )
	end
end

function aSpectator.ClientClick ( button )
	if ( source == aSpectator.Slaps ) then return end
	guiSetVisible ( aSpectator.Slaps, false )
	if ( button == "left" ) then
		if ( source == aSpectator.Back ) then aSpectator.Close ( false )
		elseif ( source == aSpectator.Ban ) then triggerEvent ( "onClientGUIClick", aTab1.Ban, "left" )
		elseif ( source == aSpectator.Kick ) then triggerEvent ( "onClientGUIClick", aTab1.Kick, "left" )
		elseif ( source == aSpectator.Freeze ) then triggerEvent ( "onClientGUIClick", aTab1.Freeze, "left" )
		elseif ( source == aSpectator.SetSkin ) then triggerEvent ( "onClientGUIClick", aTab1.SetSkin, "left" )
		elseif ( source == aSpectator.SetHealth ) then triggerEvent ( "onClientGUIClick", aTab1.SetHealth, "left" )
		elseif ( source == aSpectator.SetArmour ) then triggerEvent ( "onClientGUIClick", aTab1.SetArmour, "left" )
		elseif ( source == aSpectator.SetStats ) then triggerEvent ( "onClientGUIClick", aTab1.SetStats, "left" )
		elseif ( source == aSpectator.Slap ) then triggerEvent ( "onClientGUIClick", aTab1.Slap, "left" )
		elseif ( source == aSpectator.Next ) then aSpectator.SwitchPlayer ( 1 )
		elseif ( source == aSpectator.Prev ) then aSpectator.SwitchPlayer ( -1 )
		elseif ( source == aSpectator.PlayerList ) then
			if ( guiGridListGetSelectedItem ( source ) ~= -1 ) then
				aSpectate ( getPlayerFromNick ( guiGridListGetItemPlayerName ( source, guiGridListGetSelectedItem ( source ), 1 ) ) )
			end
		end
	elseif ( button == "right" ) then
		if ( source == aSpectator.Slap ) then
			guiSetVisible ( aSpectator.Slaps, true )
		else
			local show = not isCursorShowing()
			guiSetVisible ( aSpectator.Actions, show )
			guiSetVisible ( aSpectator.Players, show )
			guiSetVisible ( aSpectator.Next, show )
			guiSetVisible ( aSpectator.Prev, show )
			showCursor ( show )
		end
	end
end

function aSpectator.PlayerCheck ()
	if ( source == aSpectator.Spectating ) then
		aSpectator.SwitchPlayer ( 1 )
	end
end

function aSpectator.SwitchPlayer ( inc, arg, inc2 )
	if ( not tonumber ( inc ) ) then inc = inc2 end
	if ( not tonumber ( inc ) ) then return end
	local players = {}
	if ( guiCheckBoxGetSelected ( aSpectator.Skip ) ) then players = aSpectator.GetAlive()
	else players = getElementsByType ( "player" ) end
	if ( #players <= 0 ) then
		aMessageBox ( "question", "Você não esta vendo niguem, deseja sair?", "spectatorClose" )
		return
	end
	local current = 1
	for id, player in ipairs ( players ) do
		if ( player == aSpectator.Spectating ) then
			current = id
		end
	end
	local next = ( ( current - 1 + inc ) % #players ) + 1
	if ( next == current ) then
		aMessageBox ( "question", "Você não esta vendo niguem, deseja sair?", "spectatorClose" )
		return
	end
	aSpectator.Spectating = players[next]
    setElementFrozen ( getLocalPlayer(), true )
end

function aSpectator.CursorMove ( rx, ry, x, y )
	if ( not isCursorShowing() ) then
		local sx, sy = guiGetScreenSize ()
		aSpectator.AngleX = ( aSpectator.AngleX + ( x - sx / 2 ) / 10 ) % 360
		aSpectator.AngleZ = ( aSpectator.AngleZ + ( y - sy / 2 ) / 10 ) % 360
		if ( aSpectator.AngleZ > 180 ) then
			if ( aSpectator.AngleZ < 315 ) then aSpectator.AngleZ = 315 end
		else
			if ( aSpectator.AngleZ > 45 ) then aSpectator.AngleZ = 45 end
		end
	end
end

function aSpectator.Render ()
	local sx, sy = guiGetScreenSize ()
	if ( not aSpectator.Spectating ) then
		dxDrawText ( "Não há jogador para assistir", sx - 170, 200, sx - 170, 200, tocolor ( 255, 0, 0, 255 ), 1 )
		return
	end

	local x, y, z = getElementPosition ( aSpectator.Spectating )

	if ( not x ) then
		dxDrawText ( "Erro, ao obter as cordenadas", sx - 170, 200, sx - 170, 200, tocolor ( 255, 0, 0, 255 ), 1 )
		return
	end

	local ox, oy, oz
	ox = x - math.sin ( math.rad ( aSpectator.AngleX ) ) * aSpectator.Offset
	oy = y - math.cos ( math.rad ( aSpectator.AngleX ) ) * aSpectator.Offset
	oz = z + math.tan ( math.rad ( aSpectator.AngleZ ) ) * aSpectator.Offset
	setCameraMatrix ( ox, oy, oz, x, y, z )

	local sx, sy = guiGetScreenSize ()
		local name = getPlayerName(aSpectator.Spectating)
	dxDrawColorText ( "Você esta assistindo: "..name, sx - 750, 200, sx - 170, 200, tocolor ( 255, 255, 255, 255 ), 1.5 ,"default-bold")

	--dxDrawText ( "Assistindo: "..getPlayerName ( aSpectator.Spectating ):gsub( "#%x%x%x%x%x%x", "" ), sx - 170, 200, sx - 170, 200, tocolor ( 255, 255, 255, 255 ), 1 ,"default-bold")
	if ( _DEBUG ) then
		dxDrawText ( "DEBUG:\nAngleX: "..aSpectator.AngleX.."\nAngleZ: "..aSpectator.AngleZ.."\n\nOffset: "..aSpectator.Offset.."\nX: "..ox.."\nY: "..oy.."\nZ: "..oz.."\nDist: "..getDistanceBetweenPoints3D ( x, y, z, ox, oy, oz ), sx - 170, sy - 180, sx - 170, sy - 180, tocolor ( 255, 255, 255, 255 ), 1 )
	else
		if ( isCursorShowing () ) then
		--	dxDrawText ( "Dica: Mouse2 - alternar o modo de câmera livre.", 20, sy - 50, 20, sy - 50, tocolor ( 255, 255, 255, 255 ), 1.5 )
		else
			dxDrawText ( "Dica: Use a roda do mouse para zoom.", 20, sy - 50, 20, sy - 50, tocolor ( 255, 255, 255, 255 ), 1.5 )
		end
	end
end

function aSpectator.MoveOffset ( key, state, inc )
	if ( not isCursorShowing() ) then
		aSpectator.Offset = aSpectator.Offset + tonumber ( inc )
		if ( aSpectator.Offset > 70 ) then aSpectator.Offset = 70
		elseif ( aSpectator.Offset < 2 ) then aSpectator.Offset = 2 end
	end
end

function aSpectator.GetAlive ()
	local alive = {}
	for id, player in ipairs ( getElementsByType ( "player" ) ) do
    if ( not isPedDead ( player ) ) then
			table.insert ( alive, player )
		end
	end
	return alive
end

function dxDrawColorText(str, ax, ay, bx, by, color, scale, font)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  while s do
    if cap == "" and col then
      color = tocolor(tonumber("0x" .. col:sub(1, 2)), tonumber("0x" .. col:sub(3, 4)), tonumber("0x" .. col:sub(5, 6)), 255)
    end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
      ax = ax + w
      color = tocolor(tonumber("0x" .. col:sub(1, 2)), tonumber("0x" .. col:sub(3, 4)), tonumber("0x" .. col:sub(5, 6)), 255)
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str then
    cap = str:sub(last)
    local w = dxGetTextWidth(cap, scale, font)
    dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
  end
end