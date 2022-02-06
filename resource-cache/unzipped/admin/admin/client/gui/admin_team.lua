--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_team.lua
*
*	Original File by lil_Toady
*
**************************************]]

aTeamForm = nil
aTeamSelect = nil

function aPlayerTeam ( player )
	if ( aTeamForm == nil ) then
		local x, y = guiGetScreenSize()
		aTeamForm		= guiCreateWindow ( x / 2 - 150, y / 2 - 125, 300, 250, "..:: Gerenciamento de Equipes ::..", false )
				guiSetProperty(aTeamForm, "CaptionColour", "FF00ffff")
		aTeamLabel		= guiCreateLabel ( 0.03, 0.09, 0.94, 0.07, "Escolha uma equipe da lista, ou crie uma", true, aTeamForm )
				guiSetFont ( aTeamLabel, "default-bold-small" )
		guiSetProperty(aTeamLabel, "NormalTextColour", "FFFF0000")
					  guiLabelSetHorizontalAlign ( aTeamLabel, "center" )
					  guiLabelSetColor ( aTeamLabel, 255, 0, 0 )
		aTeamList		= guiCreateGridList ( 0.03, 0.18, 0.50, 0.71, true, aTeamForm )
					  guiGridListAddColumn( aTeamList, "Equipes", 0.85 )
					  
					  guiSetFont ( aTeamList, "default-bold-small" )
		aTeamRefresh		= guiCreateButton ( 0.03, 0.90, 0.50, 0.08, "Atualizar", true, aTeamForm )
					guiSetProperty(aTeamRefresh, "NormalTextColour", "FF00FFBB")	
		aTeamNew		= guiCreateButton ( 0.55, 0.18, 0.42, 0.09, "Nova Equipe", true, aTeamForm, "createteam" )
					guiSetProperty(aTeamNew, "NormalTextColour", "FF00FFBB")	
		aTeamDelete		= guiCreateButton ( 0.55, 0.28, 0.42, 0.09, "Deletar Equipe", true, aTeamForm, "destroyteam" )
					guiSetProperty(aTeamDelete, "NormalTextColour", "FF00FFBB")	
		aTeamShowColor	= guiCreateCheckBox ( 0.55, 0.38, 0.42, 0.09, "Mostar cores", true, true, aTeamForm )
				guiSetFont ( aTeamShowColor, "default-bold-small" )
		guiSetProperty(aTeamShowColor, "NormalTextColour", "FFFF0000")
		aTeamNameLabel	= guiCreateLabel 	( 0.55, 0.19, 0.42, 0.07, "Nome:", true, aTeamForm )
		guiLabelSetColor ( aTeamNameLabel, 255, 255, 255 )
		guiSetFont ( aTeamNameLabel, "default-bold-small" )
		aTeamColor		= guiCreateLabel 	( 0.55, 0.37, 0.42, 0.11, "Cor:", true, aTeamForm )
		guiLabelSetColor ( aTeamColor, 255, 255, 255 )
		guiSetFont ( aTeamColor, "default-bold-small" )
		aTeamR		= guiCreateLabel 	( 0.70, 0.37, 0.42, 0.11, "R:", true, aTeamForm )
		guiLabelSetColor ( aTeamR, 255, 0, 0 )
		guiSetFont ( aTeamR, "default-bold-small" )
		aTeamG		= guiCreateLabel 	( 0.70, 0.48, 0.42, 0.11, "G:", true, aTeamForm )
		guiLabelSetColor ( aTeamG, 0, 255, 0 )
		guiSetFont ( aTeamG, "default-bold-small" )		
		aTeanB			= guiCreateLabel 	( 0.70, 0.59, 0.42, 0.11, "B:", true, aTeamForm )
		guiLabelSetColor ( aTeanB, 0, 0, 255 )
		guiSetFont ( aTeanB, "default-bold-small" )			
		aTeamName		= guiCreateEdit 	( 0.55, 0.26, 0.42, 0.10, "", true, aTeamForm )
		aTeamRed		= guiCreateEdit 	( 0.80, 0.36, 0.15, 0.10, "0", true, aTeamForm )
				guiSetFont ( aTeamRed, "default-bold-small" )	
		aTeamGreen		= guiCreateEdit 	( 0.80, 0.47, 0.15, 0.10, "0", true, aTeamForm )
				guiSetFont ( aTeamGreen, "default-bold-small" )	
		aTeamBlue		= guiCreateEdit 	( 0.80, 0.58, 0.15, 0.10, "0", true, aTeamForm )
				guiSetFont ( aTeamBlue, "default-bold-small" )	
		aTeamCreate		= guiCreateButton ( 0.55, 0.73, 0.20, 0.09, "Criar", true, aTeamForm, "createteam" )
					guiSetProperty(aTeamCreate, "NormalTextColour", "FF00FFBB")	
		aTeamCancel		= guiCreateButton ( 0.77, 0.73, 0.20, 0.09, "Cancelar", true, aTeamForm )
					guiSetProperty(aTeamCancel, "NormalTextColour", "FF00FFBB")	
		aTeamAccept		= guiCreateButton ( 0.55, 0.88, 0.20, 0.09, "Confirmar", true, aTeamForm )
					guiSetProperty(aTeamAccept, "NormalTextColour", "FF00FFBB")	
		aTeamClose		= guiCreateButton ( 0.77, 0.88, 0.20, 0.09, "Fechar", true, aTeamForm )
					guiSetProperty(aTeamClose, "NormalTextColour", "FF00FFBB")	
		aTeamRemove		= guiCreateButton ( 0.55, 0.78, 0.42, 0.09, "Remover da Equipe", true, aTeamForm )
					guiSetProperty(aTeamRemove, "NormalTextColour", "FF00FFBB")	
		addEventHandler ( "onClientGUIClick", aTeamForm, aClientTeamClick )
		addEventHandler ( "onClientGUIDoubleClick", aTeamForm, aClientTeamDoubleClick )
		--Register With Admin Form
		aRegister ( "PlayerTeam", aTeamForm, aPlayerTeam, aPlayerTeamClose )
	end
	aTeamSelect = player
	aTeamsRefresh ()
	guiSetVisible ( aTeamForm, true )
	guiBringToFront ( aTeamForm )
	aNewTeamShow ( false )
end

function aPlayerTeamClose ( destroy )
	if ( ( destroy ) or ( guiCheckBoxGetSelected ( aPerformanceTeam ) ) ) then
		if ( aTeamForm ) then
			removeEventHandler ( "onClientGUIClick", aTeamForm, aClientTeamClick )
			removeEventHandler ( "onClientGUIDoubleClick", aTeamForm, aClientTeamDoubleClick )
			destroyElement ( aTeamForm )
			aTeamForm = nil
		end
	else
		guiSetVisible ( aTeamForm, false )
	end
end

function aClientTeamDoubleClick ( button )
	if ( button == "left" ) then
		if ( source == aTeamList ) then
			if ( guiGridListGetSelectedItem ( aTeamList ) ~= -1 ) then
				local team = guiGridListGetItemText ( aTeamList, guiGridListGetSelectedItem ( aTeamList ), 1 )
				triggerServerEvent ( "aPlayer", getLocalPlayer(), aTeamSelect, "setteam", getTeamFromName ( team ) )
				aPlayerTeamClose ( false )
			end
		end
	end
end

function aClientTeamClick ( button )
	if ( button == "left" ) then
		if ( source == aTeamNew ) then
			aNewTeamShow ( true )
		elseif ( source == aTeamRefresh or source == aTeamShowColor ) then
			aTeamsRefresh()
		elseif ( source == aTeamDelete ) then
			if ( guiGridListGetSelectedItem ( aTeamList ) == -1 ) then
				aMessageBox ( "warning", "Nenhuma equipe selecionada!" )
			else
				local team = guiGridListGetItemText ( aTeamList, guiGridListGetSelectedItem ( aTeamList ), 1 )
				aMessageBox ( "question", "Tem certeza que deseja deletar \""..team.."\"?", "deleteTeam", team )
			end
			setTimer ( aTeamsRefresh, 2000, 1 )
		elseif ( source == aTeamCreate ) then
			local team = guiGetText ( aTeamName )
			if ( ( team == nil ) or ( team == false ) or ( team == "" ) ) then
				aMessageBox ( "warning", "Digite o nome da equipe!" )
			elseif ( getTeamFromName ( team ) ) then
				aMessageBox ( "error", "Uma equipe com este nome já existe" )
			else
				triggerServerEvent ( "aTeam", getLocalPlayer(), "createteam", team, guiGetText ( aTeamRed ), guiGetText ( aTeamGreen ), guiGetText ( aTeamBlue ) )
				aNewTeamShow ( false )
			end
			setTimer ( aTeamsRefresh, 2000, 1 )
		elseif ( source == aTeamName ) then
			
		elseif ( source == aTeamCancel ) then
			aNewTeamShow ( false )
		elseif ( source == aTeamAccept ) then
			if ( guiGridListGetSelectedItem ( aTeamList ) == -1 ) then
				aMessageBox ( "warning", "No team selected!" )
			else
				local team = guiGridListGetItemText ( aTeamList, guiGridListGetSelectedItem ( aTeamList ), 1 )
				triggerServerEvent ( "aPlayer", getLocalPlayer(), aTeamSelect, "setteam", getTeamFromName ( team ) )
				guiSetVisible ( aTeamForm, false )
			end
		elseif ( source == aTeamClose ) then
			aPlayerTeamClose ( false )
		elseif ( source == aTeamRemove ) then
			if getPlayerTeam( aTeamSelect ) then
				triggerServerEvent ( "aPlayer", getLocalPlayer(), aTeamSelect, "removefromteam", nil )
			else
				aMessageBox( "aviso", "Este jogador não está em uma equipe!")
			end
		end
	end
end

function aNewTeamShow ( bool )
	guiSetVisible ( aTeamNew, not bool )
	guiSetVisible ( aTeamDelete, not bool )
	guiSetVisible ( aTeamShowColor, not bool )
	guiSetVisible ( aTeamNameLabel, bool )
	guiSetVisible ( aTeamName, bool )
	guiSetVisible ( aTeamColor, bool )
	guiSetVisible ( aTeamR, bool )
	guiSetVisible ( aTeamG, bool )
	guiSetVisible ( aTeanB, bool )
	guiSetVisible ( aTeamRed, bool )
	guiSetVisible ( aTeamGreen, bool )
	guiSetVisible ( aTeamBlue, bool )
	guiSetVisible ( aTeamCreate, bool )
	guiSetVisible ( aTeamCancel, bool )
	guiSetVisible ( aTeamRemove, not bool )
end

function aTeamsRefresh ()
	if ( aTeamList ) then
		guiGridListClear ( aTeamList )
		local showColor = guiCheckBoxGetSelected ( aTeamShowColor )
		for id, team in ipairs ( getElementsByType ( "team" ) ) do
			local row = guiGridListAddRow ( aTeamList )
			guiGridListSetItemText ( aTeamList, row, 1, getTeamName ( team ), false, false )
			if showColor then
				guiGridListSetItemColor ( aTeamList, row, 1, getTeamColor ( team ) )
			end
		end
	end
end