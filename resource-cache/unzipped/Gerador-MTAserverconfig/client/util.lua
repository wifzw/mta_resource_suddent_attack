
standartR, standartG, standartB, standartH = 191, 32, 32, 150

function dxDrawWindow(x, y, w, h, text)
	local mx, my = getMousePos()
	local bgcolor = tocolor(0, 0, 0, 150)
	local tcolor = tocolor(255, 255, 255, 255)
	local bgcolorp = tocolor(standartR, standartG, standartB, 255)
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	dxDrawRectangle(x, y, w, 5, bgcolorp, false)
	dxDrawText(text, x + 4, y + 5, w + x, 30 + y, tcolor, 1,1, "default-bold", "center", "center", true, false, false, true)
end

function dxDrawButton(x, y, w, h, text)
	local mx, my = getMousePos()
	local bgcolor = tocolor(standartR, standartG, standartB, standartH,255)
	if isPointInRect(mx, my, x, y, w, h) then
		bgcolor = tocolor(standartR, standartG, standartB, standartH)
	else
		bgcolor = tocolor(standartR, standartG, standartB, 255)
	end
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	dxDrawText(text, x, y, w + x, h + y, tocolor(255, 255, 255, 255), 1,1, "default-bold", "center", "center", true, false, false, true)
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