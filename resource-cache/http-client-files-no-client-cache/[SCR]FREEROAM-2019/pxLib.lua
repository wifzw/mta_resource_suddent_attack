pxLib = {
    panelust = {},
    panel = {},	
	panel_label = {},
	buton = {},	
	buton_Background = {},
	panelsayi = 0,
	butonsayi = 0	
}
function panelOlustur(x,y,x2,y2,ad,r,g,b,ortalama)
    if x and y and x2 and y2 and ad and r and g and b then
	    pxLib.panelsayi = pxLib.panelsayi + 1		
	    pxLib.panel[pxLib.panelsayi] = guiCreateStaticImage(x,y+22,x2,y2, "img/Background.png", false )
        guiSetProperty(pxLib.panel[pxLib.panelsayi], "ImageColours", "tl:#a2d26200 tr:#a2d26200 bl:#a2d26200 br:#a2d26200")				
	    pxLib.panelust[pxLib.panelsayi] = guiCreateStaticImage(0,0,x2,22, "img/Background.png", false ,pxLib.panel[pxLib.panelsayi])	
        guiSetProperty(pxLib.panelust[pxLib.panelsayi], "ImageColours", "tl:"..RGBToHex(255,r,g,b).." tr:"..RGBToHex(255,r,g,b).." bl:"..RGBToHex(255,r,g,b).." br:"..RGBToHex(255,r,g,b).."")		
	    pxLib.panel_label[pxLib.panelsayi] = guiCreateLabel(0,0,x2,22,ad,false,pxLib.panelust[pxLib.panelsayi])	
        guiSetFont(pxLib.panel_label[pxLib.panelsayi], "default-bold-small")
        guiLabelSetHorizontalAlign(pxLib.panel_label[pxLib.panelsayi], "center", false)
        guiLabelSetVerticalAlign(pxLib.panel_label[pxLib.panelsayi], "center")
		if ortalama==true then
		    local screenW, screenH = guiGetScreenSize()
            local windowW, windowH = x2,y2
            local x, y = (screenW - windowW) /2,(screenH - windowH) /2
		    guiSetPosition(pxLib.panel[pxLib.panelsayi], x, y, false)  			
		end
		return pxLib.panel[pxLib.panelsayi]
	end
end
function butonOlustur(x,y,x2,y2,ad,r,g,b,gui)
    if x and y and x2 and y2 and ad and r and g and b then
	    pxLib.butonsayi = pxLib.butonsayi + 1	
	    pxLib.buton_Background[pxLib.butonsayi] = guiCreateStaticImage(x,y,x2,y2, "img/buton.png", true, gui or nil )	
        guiSetProperty(pxLib.buton_Background[pxLib.butonsayi], "ImageColours", "tl:"..RGBToHex(255, 255, 255, 255).." tr:"..RGBToHex(255, 255, 255, 255).." bl:"..RGBToHex(255, 255, 255, 255).." br:"..RGBToHex(255, 255, 255, 255).."")		
	    pxLib.buton[pxLib.butonsayi] = guiCreateLabel(0,0,1,1,ad,true,pxLib.buton_Background[pxLib.butonsayi])	
        guiSetFont(pxLib.buton[pxLib.butonsayi], "default-bold-small")
        guiLabelSetHorizontalAlign(pxLib.buton[pxLib.butonsayi], "center", false)
        guiLabelSetVerticalAlign(pxLib.buton[pxLib.butonsayi], "center")
        butonEfekt(pxLib.butonsayi,r,g,b)
        return pxLib.buton[pxLib.butonsayi]		
	end
end
function butonEfekt(i,r,g,b)
    addEventHandler( "onClientMouseEnter",root,function()
		if source == pxLib.buton[i] then
	        guiSetProperty(pxLib.buton_Background[i], "ImageColours", "tl:"..RGBToHex(255, 255, 255, 255).." tr:"..RGBToHex(255, 255, 255, 255 ).." bl:"..RGBToHex(255, 255, 255, 255 ).." br:"..RGBToHex(255, 255, 255, 255 ).."")
			playSound("Som/buton1.mp3")
		end
    end)
    addEventHandler( "onClientMouseLeave",root,function()
		if source == pxLib.buton[i] then			
            guiSetProperty(pxLib.buton_Background[i], "ImageColours", "tl:"..RGBToHex(255, 255, 255, 255).." tr:"..RGBToHex(255, 255, 255, 255 ).." bl:"..RGBToHex(255, 255, 255, 255 ).." br:"..RGBToHex(255, 255, 255, 255 ).."")
        end
	end)
	addEventHandler("onClientGUIMouseDown",root,function()
		if source == pxLib.buton[i] then
			playSound("Som/Buton2.mp3")
		end
	end)
end
addEventHandler("onClientMouseEnter",root,
	function ( )
		for k,v in ipairs(getElementsByType("gui-checkbox",resourceRoot)) do
			if source == v then
				playSound("Som/Buton1.mp3")
			end
		end
	end
)
addEventHandler("onClientGUIMouseDown",root,
	function ( )
		for k,v in ipairs(getElementsByType("gui-checkbox",resourceRoot)) do
			if source == v then
				playSound("Som/Buton2.mp3")
			end
		end
	end
)
function RGBToHex(alpha, red,green, blue )
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("%.2X%.2X%.2X%.2X", alpha,red,green,blue)
	else
		return string.format("%.2X%.2X%.2X", red,green,blue)
	end
end