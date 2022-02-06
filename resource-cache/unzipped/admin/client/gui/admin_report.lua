--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_report.lua
*
*	Original File by lil_Toady
*
**************************************]]

aReportForm = nil

function aReport ( player )
	if ( aReportForm == nil ) then
		local x, y = guiGetScreenSize()
		aReportForm		= guiCreateWindow ( x / 2 - 150, y / 2 - 150, 300, 300, "..:: Suporte ::..", false )
		guiSetProperty(aReportForm, "CaptionColour", "FF00ffff")
				catig=	   guiCreateLabel ( 0.05, 0.11, 0.20, 0.09, "Categoria:", true, aReportForm )
		guiLabelSetColor ( catig, 255, 255, 0 )
		guiSetFont ( catig, "default-bold-small" )	
			assu=		   guiCreateLabel ( 0.05, 0.21, 0.20, 0.09, "Assunto:", true, aReportForm )
        guiLabelSetColor ( assu, 255, 255, 0 )
		guiSetFont ( assu, "default-bold-small" )			   
			msgm=		   guiCreateLabel ( 0.05, 0.30, 0.30, 0.07, "Mensagem:", true, aReportForm )
		guiLabelSetColor ( msgm, 255, 255, 0 )
		guiSetFont ( msgm, "default-bold-small" )				   
		aReportCategory	= guiCreateEdit ( 0.30, 0.10, 0.65, 0.09, "Pergunta", true, aReportForm )
		guiSetFont ( aReportCategory, "default-bold-small" )	
					   guiEditSetReadOnly ( aReportCategory, true )
		aReportDropDown	= guiCreateStaticImage ( 0.86, 0.10, 0.09, 0.09, "client\\images\\dropdown.png", true, aReportForm )
					   guiBringToFront ( aReportDropDown )
		aReportCategories	= guiCreateGridList ( 0.30, 0.10, 0.65, 0.30, true, aReportForm )
					   guiGridListAddColumn( aReportCategories, "", 0.85 )
					   guiSetVisible ( aReportCategories, false )
					   guiGridListSetItemText ( aReportCategories, guiGridListAddRow ( aReportCategories ), 1, "Pergunta", false, false )
					   guiGridListSetItemText ( aReportCategories, guiGridListAddRow ( aReportCategories ), 1, "Sugestao", false, false )
					   guiGridListSetItemText ( aReportCategories, guiGridListAddRow ( aReportCategories ), 1, "Denuncia", false, false )
					   guiGridListSetItemText ( aReportCategories, guiGridListAddRow ( aReportCategories ), 1, "Outros", false, false )
			guiSetFont ( aReportCategories, "default-bold-small" )		   
		aReportSubject		= guiCreateEdit ( 0.30, 0.20, 0.65, 0.09, "", true, aReportForm )
		aReportMessage	= guiCreateMemo ( 0.05, 0.38, 0.90, 0.45, "", true, aReportForm )
		aReportAccept		= guiCreateButton ( 0.40, 0.88, 0.25, 0.09, "Enviar", true, aReportForm )
		guiSetProperty(aReportAccept, "NormalTextColour", "FF00FFFF")		
		aReportCancel		= guiCreateButton ( 0.70, 0.88, 0.25, 0.09, "Cancelar", true, aReportForm )
		guiSetProperty(aReportCancel, "NormalTextColour", "FF00FFFF")	
		addEventHandler ( "onClientGUIClick", aReportForm, aClientReportClick )
		addEventHandler ( "onClientGUIDoubleClick", aReportForm, aClientReportDoubleClick )
	end
	guiBringToFront ( aReportForm )
	showCursor ( true )
end
addCommandHandler ( "suporte", aReport )

function aReportClose ( )
	if ( aReportForm ) then
		removeEventHandler ( "onClientGUIClick", aReportForm, aClientReportClick )
		removeEventHandler ( "onClientGUIDoubleClick", aReportForm, aClientReportDoubleClick )
		destroyElement ( aReportForm )
		aReportForm = nil
		showCursor ( false )
	end
end

function aClientReportDoubleClick ( button )
	if ( button == "left" ) then
		if ( source == aReportCategories ) then
			if ( guiGridListGetSelectedItem ( aReportCategories ) ~= -1 ) then
				local cat = guiGridListGetItemText ( aReportCategories, guiGridListGetSelectedItem ( aReportCategories ), 1 )
				guiSetText ( aReportCategory, cat )
				guiSetVisible ( aReportCategories, false )
			end
		end
	end
end

function aClientReportClick ( button )
	if ( source == aReportCategory ) then
		guiBringToFront ( aReportDropDown )
	end
	if ( source ~= aReportCategories ) then
		guiSetVisible ( aReportCategories, false )
	end
	if ( button == "left" ) then
		if ( source == aReportAccept ) then
			if ( ( string.len ( guiGetText ( aReportSubject ) ) < 1 ) or ( string.len ( guiGetText ( aReportMessage ) ) < 5 ) ) then
				aMessageBox ( "Erro", "Faltando Assunto/Mensagem." )
			else
				aMessageBox ( "Info", "Sua mensagem foi enviada e será processado o mais rapidamente possivel." )
				setTimer ( aMessageBoxClose, 3000, 1, true )
				local tableOut = {}
				tableOut.category = guiGetText ( aReportCategory )
				tableOut.subject = guiGetText ( aReportSubject )
				tableOut.message = guiGetText ( aReportMessage )
				triggerServerEvent ( "aMessage", getLocalPlayer(), "new", tableOut )
				aReportClose ()
			end
		elseif ( source == aReportSubject ) then
			
		elseif ( source == aReportMessage ) then
			
		elseif ( source == aReportCancel ) then
			aReportClose ()
		elseif ( source == aReportDropDown ) then
			guiBringToFront ( aReportCategories )
			guiSetVisible ( aReportCategories, true )
		end
	end
end