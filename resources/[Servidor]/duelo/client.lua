--------------------------------------------[Пикап]
addEventHandler("onClientRender", root, function()
    local x, y, z = getElementPosition(dxMarker)
    local Mx, My, Mz = getCameraMatrix()
    if (getDistanceBetweenPoints3D(x, y, z, Mx, My, Mz) <= 20) then
        local WorldPositionX, WorldPositionY = getScreenFromWorldPosition(x, y, z +1, 0.07)
        if (WorldPositionX and WorldPositionY) then
            dxDrawText("Desafio de Duelo", WorldPositionX - 1, WorldPositionY + 1, WorldPositionX - 1, WorldPositionY + 1, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
            dxDrawText("Desafio de Duelo", WorldPositionX - 1, WorldPositionY + 1, WorldPositionX - 1, WorldPositionY + 1, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
        end
    end
end)
---------------------------------------------

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end
    
wndDuel = guiCreateWindow(15,175,400,515,"Duelo",false)
centerWindow(wndDuel)
guiSetVisible(wndDuel, false)
    
labelDuel1 = guiCreateLabel(5,25,390,50,"Selecione o jogador com qual você pretende duelar:",false,wndDuel)
guiSetFont(labelDuel1, "default-bold-small")
guiLabelSetHorizontalAlign(labelDuel1, "center", false)

gridDuel = guiCreateGridList(10, 55, 380, 150, false, wndDuel)
local column1 = guiGridListAddColumn(gridDuel, "Jogadores", 0.95)
for id, player in ipairs(getElementsByType("player")) do
    local x,y,z = getElementPosition(localPlayer)
    local x2,y2,z2 = getElementPosition(player)
    if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= range then
        if player ~= localPlayer then
            local row = guiGridListAddRow ( gridDuel )
            guiGridListSetItemText ( gridDuel, row, column1, getPlayerName ( player ), false, false )
        end
    end
end

labelDuel2 = guiCreateLabel(5,215,390,50,"Escolha uma arma:",false,wndDuel)
guiSetFont(labelDuel2, "default-bold-small")
guiLabelSetHorizontalAlign(labelDuel2, "center", false)

gridDuel2 = guiCreateGridList(10, 245, 380, 150, false, wndDuel)
local column2 = guiGridListAddColumn(gridDuel2, "Armas", 0.9)

for i, data in ipairs ( weapData ) do
    local row = guiGridListAddRow ( gridDuel2 )
    guiGridListSetItemText( gridDuel2, row, column2, data[1], false, false )
    guiGridListSetItemData( gridDuel2, row, column2, {data[2], data[3]} )
end

labelDuel2 = guiCreateLabel(5,410,390,50,"Insira o valor:",false,wndDuel)
guiSetFont(labelDuel2, "default-bold-small")
guiLabelSetHorizontalAlign(labelDuel2, "center", false)

editDuel = guiCreateEdit(10, 435, 380, 30, "", false, wndDuel)
guiEditSetMaxLength(editDuel, 8)

ButtonDuel1 = guiCreateButton(10,470,185,35,"Enviar duelo",false,wndDuel)
ButtonDuel2 = guiCreateButton(205,470,185,35,"Sair",false,wndDuel)

function updateGridListDuel1()
    if not isElement(wndDuel) then
	    return
	end
	
    local rw, cl = guiGridListGetSelectedItem(gridDuel)
    guiGridListClear(gridDuel)
    for id, player in ipairs(getElementsByType("player")) do
        local x,y,z = getElementPosition(localPlayer)
        local x2,y2,z2 = getElementPosition(player)
        if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= range then
            if player ~= localPlayer then
                local row = guiGridListAddRow ( gridDuel )
                guiGridListSetItemText ( gridDuel, row, column1, getPlayerName ( player ), false, false )
            end
        end
    end
    guiGridListSetSelectedItem(gridDuel, rw, cl)
end

function updateGridListDuel2()
    if not isElement(wndDuel) then
	    return
	end
	
    local rw, cl = guiGridListGetSelectedItem(gridDuel2)
    guiGridListClear(gridDuel2)
    for i, data in ipairs ( weapData ) do
        local row = guiGridListAddRow ( gridDuel2 )
        guiGridListSetItemText( gridDuel2, row, column2, data[1], false, false )
        guiGridListSetItemData( gridDuel2, row, column2, {data[2], data[3]} )
    end
    guiGridListSetSelectedItem(gridDuel, rw, cl)
end

addEventHandler("onClientGUIClick", root, function ()
if (source == ButtonDuel1) then
    if getElementData(localPlayer,"Duel") == true then
        outputChatBox("#00FF00[Duelo] #FFFFFFВ Atualmente o duelo está acontecendo entre outros jogadores.",255,255,255,true)
        return
    end
    if guiGridListGetSelectedItem(gridDuel) ~= -1 then
        if guiGridListGetSelectedItem(gridDue2) ~= -1 then
            if guiGetText(editDuel) ~= "" then
                if tonumber(getPlayerMoney(localPlayer)) >= tonumber(guiGetText(editDuel)) then
                    local textName =  guiGridListGetItemText(gridDuel, guiGridListGetSelectedItem(gridDuel), column1)
                    local textWeap =  guiGridListGetItemText(gridDuel2, guiGridListGetSelectedItem(gridDuel2), column2)
                    local dataWeap =  guiGridListGetItemData(gridDuel2, guiGridListGetSelectedItem(gridDuel2), column2)
                    guiSetVisible(wndDuel,false)
                    showCursor(false)
                    triggerServerEvent("sentenceDuel", getRootElement(), textName, textWeap, dataWeap, guiGetText(editDuel), getLocalPlayer(localPlayer))
                    outputChatBox("#00FF00[Duelo] #FFFFFFVocê convidou com sucesso "..textName.." #FFFFFFAguarde uma resposta..",255,255,255,true)
                else
                    outputChatBox("#00FF00[Duelo] #FFFFFFVocê não tem dinheiro suficiente.",255,255,255,true)
                end
            else
                outputChatBox("#00FF00[Duelo] #FFFFFFInsira o valor da aposta.",255,255,255,true)
            end
        else
            outputChatBox("#00FF00[Duelo] #FFFFFFEscolha uma arma.",255,255,255,true)
        end
    else
        outputChatBox("#00FF00[Duelo] #FFFFFFEscolha um jogador.",255,255,255,true)
    end
    elseif (source == ButtonDuel2) then
        guiSetVisible(wndDuel,false)
        showCursor(false)
    end
end)

addCommandHandler('duelo', function()
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then
        guiSetVisible(wndDuel,true)
        showCursor(true)
        updateGridListDuel1()
        updateGridListDuel2()
        guiSetText(editDuel,"")
    else
        outputChatBox('#ff0000Saia do veículo para desafiar o jogador!', 255,255,255,true)
    end
end)

--------------------------------------------------------------------

function wndSentence(player, weap, data, count, target)
    wndSen = guiCreateWindow(0,0,330,80,getPlayerName(target).." Chamou você para um duelo.",false)
    centerWindow(wndSen)
    guiSetVisible(wndSen, true)
    showCursor(true)

    buttonSen1 = guiCreateButton(10,30,150,35,"Aceitar",false,wndSen)
    guiSetFont(buttonSen1,"default-bold-small")

    buttonSen2 = guiCreateButton(170,30,150,35,"Recusar",false,wndSen)
    guiSetFont(buttonSen2,"default-bold-small")
    
    function startClick()
        if (source == buttonSen1)then
            if tonumber(getPlayerMoney(player)) >= tonumber(count) then
                guiSetVisible(wndSen,false)
                showCursor(false)
                triggerServerEvent("decisionDuel", getRootElement(), player, weap, data, count, target, 1)
            else
                outputChatBox("#00FF00[Duelo] #FFFFFFVocê não tem dinheiro suficiente.",255,255,255,true)
            end
        elseif (source == buttonSen2)then
            guiSetVisible(wndSen,false)
            showCursor(false)
            triggerServerEvent("decisionDuel", getRootElement(), player, weap, data, count, target, 2)
        end
    end
    addEventHandler("onClientGUIClick", getRootElement(), startClick)
end
addEvent("wndSentence",true)
addEventHandler("wndSentence",root,wndSentence)

--------------------------------------------------------------------

local scx,scy = guiGetScreenSize()

function showTimer()
	local timeleft = math.floor((duelTimeLimit*1000 - (getTickCount() - chaseTime))/1000)
	if timeleft >= 1 then
		local m = math.floor(timeleft/60)
		local s = math.floor(timeleft - 60*m)
        dxDrawText("Antes do duelo começar "..s.." segundo(s).",scx/2,100,scx/2,10,tocolor(255,255,255),2,"default-bold","center","center")
	else
		removeEventHandler("onClientRender",root,showTimer)
	end
end

function duelTimer()
    chaseTime = getTickCount()
    addEventHandler("onClientRender",root,showTimer)
end
addEvent("duelTimer",true)
addEventHandler("duelTimer",root,duelTimer)