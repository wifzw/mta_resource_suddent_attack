--[[

© Creditos do script: #Mods MTA:SA

© Creditos da pagina postadora: DropMTA

© Discord DropMTA: https://discord.gg/GZ8DzrmxUV

Acesse nosso site de mods: https://dropmta.blogspot.com/

]]--

local scx,scy = guiGetScreenSize()
local px = scx/1920
local sizeX, sizeY = 400*px,600*px
local posX,posY = 10*px,scy-sizeY-100*px
local screen = dxCreateScreenSource( scx,scy )

local selectionsi_azs = 0
local presi_azs = false
local scrollsi_azs = 0
local scrollMaxsi_azs = 0
local rtsi_azs = dxCreateRenderTarget( 590,345, true )
local clksi_azs = false

stat_wnd_azs= false

max_slots = 100

function wnd_azs ()

	dxDrawWindow( scx / 2 - 300, scy / 2 - 200, 600, 405, "Lista de jogadores")
		
	dxDrawButtonTextR(scx / 2 + 295, scy / 2 - 190, 0, 15, "Jogadores : "..#getElementsByType("player").." / "..max_slots, 1, 1)
	
	dxDrawRectangle(scx / 2 - 295,scy / 2 - 170,590,370,tocolor(0, 0, 0, 200))
	
	dxDrawButtonText(scx / 2 - 289, scy / 2 - 165, 40, 15, "ID", 1, 1)
	dxDrawButtonText(scx / 2 - 249, scy / 2 - 165, 150, 15, "usuario", 1, 1)
	dxDrawButtonText(scx / 2 - 98, scy / 2 - 165, 50, 15, "Tempo", 1, 1)
	dxDrawButtonText(scx / 2 - 47, scy / 2 - 165, 120, 15, "Dinheiro", 1, 1)
	dxDrawButtonText(scx / 2 + 91, scy / 2 - 165, 50, 15, "Time", 1, 1)
	dxDrawButtonText(scx / 2 + 155, scy / 2 - 165, 50, 15, "Kill", 1, 1)
	dxDrawButtonText(scx / 2 + 206, scy / 2 - 165, 85, 15, "Drift", 1, 1)
	
	local CRL = getElementData(localPlayer, "ColorR") or standartR
	local CGL = getElementData(localPlayer, "ColorG") or standartG
	local CBL = getElementData(localPlayer, "ColorB") or standartB
	local veh = getPedOccupiedVehicle(localPlayer)
	dxUpdateScreenSource( screen )
	dxSetRenderTarget( rtsi_azs,true )
	if scrollsi_azs < 0 then scrollsi_azs = 0
	elseif scrollsi_azs >= scrollMaxsi_azs then scrollsi_azs = scrollMaxsi_azs end
	local sy = 0
		for k,player in pairs(getElementsByType("player")) do

				dxDrawRectangle(5,sy-scrollsi_azs,40,15,tocolor(200, 200, 200, 200))
				dxDrawRectangle(46,sy-scrollsi_azs,150,15,tocolor(200, 200, 200, 200))
				dxDrawRectangle(197,sy-scrollsi_azs,50,15,tocolor(200, 200, 200, 200))
				dxDrawRectangle(248,sy-scrollsi_azs,120,15,tocolor(200, 200, 200, 200))
				dxDrawRectangle(369,sy-scrollsi_azs,80,15,tocolor(200, 200, 200, 200))
				dxDrawRectangle(450,sy-scrollsi_azs,50,15,tocolor(200, 200, 200, 200))
				dxDrawRectangle(501,sy-scrollsi_azs,85,15,tocolor(200, 200, 200, 200))

				local playerTeam = getPlayerTeam ( player ) 
				
				local Nick = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '')
				local Money = getElementData(player,"nal") or 0
				local ID = getElementData(player,"ID") or 0
				local Times = getElementData(player,"Play Time") or 0
				--local Wasted = getElementData(player,"T/D") or 0
				local Clan = getElementData(player,"faction") or "N/A" --Клан
				local Kill = getElementData(player,"T/K") or 0
				local Drift = getElementData(player,"RecordDrift") or 0      
				
				if ( playerTeam ) then           
					r, g, b = getTeamColor ( playerTeam )
					dxDrawText(ID,12,sy-scrollsi_azs - 10,40,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(Nick,51,sy-scrollsi_azs - 10,170,sy-scrollsi_azs+26,tocolor(r, g, b),1,1,"default-bold","left","center", false, false, false, true)
					dxDrawText(Times,395,sy-scrollsi_azs - 10,50,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(convertNumber(Money).." $" ,495,sy-scrollsi_azs - 10,130,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					--dxDrawText(convertNumber(Wasted) ,698,sy-scrollsi_azs - 10,150,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(Clan,668,sy-scrollsi_azs - 10,150,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(convertNumber(Kill) ,800,sy-scrollsi_azs - 10,150,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(convertNumber(Drift) ,1001,sy-scrollsi_azs - 10,85,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
				else
					dxDrawText(ID,12,sy-scrollsi_azs - 10,40,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(Nick,51,sy-scrollsi_azs - 10,170,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","left","center", false, false, false, true)
					dxDrawText(Times,395,sy-scrollsi_azs - 10,50,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(convertNumber(Money).." $" ,495,sy-scrollsi_azs - 10,130,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					--dxDrawText(convertNumber(Wasted) ,698,sy-scrollsi_azs - 10,150,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(Clan ,668,sy-scrollsi_azs - 10,150,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(convertNumber(Kill) ,800,sy-scrollsi_azs - 10,150,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
					dxDrawText(convertNumber(Drift) ,1001,sy-scrollsi_azs - 10,85,sy-scrollsi_azs+26,tocolor(255,255,255),1,1,"default-bold","center","center", false, false, false, true)
				end
			sy = sy + 16
		end
	dxSetRenderTarget()
	dxDrawImage(scx / 2 - 295, scy / 2 - 145,590,345,rtsi_azs)
	if sy >= 345 then
		scrollMaxsi_azs = sy-345
	end
end

addEventHandler("onClientKey",root,function(key,presi_azs)
	if presi_azs then
		if not stat_wnd_azs then return end
		if key == "mouse_wheel_down" then
			scrollsi_azs = scrollsi_azs + 12
		elseif key == "mouse_wheel_up" then
			scrollsi_azs = scrollsi_azs - 12
		end
	end
end)

function opwn_wnd_azs ()
	if stat_wnd_azs == false then
		stat_wnd_azs = true
		addEventHandler("onClientRender", root, wnd_azs)
	else
		stat_wnd_azs = false
		removeEventHandler("onClientRender", root, wnd_azs)
	end
end
bindKey("tab","both",opwn_wnd_azs)


function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

 
local starttick, currenttick
local player = getLocalPlayer()
addEventHandler("onClientRender",getRootElement(),
    function()
        if not starttick then
            starttick = getTickCount()
        end
        currenttick = getTickCount()
        if currenttick - starttick >= 0 then
            setElementData(player,"nal",getPlayerMoney( player ) ) 
            starttick =  getTickCount()
        end
    end
)

--[[function updateMoney()
    for k, v in ipairs(getElementsByType('player')) do
        local money = getPlayerMoney(v) 
        setElementData(v,"nal",money )  
    end
end
setTimer(updateMoney, Money, v)]]--