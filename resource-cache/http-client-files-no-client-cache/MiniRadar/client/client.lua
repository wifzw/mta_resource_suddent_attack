---- SparroW MTA : https://sparrow-mta.blogspot.com
---- Facebook : https://www.facebook.com/sparrowgta/
---- HER GÜN YENİ SCRİPT :)


--=============================================================================================[Script by AngelAlpha]=====================================================================================================--

function math.round(number)
    return tonumber(("%.0f"):format(number))
end

--====================================================================================================================================================================================================================--

local screenW, screenH = guiGetScreenSize()
local defaultScreen = {width = 1920, height = 1080}
local px, py = screenW/defaultScreen.width, screenH/defaultScreen.height

--====================================================================================================================================================================================================================--

local radar = 
{
	x = math.round( 50	),
	y = math.round(screenH-50*py - 250*px),
	width  = 260*px,
	height = 260*px,
	allSize = 1,
}

function getRadarCoords ()
	return radar.x, radar.y, radar.width, radar.height
end

--====================================================================================================================================================================================================================--

local map = 
{
	left = 2303, right = 1997, top = 1500, bottom = 1500,
	scale = 0.5,
}


local blipSize = 
{
	size = 25,
	markerSize = 8,
}
--====================================================================================================================================================================================================================--

local borderImage = 
{
	x = 75,
	y = screenH-50*py - 250*px,
	width = 300*screenW/defaultScreen.width,
	height = 300*screenH/defaultScreen.height,
}

--====================================================================================================================================================================================================================--

local delayingBlipIcons = 
{
	[4] = true,
}

--====================================================================================================================================================================================================================--

local k = radar.height/radar.width
radar.halfWidth, radar.halfHeight = radar.width/2, radar.height/2

--====================================================================================================================================================================================================================--

radar.border = 
{
	left = radar.x, right  = radar.x+radar.width,
	top  = radar.y, bottom = radar.y+radar.height,
}

--====================================================================================================================================================================================================================--

radar.center = 
{
	x = radar.x+radar.halfWidth,
	y = radar.y+radar.halfHeight,
}

--====================================================================================================================================================================================================================--

map.width, map.height			   = map.left+map.right, map.top+map.bottom
map.centerShiftX, map.centerShiftY = (map.left - map.right)/2, (map.top - map.bottom)/2

--====================================================================================================================================================================================================================--

blipSize.halfSize		 = blipSize.size/2
blipSize.halfMarkerSize = blipSize.markerSize/2

--====================================================================================================================================================================================================================--

local texture = {
	water = 		dxCreateTexture("assets/images/blip/water.png", "dxt1", true, "clamp"),
	radar = 		dxCreateTexture("assets/images/blip/radar.dds"),
	chase = 		dxCreateTexture("assets/images/radar/chase.png"),
	nosignal = 		dxCreateTexture("assets/images/blip/nosingal.png"),
	border = 		dxCreateTexture("assets/images/radar/border.png"),
--	text = 			dxCreateTexture("assets/images/radar/text.png"),
}

local font = dxCreateFont ("assets/GothamPro.ttf", 11*px)
--====================================================================================================================================================================================================================--
local curRadar = texture.radar
--local delayedBlips = {}
--local blips = {}

local radarRenderTarget = dxCreateRenderTarget(radar.width, radar.height, true)
local maskShader = dxCreateShader("assets/shader/hud_mask.fx")
local maskTexture = dxCreateTexture("assets/images/radar/mask.png")
dxSetShaderValue(maskShader, "gTexture", radarRenderTarget)
dxSetShaderValue(maskShader, "sMaskTexture", maskTexture)

--====================================================================================================================================================================================================================--

function getCameraParameters()
	local camera = {}
	camera.element = getCamera()
	_, _, camera.rot = getElementRotation(camera.element)
	camera.x, camera.y, camera.z = getCameraMatrix ()
	local radianRotation = math.rad(camera.rot)
	camera.sin = math.sin(radianRotation)
	camera.cos = math.cos(radianRotation)
	return camera
end

local maxPlayers, players, nameServer, position = 0, 0, "", ""
function updateData (arg1, arg2)
	maxPlayers = arg2
	players = arg1
	nameServer = exports.config:getCCDPlanetName () or "N/A"
	local pos = Vector3 (localPlayer.position)
	position = getZoneName(pos, true).." "..getZoneName(pos)
end

setTimer (function()
	local pos = Vector3 (localPlayer.position)
	position = getZoneName(pos, true).." | "..getZoneName(pos)
end, 1000, 0)

addEvent ("updateData", true)
addEventHandler ("updateData", resourceRoot, updateData)

--====================================================================================================================================================================================================================--

function getTargetParameters()
	local target = {}
	target.element = getCameraTarget()
	if (target.element) then
		target.x, target.y, target.z = getElementPosition(target.element)
		_, _, target.rot = getElementRotation(target.element)
		local spX, spY, spZ = getElementVelocity(target.element)
		target.speed = (spX^2 + spY^2 + spZ^2)^(0.5)*180
	else
		target.x, target.y, target.z = getCameraMatrix()
		target.rot = 0
		target.speed = 0
	end
	target.mapX = -target.x*map.scale-map.left
	target.mapY =  target.y*map.scale-map.top
	return target
end

--====================================================================================================================================================================================================================--

local delayedBlips = {}	
local currentBlips = {}
setTimer(function()
	local target = getTargetParameters()
	currentBlips = {}
	delayedBlips = {}
	local localDim = localPlayer.dimension
	for _, blip in pairs(getElementsByType("blip")) do
		if blip.dimension == localDim then
			if (not delayingBlipIcons[ getBlipIcon(blip) ]) then
				x, y = getElementPosition(blip)
				maxDistance = getBlipVisibleDistance(blip)
				dist = getDistanceBetweenPoints2D(target.x, target.y, x, y)
				attached = getElementAttachedTo(blip)

				atDim = isElement(attached) and getElementDimension(attached) or localDim
				if atDim == localDim and
				dist < maxDistance and (attached ~= localPlayer) then
					table.insert(currentBlips, blip)
				end
			else
				table.insert(delayedBlips, blip)
			end
		end
	end
end, 1000, 0)

function dxCreateText (text, x, y, w, h, color, size, font, left, top)
	dxDrawText (text, x, y, x + w, y + h, color, size, font, left, top)
end

function renderRadar()
	if (maskTexture) and (getElementInterior(localPlayer) == 0) then
		local camera = getCameraParameters()
		local target = getTargetParameters()
		local zoom = 1
		
		dxSetRenderTarget(radarRenderTarget, false)
			dxDrawImage(0, 0, radar.width, radar.height, texture.water)
			local cX, cY = ((target.x*map.scale + map.centerShiftX)*zoom), ((-target.y*map.scale + map.centerShiftY)*zoom)
			if texture.radar then
				dxDrawImage(
					target.mapX * zoom + radar.halfWidth, 
					target.mapY * zoom + radar.halfHeight,
					map.width * zoom, 
					map.height * zoom,
					texture.radar, 
					camera.rot,
					cX, cY)
			end
		dxSetRenderTarget() 
		maskShader:setValue("gUVPosition", 0, 0)
		maskShader:setValue("gUVScale", 1, 1)
		maskShader:setValue("gUVRotCenter", 0.5, 0.5)
		dxSetShaderValue(maskShader, "sPicTexture", radarRenderTarget)
		-- dxSetShaderValue(maskShader, "sMaskTexture", maskTexture)
		
		dxDrawImage(radar.x, radar.y, 493*px, (radar.height), texture.text)
		---	dxCreateText (nameServer, radar.x + radar.width + 92*px, radar.y + 131*px, 300*px, 20*py, tocolor(255, 255, 255), 1, font, "left", "center")
		--	dxCreateText (players.."/"..maxPlayers, radar.x + radar.width + 92*px, radar.y + 176*px, 300*px, 20*py, tocolor(255, 255, 255), 1, font, "left", "center")
--dxCreateText (position:upper(), radar.x + radar.width + 3*px, radar.y + 223*px, 300*px, 20*py, tocolor(255, 255, 255), 1, font, "left", "center")
		
		dxDrawImage(radar.x, radar.y, (radar.width), (radar.height), texture.border,0,0,0,getRadarBorderColor())
		dxDrawImage(radar.x, radar.y, (radar.width), (radar.height), maskShader)
		
		for _, blip in pairs( currentBlips ) do
			drawBlipOnMap(blip, camera, target, zoom)
		end

		for _, blip in pairs(delayedBlips) do
			drawBlipOnMap(blip, camera, target, zoom)
		end
		
		if (target.element) then
			dxDrawImage(radar.center.x-blipSize.halfSize, radar.center.y-blipSize.halfSize, blipSize.size, blipSize.size, "assets/images/blip/localPlayer.png", camera.rot-target.rot)
		else
			dxDrawImage(radar.center.x-blipSize.halfSize, radar.center.y-blipSize.halfSize, blipSize.size, blipSize.size, "assets/images/blip/64.png", 0)
		end
	end
end

--====================================================================================================================================================================================================================--
local prit = false
function drawBlipOnMap(blip, camera, target, zoom)
	local icon = getBlipIcon(blip)
	local x, y, z = getElementPosition(blip)
	local myPosX, myPosY = getElementPosition (localPlayer)
	
	local xShift = (x-target.x)*map.scale*zoom
	local yShift = (target.y-y)*map.scale*zoom
	local blipPosX = xShift*camera.cos - yShift*camera.sin
	local blipPosY = xShift*camera.sin + yShift*camera.cos
	local distance = getDistanceBetweenPoints2D (x, y, myPosX, myPosY)
	
	if icon == 10 then
		--print (distance, radar.halfWidth+95)
	end
	local alp = 255
	if distance > (radar.halfWidth+93*radar.allSize)/zoom then
		if blip ~= 41 then alp = 150 end
		blipPosX, blipPosY = repairCoordinates(xShift, yShift, camera, zoom, blipPosX, blipPosY, { myPosX, myPosY, x, y } )
	end
	
	local cx,cy,_,tx,ty = getCameraMatrix()

	if (icon > 0) then
		
		dxDrawImage(
					(radar.center.x + blipPosX - blipSize.halfSize),
					(radar.center.y + blipPosY - blipSize.halfSize),
					blipSize.size, blipSize.size, "assets/images/blip/"..icon..".png", 0, 0, 0, tocolor(255, 255, 255, alp))
	else
		local r, g, b = getBlipColor(blip)
		local size = getBlipSize(blip)
		if (z-target.z > 5) then
			icon = "up"
		elseif (z-target.z < -5) then
			icon = "down"
		end
		dxDrawImage((radar.center.x + blipPosX - blipSize.halfMarkerSize*size),
		(radar.center.y + blipPosY - blipSize.halfMarkerSize*size),
		blipSize.markerSize*size, blipSize.markerSize*size, "assets/images/blip/"..icon..".png", 0, 0, 0, tocolor(r, g, b))
	end
end

--====================================================================================================================================================================================================================--

local function cc(x, min, max)
    return math.min(max, math.max(min, x))
end

--====================================================================================================================================================================================================================--

function repairCoordinates(xShift, yShift, camera, zoom, oldX, oldY, fixCC )
    local rX, rY = cc(xShift/radar.halfWidth, -1, 1), cc(yShift/radar.halfHeight, -1, 1)
    local angle = math.deg(math.atan(rY/rX))

    local fixC = 0
	--local m = "0"
	if fixCC[1] >= fixCC[3] then
	    fixC = -90
		--m = "1"
	elseif fixCC[1] < fixCC[3] then
	    fixC = 90
		--m = "2"
	end
	
    local fullangle = camera.rot + angle + fixC

	local newX = (radar.halfWidth-distFromLine*px) * math.sin(math.rad(fullangle))
	local newY = (radar.halfHeight-distFromLine*px) * -math.cos(math.rad(fullangle))
    return newX, newY
end

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

--====================================================================================================================================================================================================================--

local allowedToWork
triggerServerEvent("canIwork", resourceRoot, "XCCD")
function startWork(key)
	if (key == "XCCDplanet") then
		setPlayerHudComponentVisible("radar", false)
		bindKey("F11", "up", function()
			toggleRadar()
		end)
		toggleRadar(true)
		allowedToWork = true
	end
end
addEvent("youCanWork", true)
addEventHandler("youCanWork", resourceRoot, startWork)

--====================================================================================================================================================================================================================--

local radarIsVisible
function toggleRadar(state)
	if (state == true) and (not radarIsVisible) then
		addEventHandler('onClientHUDRender', root, renderRadar, true, "low")
		radarIsVisible = true
	elseif (state == false) and (radarIsVisible) then
		removeEventHandler('onClientHUDRender', root, renderRadar)
		radarIsVisible = false
	else
		toggleRadar(not radarIsVisible)
	end
end

--====================================================================================================================================================================================================================--

addEventHandler("onClientResourceStop", resourceRoot, function()
	setPlayerHudComponentVisible("radar", true)
end)

--====================================================================================================================================================================================================================--

local showPlayers
local playerBlips = {}

--====================================================================================================================================================================================================================--

addEventHandler("onClientResourceStart", resourceRoot, function()
	if fileExists("showPlayers/false") then
		showPlayers = false
	elseif fileExists("showPlayers/true") then
		showPlayers = true
	else
		showPlayers = "near"
	end
	refreshPlayerBlips()
	--[[for _, blip in ipairs(getElementsByType ("blip")) do
		table.insert (delayedBlips, blip)
	end]]
end)

--[[addEventHandler("onClientResourceStart", root, function()
	blips = {}
	for _, blip in ipairs(getElementsByType ("blip")) do
		table.insert (blips, blip)
	end
end)]]--


--====================================================================================================================================================================================================================--

function refreshPlayerBlips()
	for i, blip in pairs(playerBlips) do
		if isElement(blip) then destroyElement(blip) end
		playerBlips[i] = nil
	end
	if (showPlayers == "near") then
		for _, player in ipairs( getElementsByType("player") ) do
			local r,g,b = getPlayerNametagColor(player)
			playerBlips[player] = createBlipAttachedTo(player, 0, 2, r, g, b, 255, 0, 500)
		end
	elseif (showPlayers) then
		for _, player in ipairs( getElementsByType("player") ) do
			local r,g,b = getPlayerNametagColor(player)
			playerBlips[player] = createBlipAttachedTo(player, 0, 2, r, g, b)
		end
	else
		local r,g,b = getPlayerNametagColor(localPlayer)
		playerBlips[localPlayer] = createBlipAttachedTo(localPlayer, 0, 2, r, g, b)
	end
end

--====================================================================================================================================================================================================================--

function createBlipForPlayer(player)
	if isElement(player) then
		local r,g,b = getPlayerNametagColor(player)
		if (showPlayers == "near") then
			playerBlips[player] = createBlipAttachedTo(player, 0, 2, r, g, b, 255, 0, 500)
		elseif (showPlayers) then
			playerBlips[player] = createBlipAttachedTo(player, 0, 2, r, g, b)
		end
	end
end

--====================================================================================================================================================================================================================--

addEventHandler("onClientPlayerJoin", root, function()
	setTimer(createBlipForPlayer, 1000, 1, source)
end)

--====================================================================================================================================================================================================================--

addEventHandler("onClientPlayerQuit", root, function()
	if isElement(playerBlips[source]) then destroyElement(playerBlips[source]) end
end)

--====================================================================================================================================================================================================================--

function togglePlayerBlips()
	if (not allowedToWork) then return end
	if (showPlayers == "near") then
		if fileExists("showPlayers/true") then fileDelete("showPlayers/true") end
		fileClose(fileCreate("showPlayers/false"))
		showPlayers = false
		refreshPlayerBlips()
		outputChatBox("Показ игроков на карте отключен.", 30,255,30)

	elseif (showPlayers) then
		if fileExists("showPlayers/true") then fileDelete("showPlayers/true") end
		showPlayers = "near"
		refreshPlayerBlips()
		outputChatBox("Показ игроков на карте включен в ограниченном радиусе.", 30,255,30)

	else
		if fileExists("showPlayers/false") then fileDelete("showPlayers/false") end
		fileClose(fileCreate("showPlayers/true"))
		showPlayers = true
		refreshPlayerBlips()
		outputChatBox("Показ игроков на карте включен.", 30,255,30)

	end
end
addCommandHandler("players", togglePlayerBlips, false)

--====================================================================================================================================================================================================================--

function playersShowType()
	return showPlayers
end

--====================================================================================================================================================================================================================--

function getRadarCoords()
	return radar.x, radar.y, radar.width, radar.height
end
--====================================================================================================================================================================================================================--

-- ==========     Изменение цвета окантовки вокруг радара     ==========
-- Настройки
local radiusColorDelta = 5 
local restoreDelta = 10
local white = tocolor(255, 255, 255)

setTimer (function()
	local clr = getColor ()
	white = tocolor(unpack(clr))
end, 50, 1)

-- Переменные состояния
local customAnimation = false
local hasPolicemenInRadius, hasChase = false, false
local currentColor = {255, 255, 255}
local colorPhase = 1

function getRadarBorderColor()
	if (not customAnimation) then
		return white
	else
		if (hasChase) then
			if (colorPhase == 2) then
				local color = math.min(math.min(currentColor[1], currentColor[2]) + chaseColorDelta, 255)
				currentColor = {color, color, 255}
				if (color == 255) then
					colorPhase = 3
				end
				return tocolor(unpack(currentColor))
			
			elseif (colorPhase == 3) then
				local color = math.max(math.min(currentColor[2], currentColor[3]) - chaseColorDelta, 0)
				currentColor = {255, color, color}
				if (color == 0) then
					colorPhase = 4
				end
				return tocolor(unpack(currentColor))
			
			elseif (colorPhase == 4) then
				local color = math.min(math.min(currentColor[2], currentColor[3]) + chaseColorDelta, 255)
				currentColor = {255, color, color}
				if (color == 255) then
					colorPhase = 1
				end
				return tocolor(unpack(currentColor))
			
			else
				local color = math.max(math.min(currentColor[1], currentColor[2]) - chaseColorDelta, 0)
				currentColor = {color, color, 255}
				if (color == 0) then
					colorPhase = 2
				end
				return tocolor(unpack(currentColor))
			end
			
		elseif (hasPolicemenInRadius) then
			if (colorPhase == 4) then
				local b = math.min(currentColor[3] + radiusColorDelta, 255) 
				--local b = 255 - (255-g)/2
				currentColor = {255, 255, b}
				if (b == 255) then
					colorPhase = 3
				end
				return tocolor(unpack(currentColor))
				
			else
				local b = math.max(currentColor[3] - radiusColorDelta, 0)
				--local g = 255 - (255-b)/2
				currentColor = {255, 255, b}
				if (b == 0) then
					colorPhase = 4
				end
				return tocolor(unpack(currentColor))
			end
			print (currentColor[3])
		
		else
			currentColor = {
				math.min(255, currentColor[1]+restoreDelta),
				math.min(255, currentColor[2]+restoreDelta),
				math.min(255, currentColor[3]+restoreDelta),
			}
			if (currentColor[1] == 255) and (currentColor[2] == 255) and (currentColor[3] == 255) then
				--customAnimation = false
				return white
			else
				return tocolor(unpack(currentColor))
			end
		end
	end
end

-- Поиск погони за игроком или машиной, в которой он сидит
setTimer(function()
	if (getPlayerWantedLevel() == 0) then
		hasChase = false
		hasPolicemenInRadius = false
		return
	end
	
	local newChaseState = false
	if getElementData(localPlayer, "isChased") then
		newChaseState = true
	else
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (vehicle) then
			for _, occupant in pairs(getVehicleOccupants(vehicle)) do
				if getElementData(occupant, "isChased") then
					newChaseState = true
					break
				end
			end
		end
	end
	if (newChaseState) then
		hasChase = true
		customAnimation = true
	else
		hasChase = false
	end
end, 1000, 0)

-- Индикатор наличия полицейских в радиусе
local policemanNearTimer
addEvent("renewRadarBorder", true)
addEventHandler("renewRadarBorder", resourceRoot, function(state)
	if (state == "policemanNear") then
		if (getPlayerWantedLevel() == 0) then return end
		hasPolicemenInRadius = true
		customAnimation = true
		if isTimer(policemanNearTimer) then killTimer(policemanNearTimer) end
		policemanNearTimer = setTimer(resetPolicemanNearState, 15000, 1)
		
	else
		outputDebugString("Unknown state in renewRadarBorder: "..inspect(state), 2)
	end
end)

function resetPolicemanNearState()
	hasPolicemenInRadius = false
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
