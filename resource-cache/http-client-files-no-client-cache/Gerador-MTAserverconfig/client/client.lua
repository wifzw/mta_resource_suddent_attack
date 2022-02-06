

local scx,scy = guiGetScreenSize()

memo = guiCreateMemo(scx / 2 - 250, scy / 2 - 170, 500, 340, "Clique no botão 'Upload'", false)   
guiSetFont(memo,"default-bold-small")
guiSetAlpha(memo,1)
guiSetVisible(memo,false)

stat_cop = false

stat_wnd_res = false

function wnd_load_res ()
	dxDrawWindow( scx / 2 - 255, scy / 2 - 200, 510, 450, "GERADOR MTASERVER.CONF")
	dxDrawButton( scx / 2 - 250, scy / 2 + 175, 500, 20, "Gerar")
	dxDrawButton( scx / 2 - 250, scy / 2 + 200, 245, 20, "Copiar")
	dxDrawButton( scx / 2 + 5, scy / 2 + 200, 245, 20, "Limpar")
	dxDrawButton( scx / 2 - 250, scy / 2 + 225, 500, 20, "Cancelar")
end

function click_res (button, state)
	if stat_wnd_res == true then
		if button == "left" and state == "down" then
			if cursorPosition(scx / 2 - 250, scy / 2 + 175, 500, 20) then
				if stat_cop == false then
					guiSetText ( memo, "" )
					triggerServerEvent ("ouResname", localPlayer)
					outputChatBox("Instalado com sucesso.",0,255,0)
					stat_cop = true
				else
					outputChatBox("Já limpo.",255,0,0)
				end
			end
			if cursorPosition(scx / 2 - 250, scy / 2 + 200, 245, 20) then
				if stat_cop == false then
					outputChatBox("Ainda não carregado.",255,0,0)
				else
					outputChatBox("A cópia foi bem sucedida.",0,255,0)
					setClipboard(guiGetText(memo))
				end
			end
			if cursorPosition(scx / 2 + 5, scy / 2 + 200, 245, 20) then
				if stat_cop == false then
					outputChatBox("Este lugar está vazio.",255,0,0)
				else
					stat_cop = false
					outputChatBox("Ele foi limpo com sucesso.",0,255,0)
					guiSetText ( memo, "Para gerar o código, você deve clicar no botão Gerar.'" )
				end
			end
			if cursorPosition(scx / 2 - 250, scy / 2 + 225, 500, 20) then
				stat_wnd_res = false
				showCursor(false)
				guiSetVisible(memo,false)
				stat_cop = false
				guiSetText(memo,"Para gerar o código, você deve clicar no botão Gerar.")
				removeEventHandler("onClientRender", root, wnd_load_res)
			end
		end
	end
end
addEventHandler("onClientClick", root, click_res)

stat = true

function outResNameGui (index)
	for k, name in pairs (No_list_config) do
		if name[1] == index then
			stat = false
		else
			stat = true
		end
		if not stat then 
			return false
		end
	end
	text = string.format ('%s<resource src = "%s" startup="1" protected="0"/>', guiGetText(memo), index )
	guiSetText ( memo, text )
end
addEvent ("outResNameGui", true)
addEventHandler ("outResNameGui", getRootElement(), outResNameGui)

function opwn_wnd_res ()
	if stat_wnd_res == false then
		stat_wnd_res = true
		showCursor(true)
		guiSetVisible(memo,true)
		stat_cop = false
		guiSetText(memo,"Para gerar o código, você deve clicar no botão Gerar.")
		addEventHandler("onClientRender", root, wnd_load_res)
	end
end
addCommandHandler("mtaconf",opwn_wnd_res)
