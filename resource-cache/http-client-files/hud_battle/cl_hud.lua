----------------------------------------------------------------------Ayyildizmta #EfsaneALbayraK)))
scx,scy = guiGetScreenSize()
px = scx/1920 * 0.75 
showPlayerHudComponent("all", false)
setPlayerHudComponentVisible("all", false)
setElementData(localPlayer,"hud:main",true,false)
local sizeX,sizeY = 750*px,200*px
local posX,posY = scx-sizeX-50*px, 50*px
----------------------------------------------------------------------
local font = dxCreateFont("files/font.ttf",17*px)--yazı tipi(30)
local font2 = dxCreateFont("files/font.ttf",20*px)--yazı tipi(18)
----------------------------------------------------------------------
function dxDrawImageFix(posx,posy,sizex,sizey,img)
	posx = math.floor(posx)
	posy = math.floor(posy)
	sizex = math.floor(sizex)
	sizey = math.floor(sizey)
	dxDrawImage(posx,posy,sizex,sizey,img)
end
----------------------------------------------------------------------
local root = getRootElement()
local player = getLocalPlayer()
local counter = 0
local starttick
local currenttick
----------------------------------------------------------------------
function drawHUD()
	if getElementData(localPlayer,"hud:main") then
		local health = getElementHealth(localPlayer)
		local money = getPlayerMoney(localPlayer)
		dxDrawImageFix(posX,posY,sizeX,sizeY,"files/background.png")--сам фон
		
		dxDrawImageSection( math.floor(posX+225*px),math.floor(posY+87*px), 180*px, 10*px, 0, 0, 440, 18,"files/hpbackground.png")--Sağlık-arka-plan
		dxDrawImageSection( math.floor(posX+225*px),math.floor(posY+87*px), 180*px*health/100, 10*px, 0, 0, 440*health/100, 18,"files/hp.png")--Sağlık
		dxDrawText(math.floor(health).."HP",math.floor(posX+130*px),math.floor(posY+78*px),440, 18,tocolor(255,255,255),0.8,font2)--Sağlık-metni
-----------------------------------------------------------------------------------------------------------------------------------------------------
		local t = getRealTime() 
		local h,m = tostring(t.hour), tostring(t.minute)
		if #h == 1 then h = "0"..h end
		if #m == 1 then m = "0"..m end
		dxDrawText(h..":"..m, posX+500*px, posY+15*px, posX+300*px, posY+130*px,tocolor(240,240,240),1,font)--Saat-göstergesi
-----------------------------------------------------------------------------------------------------------------------------------------------------		
		dxDrawText(money.."", posX+450*px, posY-20*px, posX+550*px, posY+200*px,tocolor(99,150,65),0.6,font,"left", "center")--Para-göstergesi
        local name = getPlayerName(localPlayer)
		dxDrawText(name, posX+250*px, posY+15*px, posX+435*px, posY+130*px,tocolor(240,240,240),1,font,"center")--Nick-göstergesi
-----------------------------------------------------------------------------------------------------------------------------------------------------		
	end
end
addEventHandler("onClientRender",root,drawHUD)