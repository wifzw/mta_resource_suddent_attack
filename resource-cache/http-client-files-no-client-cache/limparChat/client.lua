
-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/


-- Discord : https://discord.gg/DzgEcvy


local screenW, screenH = guiGetScreenSize() -- Desenvolvido por ~[W]are^
local x, y = (screenW/1366), (screenH/768)
alpha = 0

local alphaState = true
function alphaFunction()
	if alphaState == true then
		alpha = alpha + 10
	if alpha >= 255 then
		alphaState = false
	end
	end
	if alphaState == false then
		alpha = alpha - 10
	if alpha <= 0 then
		alphaState = true
		end
	end
end
addEventHandler("onClientRender", getRootElement(), alphaFunction)

function chat(nome_jogador)
    nome = nome_jogador;
	tick15 = getTickCount()
    addEventHandler ("onClientRender", root, limpochat)
    setTimer(function()
        removeEventHandler ("onClientRender", root, limpochat)
		tick52 = getTickCount()
		addEventHandler("onClientRender", root, animclose)
    end, 5000, 1 )
	setTimer(function()
	removeEventHandler("onClientRender", getRootElement(), animclose)
	end, 8500, 1)
end
addEvent ("LimpouChat", true)
addEventHandler ("LimpouChat", root, chat)

function limpochat()
	local pox,_,_ = interpolateBetween(-200, 0, 0, 200, 0, 0, ((getTickCount() - tick15) / 2500), "OutElastic")
	dxDrawRectangle(x*32, y*pox, x*360, y*37, tocolor(0, 0, 0, 80), false)
	dxDrawBorder(x*32, y*pox, x*360, y*37, tocolor(255, 255, 255, alpha),2)
	dxDrawText(""..nome.." #ffffffLimpou o Chat.", x*170, y*pox, x*236, y*238, tocolor(255, 255, 255, 255), x*1, "default-bold", "center", "center", false, false, true, true, false)
end 

function animclose ()
	local fade,pox,_ = interpolateBetween(100, 200, 0, 0, 200, 0, ((getTickCount() - tick52) / 2500), "Linear")
	dxDrawRectangle(x*32, y*pox, x*360, y*37, tocolor(0, 0, 0, fade), false)
	dxDrawBorder(x*32, y*pox, x*360, y*37, tocolor(255, 255, 255, fade),2)
	dxDrawText(""..nome.." #ffffffLimpou o Chat.", x*170, y*pox, x*236, y*238, tocolor(255, 255, 255, fade), x*1, "default-bold", "center", "center", false, false, true, true, false)
end

function dxDrawBorder(posX, posY,posW,posH,color,scale)
    dxDrawLine(posX, posY, posX+posW, posY, color, scale,false)
    dxDrawLine(posX, posY, posX, posY+posH, color, scale,false)
    dxDrawLine(posX, posY+posH, posX+posW, posY+posH, color, scale,false)
    dxDrawLine(posX+posW, posY, posX+posW, posY+posH, color, scale,false)
end



-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/


-- Discord : https://discord.gg/DzgEcvy