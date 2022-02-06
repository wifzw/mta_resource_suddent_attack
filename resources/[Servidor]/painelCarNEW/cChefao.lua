local screenH, screenW = guiGetScreenSize()
local x, y = (screenH/1366), (screenW/768)

cor = {}

painel = false

---> ---> ---> tabelado papai kkks <--- <--- <---
function EjaculeiPanel ()	
	cor[1] = tocolor(255, 255, 255, 255)
	if isCursorOnElement(x*385, y*208, x*46, y*44) then cor[1] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  

	cor[2] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*443, y*208, x*46, y*44) then cor[2] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  

	cor[3] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*852, y*209, x*75, y*44) then cor[3] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[4] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*940, y*214, x*40, y*30) then cor[4] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[5] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*455, y*444, x*35, y*42) then cor[5] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[6] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*610, y*444, x*35, y*42) then cor[6] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[7] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*770, y*370, x*35, y*42) then cor[7] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[8] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*925, y*370, x*35, y*42) then cor[8] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[9] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*770, y*430, x*35, y*42) then cor[9] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[10] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*925, y*430, x*35, y*42) then cor[10] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	cor[11] = tocolor(255, 255, 255, 255) 
	if isCursorOnElement(x*850, y*509, x*35, y*42) then cor[11] = tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha) end  
	
	    dxDrawRoundedRectangle(x*363, y*187, x*639, y*13, tocolor(config['serverColor'].cor[1], config['serverColor'].cor[2], config['serverColor'].cor[3], alpha), 4)

	    dxDrawRoundedRectangle(x*363, y*192, x*639, y*381, tocolor(18, 18, 18, 255), 4)
	    dxDrawRoundedRectangle(x*383, y*263, x*599, y*294, tocolor(23, 23, 23, 255), 4)

		dxDrawImage(x*399, y*302, x*302, y*200, "assets/gfx/car1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(x*795, y*302, x*145, y*193, "assets/gfx/car2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawImage(x*385, y*208, x*46, y*44, "assets/gfx/motor.png", 0, 0, 0,  cor[1], false)
        dxDrawImage(x*443, y*208, x*46, y*44, "assets/gfx/farol.png", 0, 0, 0,  cor[2], false)
        dxDrawImage(x*852, y*209, x*75, y*44, "assets/gfx/car.png", 0, 0, 0,  cor[3], false) 
        dxDrawImage(x*940, y*214, x*40, y*30, "assets/gfx/freio.png", 0, 0, 0,  cor[4], false) 

        dxDrawImage(x*455, y*444, x*35, y*42, "assets/gfx/seta.png", -90, 0, 0,  cor[5], false)
        dxDrawImage(x*610, y*444, x*35, y*42, "assets/gfx/seta.png", 90, 0, 0,  cor[6], false) 

        dxDrawImage(x*770, y*370, x*35, y*42, "assets/gfx/seta.png", 180, 0, 0,  cor[7], false) 
        dxDrawImage(x*925, y*370, x*35, y*42, "assets/gfx/seta.png", 0, 0, 0,  cor[8], false) 
        dxDrawImage(x*770, y*430, x*35, y*42, "assets/gfx/seta.png", 180, 0, 0,  cor[9], false) 
        dxDrawImage(x*925, y*430, x*35, y*42, "assets/gfx/seta.png", 0, 0, 0,  cor[10], false) 
        dxDrawImage(x*850, y*509, x*35, y*42, "assets/gfx/seta.png", 90, 0, 0, cor[11], false)
    end
	
function semmcarro()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle == false then
	if not fontScale then fontScale = screenW/60 end
			triggerServerEvent ("semcarro", localPlayer)
		end
	end
bindKey('f4', "down", semmcarro) -- // bind abrir

function PainelAbrir()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if painel == false and vehicle then
	if not fontScale then fontScale = screenW/60 end
		showCursor(true)
		painel = true
		addEventHandler("onClientRender", getRootElement(), EjaculeiPanel)
		playSound("assets/sfx/open.ogg")
	else
		showCursor(false)
		painel = false
		removeEventHandler("onClientRender", getRootElement(), EjaculeiPanel)
		end
	end
bindKey('f4', "down", PainelAbrir) -- // bind abrir

---> ---> ---> ---> ❪ motor on/off ❫ <--- <--- <--- <---
function MOTORONOFF (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*385, y*208, x*46, y*44 )) then
playSound("assets/sfx/motor.ogg")
triggerServerEvent ("motorligado", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, MOTORONOFF)

---> ---> ---> ---> ❪ luzes ❫ <--- <--- <--- <---
function LUZESONOFF (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*443, y*208, x*46, y*44)) then
playSound("assets/sfx/light.ogg")
triggerServerEvent ("farolligado", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, LUZESONOFF)

---> ---> ---> ---> ❪ desvirar ❫ <--- <--- <--- <---
function F5_flip (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*852, y*209, x*75, y*44)) then
triggerServerEvent ("F5_flip", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, F5_flip)

---> ---> ---> ---> ❪ freio ❫ <--- <--- <--- <---
function FREIOONOFF (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*940, y*214, x*40, y*30)) then
playSound("assets/sfx/brake.wav")
triggerServerEvent ("freioativado", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, FREIOONOFF)

---> ---> ---> ---> ❪ suspensão on ❫ <--- <--- <--- <---
function SUSPENSAOON (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*455, y*444, x*35, y*42)) then
playSound("assets/sfx/click.ogg")
triggerServerEvent ("subir", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, SUSPENSAOON)

---> ---> ---> ---> ❪ suspensão off ❫ <--- <--- <--- <---
function SUSPENSAOOFF (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*610, y*444, x*35, y*42)) then
playSound("assets/sfx/click.ogg")
triggerServerEvent ("descer", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, SUSPENSAOOFF)

---> ---> ---> ---> ❪ porta p1 ❫ <--- <--- <--- <---
function Chefao_P1 (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*770, y*370, x*35, y*42)) then
	playSound("assets/sfx/click.ogg")
triggerServerEvent ("Chefao_P1", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, Chefao_P1)

---> ---> ---> ---> ❪ porta p2 ❫ <--- <--- <--- <---
function Chefao_P2 (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*925, y*370, x*35, y*42)) then
	playSound("assets/sfx/click.ogg")
triggerServerEvent ("Chefao_P2", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, Chefao_P2)

---> ---> ---> ---> ❪ porta p3 ❫ <--- <--- <--- <---
function Chefao_P3 (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*770, y*430, x*35, y*42)) then
	playSound("assets/sfx/click.ogg")
triggerServerEvent ("Chefao_P3", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, Chefao_P3)

---> ---> ---> ---> ❪ porta p4 ❫ <--- <--- <--- <---
function Chefao_P4 (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*925, y*430, x*35, y*42)) then 
	playSound("assets/sfx/click.ogg")
triggerServerEvent ("Chefao_P4", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, Chefao_P4)

---> ---> ---> ---> ❪ porta malas ❫ <--- <--- <--- <---
function PORTA6 (_,state)
if painel == true then
if ( state == "down" ) then
if ( isCursorOnElement(x*850, y*509, x*35, y*42)) then
	playSound("assets/sfx/click.ogg")
triggerServerEvent ("porta6", localPlayer)
end
end
end
end
addEventHandler ("onClientClick", root, PORTA6)

---> ---> ---> ---> ❪ cursor ❫ <--- <--- <--- <---
function isCursorOnElement(x,y,w,h)
 local mx,my = getCursorPosition ()
 local fullx,fully = guiGetScreenSize()
 cursorx,cursory = mx*fullx,my*fully
 if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
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

---> ---> ---> ---> ❪ dx borda ❫ <--- <--- <--- <---
function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius
    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)
        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end