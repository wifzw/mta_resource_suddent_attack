Mira = 0
Miras = {}
GUIEditor = {
    button = {},
    scrollpane = {},
    staticimage = {},
    window = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 280) / 2, (screenH - 259) / 2, 280, 259, "Panel de miras", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetVisible(GUIEditor.window[1], false)

        GUIEditor.scrollpane[1] = guiCreateScrollPane(10, 28, 260, 194, false, GUIEditor.window[1])

		for i = 1, 15 do
			for k = 1, 4 do
				Mira = Mira + 1
				if fileExists('miras/'..Mira..'.png') then
					Miras[Mira] = guiCreateStaticImage(0 + (60 * (k-1)), 0 + (60 * (i-1)), 50, 50, 'miras/'..Mira..'.png', false, GUIEditor.scrollpane[1])
				end
			end
		end
		
		for k, v in ipairs(Miras) do
			addEventHandler ( "onClientGUIClick", v, function()
				Crosshair_table = dxCreateShader("texreplace.fx")
				engineApplyShaderToWorldTexture(Crosshair_table, "siteM16")
				dxSetShaderValue(Crosshair_table, "gTexture", dxCreateTexture('miras/'..k..'.png'))
				outputChatBox("Mira aplicada exitosamente!", 0, 255, 0)
				takePlayerMoney(2000)
			end, false)
		end

        GUIEditor.button[1] = guiCreateButton(71, 226, 127, 23, "Cerrar", false, GUIEditor.window[1])

		addEventHandler ( "onClientGUIClick", GUIEditor.button[1], function()
			guiSetVisible(GUIEditor.window[1], false)
			showCursor(false)
		end, false)
    end
)

bindKey('F7', 'down', function()
	if guiGetVisible(GUIEditor.window[1]) then
		guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
	else
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
	end
end)