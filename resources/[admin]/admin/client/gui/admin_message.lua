--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_message.lua
*
*	Original File by lil_Toady
*
**************************************]]

aViewMessageForm = nil

function aViewMessage ( id )
	if ( aViewMessageForm == nil ) then
		local x, y = guiGetScreenSize()
		aViewMessageForm	= guiCreateWindow ( x / 2 - 150, y / 2 - 125, 300, 250, "", false )
				guiSetProperty(aViewMessageForm, "CaptionColour", "FF00ffff")
				cate=	   guiCreateLabel ( 0.05, 0.10, 0.30, 0.09, "Categoria:", true, aViewMessageForm )
		guiLabelSetColor ( cate, 255, 255, 0 )
		guiSetFont ( cate, "default-bold-small" )	
			assu=		   guiCreateLabel ( 0.05, 0.18, 0.30, 0.09, "Assunto:", true, aViewMessageForm )
		guiLabelSetColor ( assu, 255, 255, 0 )
		guiSetFont ( assu, "default-bold-small" )				   
				temp=	   guiCreateLabel ( 0.05, 0.26, 0.30, 0.09, "Tempo:", true, aViewMessageForm )
		guiLabelSetColor ( temp, 255, 255, 0 )
		guiSetFont ( temp, "default-bold-small" )						   
				por=	   guiCreateLabel ( 0.05, 0.34, 0.30, 0.09, "Por:", true, aViewMessageForm )
		guiLabelSetColor ( por, 255, 255, 0 )
		guiSetFont ( por, "default-bold-small" )					   
		aViewMessageCategory	= guiCreateLabel ( 0.40, 0.10, 0.55, 0.09, "", true, aViewMessageForm )
				guiSetFont ( aViewMessageCategory, "default-bold-small" )
		aViewMessageSubject	= guiCreateLabel ( 0.40, 0.18, 0.55, 0.09, "", true, aViewMessageForm )
		guiSetFont ( aViewMessageSubject, "default-bold-small" )
		aViewMessageTime	= guiCreateLabel ( 0.40, 0.26, 0.55, 0.09, "", true, aViewMessageForm )
		guiSetFont ( aViewMessageTime, "default-bold-small" )
		aViewMessageAuthor	= guiCreateLabel ( 0.40, 0.34, 0.55, 0.09, "", true, aViewMessageForm )
		guiSetFont ( aViewMessageAuthor, "default-bold-small" )
		aViewMessageText	= guiCreateMemo ( 0.05, 0.41, 0.90, 0.45, "", true, aViewMessageForm )
		guiMemoSetReadOnly ( aViewMessageText, true )
		aViewMessageCloseB	= guiCreateButton ( 0.77, 0.88, 0.20, 0.09, "Fechar", true, aViewMessageForm )
		guiSetProperty(aViewMessageCloseB, "NormalTextColour", "FF00FFFF")

		addEventHandler ( "onClientGUIClick", aViewMessageForm, aClientMessageClick )
		--Register With Admin Form
		aRegister ( "Message", aViewMessageForm, aViewMessage, aViewMessageClose )
	end
	if ( _messages[id] ) then
		guiSetText ( aViewMessageCategory, _messages[id].category )
		guiSetText ( aViewMessageSubject, _messages[id].subject )
		guiSetText ( aViewMessageTime, _messages[id].time )
		guiSetText ( aViewMessageAuthor, _messages[id].author:gsub( "#%x%x%x%x%x%x", "" ) )
		guiSetText ( aViewMessageText, _messages[id].text )
		guiSetVisible ( aViewMessageForm, true )
		guiBringToFront ( aViewMessageForm )
		triggerServerEvent ( "aMessage", getLocalPlayer(), "read", id )
	end
end

function aViewMessageClose ( destroy )
	if ( ( destroy ) or ( guiCheckBoxGetSelected ( aPerformanceMessage ) ) ) then
		if ( aViewMessageForm ) then
			removeEventHandler ( "onClientGUIClick", aViewMessageForm, aClientMessageClick )
			destroyElement ( aViewMessageForm )
			aViewMessageForm = nil
		end
	else
		if aViewMessageForm then guiSetVisible ( aViewMessageForm, false ) end
	end
end

function aClientMessageClick ( button )
	if ( button == "left" ) then
		if ( source == aViewMessageCloseB ) then
			aViewMessageClose ( false )
		end
	end
end