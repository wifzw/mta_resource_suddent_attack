--[[

© Creditos do script: #Mods MTA:SA

© Creditos da pagina postadora: DropMTA

© Discord DropMTA: https://discord.gg/GZ8DzrmxUV

Acesse nosso site de mods: https://dropmta.blogspot.com/

]]--


standartR, standartG, standartB, standartH = 191, 32, 32, 150

function dxDrawWindow(x, y, w, h, text)
	local mx, my = getMousePos()
	local CR = getElementData(localPlayer, "ColorR") or standartR
	local CG = getElementData(localPlayer, "ColorG") or standartG
	local CB = getElementData(localPlayer, "ColorB") or standartB
	local bgcolor = tocolor(0, 0, 0, 150)
	local tcolor = tocolor(255, 255, 255, 255)
	local bgcolorp = tocolor(CR, CG, CB, 255)
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	dxDrawRectangle(x, y, w, 5, bgcolorp, false)
	dxDrawText(text, x + 4, y + 5, w + x, 30 + y, tcolor, 1,1, "default-bold", "center", "center", true, false, false, true)
end

function dxDrawButton(x, y, w, h, text)
	local mx, my = getMousePos()
	local CR = getElementData(localPlayer, "ColorR") or standartR
	local CG = getElementData(localPlayer, "ColorG") or standartG
	local CB = getElementData(localPlayer, "ColorB") or standartB
	local CH = getElementData(localPlayer, "ColorH") or standartH
	local bgcolor = tocolor(CR,CG,CB,255)
	if isPointInRect(mx, my, x, y, w, h) then
		bgcolor = tocolor(CR,CG,CB,CH)
	else
		bgcolor = tocolor(CR,CG,CB, 255)
	end
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	dxDrawText(text, x, y, w + x, h + y, tocolor(255, 255, 255, 255), 1,1, "default-bold", "center", "center", true, false, false, true)
end

function dxDrawButtonText(x, y, w, h, text, Font_1, Font_2)
	local mx, my = getMousePos()
	local tcolor = tocolor(255, 255, 255, 255)
	dxDrawText(text, x, y, w + x, h + y, tcolor, Font_1, Font_2, "default-bold", "center", "center", true, false, false, true)
end

function dxDrawButtonTextR(x, y, w, h, text, Font_1, Font_2)
	local mx, my = getMousePos()
	local tcolor = tocolor(255, 255, 255, 255)
	dxDrawText(text, x, y, w + x, h + y, tcolor, Font_1, Font_2, "default-bold", "right", "center", true, false, false, true)
end
	
function dxDrawProgress(x, y, w, h, size, text)
	local CR = getElementData(localPlayer, "ColorR") or standartR
	local CG = getElementData(localPlayer, "ColorG") or standartG
	local CB = getElementData(localPlayer, "ColorB") or standartB
	dxDrawRectangle(x, y, w, h, tocolor(255,255,255,255))
	dxDrawRectangle(x + 1 , y + 1, w - 2, h - 2, tocolor(100,100,100,255))
	if size == 0 then
		dxDrawRectangle(x + 1 , y + 1, size, h - 2, tocolor(CR, CG, CB, 255))
	else
		if size < w then
			dxDrawRectangle(x + 1 , y + 1, size - 2, h - 2, tocolor(CR, CG, CB, 255))
		else
			dxDrawRectangle(x + 1 , y + 1, w - 2, h - 2, tocolor(CR, CG, CB, 255))
		end
	end
	dxDrawText(text, x, y, w + x, h + y, tocolor(255,255,255,255), 1,1, "default-bold", "center", "center", true, false, false, true)
end
	
function dxDrawCheckButton(x, y, w, h, text, chek, stat )
	local mx, my = getMousePos()
	local CR = getElementData(localPlayer, "ColorR") or standartR
	local CG = getElementData(localPlayer, "ColorG") or standartG
	local CB = getElementData(localPlayer, "ColorB") or standartB
	local CH = getElementData(localPlayer, "ColorH") or standartH
	local color1 = tocolor(CR, CG, CB, 255)
	local color2 = tocolor(255, 255, 255, 255)
	local color3 = tocolor(CR, CG, CB, 255)
	local tcolorr = tocolor(CR, CG, CB, 255)
	if isPointInRect(mx, my, x, y, w, h) then
		color3 = tocolor(CR, CG, CB, CH)
	end
	local pos = x
	dxDrawRectangle(x, y, w, h, color1, false)
	dxDrawRectangle(x + 2, y + 2, w - 4, h - 4, color2, false)
	if chek then
		dxDrawRectangle(pos + 4, y + 4, w - 8, h - 8, color3, false)
	end
	
	if stat == false then
		dxDrawLine(x, y, x + w, y + h, tcolorr, 2, false)
		dxDrawLine(x, y + h, x + w, y, tcolorr, 2, false)
	end
	dxDrawText(text, pos + 25, y + 6, 30 + pos + 25, h - 12 + y + 6, tcolor, 1,1, "default-bold", "left", "center", true, false, false, true)
end

function dxDrawScrollBar(x, y, w, h, sc, text, Proc, fil)
local veh = getPedOccupiedVehicle(localPlayer)
	local mx, my = getMousePos()
	local CR = getElementData(localPlayer, "ColorR") or standartR
	local CG = getElementData(localPlayer, "ColorG") or standartG
	local CB = getElementData(localPlayer, "ColorB") or standartB
	local bgcolor = tocolor(CR, CG, CB, 200)
	local tcolor = tocolor(255, 255, 255, 255)
	local tcolorr = tocolor(255, 255, 255, 255)
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	dxDrawText(text, x, y, w + x, h + y, tcolorr, 1,1, "default-bold", "center", "center", true, false, false, true)
	if sc >= x and sc <= (x+w)-5 then
		dxDrawRectangle(sc, y-5, 5, h+10, tcolor, false)
		scrollProcent = ((sc-x)/w)*(80 - fil)
		visualPocent_fuel = scrollProcent  
		mnohitel = 0 + math.floor(scrollProcent)*Proc
	else
		if sc <= x then
			dxDrawRectangle(x, y-5, 5, h+10, tcolor, false)
			scrollProcent = 0
			mnohitel = 0 + math.floor(scrollProcent)*Proc
			visualPocent_fuel = scrollProcent
		else
			dxDrawRectangle((x+w)-5, y-5, 5, h+10, tcolor, false)
			scrollProcent = 80 - fil
			mnohitel = 0 + math.floor(scrollProcent)*Proc
			visualPocent_fuel = scrollProcent 
		end
	end
end


function dxDrawtext(x, y, w, h, text)
	dxDrawText(text, x, y, w + x, h + y, tcolor, 1, "default-bold", "center", "center", true, false, false, true)
end

function isPointInRect(x, y, rx, ry, rw, rh)
	if x >= rx and y >= ry and x <= rx + rw and y <= ry + rh then
		return true
	else
		return false
	end
end
function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end
function getMousePos()
	local xsc, ysc = guiGetScreenSize()
	local mx, my = getCursorPosition()
	if not mx or not my then
		mx, my = 0, 0
	end
	return mx * xsc, my * ysc
end

function isMouseClick()
	return wasMousePressedInCurrentFrame
end