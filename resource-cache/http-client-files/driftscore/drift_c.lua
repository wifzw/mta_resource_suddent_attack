local screenWidth,screenHeight = guiGetScreenSize()
local score = 0
local combo = 0
local multiplier = 1
local failDrift = false
local size = 0.9
local fps = getFPSLimit()
local vehicle
local inVehicle = false
local multipliers = {
{100000,5},
{50000,4},
{25000,3},
{10000,2},
{0,1},
}

local textX = screenWidth/2
local textY = screenHeight/4
local lineY = 45
local textScale = 0.95
local red = tocolor(255,0,0)
local green = tocolor(0,255,0)
local font = "bankgothic"
local alignX = "center"
local alignY = "center"

local gui = {}

local allowedType =
{
	["Automobile"] = true,
	["Quad"] = true,
	["Monster Truck"] = true,
}

local forcedEvents =
{
	["onClientElementDestroy"] = true,
	["onClientPlayerWasted"] = true,
}

local function convertNumber ( number )
	local formatted = number
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
		if ( k==0 ) then
			break
		end
	end
	return formatted
end

local function checkVehicleHandling()

	local flags = getVehicleHandling(vehicle)["handlingFlags"]
	if (bitAnd( flags, 32 ) == 32) or (bitAnd( flags, 64 ) == 64) then
		return true
	end
	
end

local function driftEnd (endscore,endcombo)
	local oldBestDrift = getElementData (localPlayer,"Best Drift") or 0
	local oldTotalDrift = getElementData (localPlayer,"Total Drift") or 0

	score = 0
	combo = 0
	
	if endscore ~= 0 then
		setElementData(localPlayer,"Total Drift",math.floor(endscore+oldTotalDrift))
		setElementData(localPlayer,"Last Drift",math.floor(endscore))
	end

	if endscore > oldBestDrift then
		setElementData(localPlayer,"Best Drift",endscore)
	end
	if endscore >= 2000 then
		triggerServerEvent("onDriftEnd",localPlayer,endscore)
		triggerEvent("onClientDriftEnd",localPlayer,endscore)
	end
end

local function calculateAngle ()
	if not allowedType[vehicle.vehicleType] then return 0,0 end
	if not isVehicleOnGround(vehicle) then return 0,0 end
	if failDrift then return 0,0 end
	
	local vx,vy,vz = getElementVelocity(vehicle)
	local rx,ry,rz = getElementRotation(vehicle)
	local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))
	local speed = (vx^2 + vy^2 + vz^2)^(0.5)
	local modV = math.sqrt(vx*vx + vy*vy)
	local cosX = (sn*vx + cs*vy)/modV
	
	if modV <= 0.2 then return 0,0 end
	if cosX > 0.966 or cosX < 0 then return 0,0 end
	
	return math.deg(math.acos(cosX))*0.5,speed
end

local function updateFPS(msSinceLastFrame)
    fps = (1 / msSinceLastFrame) * 1000
end

local function resetFail()

	failDrift = false
	showScore=false

end

local function onCollide(attacker)

	if attacker or failDrift then return end
	
	failDrift = true
	driftEnd(0,0)
	setTimer(resetFail,2000,1)
	
end

local function drawMeter ()
	if isWorldSpecialPropertyEnabled("hovercars") then return end
	if checkVehicleHandling() then return end
	
	if localPlayer.vehicle ~= vehicle then
		removeEventHandler("onClientVehicleDamage",vehicle,onCollide)
		removeEventHandler("onClientElementDestroy",vehicle,checkVehicle)
		removeEventHandler("onClientPlayerWasted",localPlayer,checkVehicle)
		removeEventHandler("onClientRender",root,drawMeter)
		removeEventHandler("onClientPreRender", root, updateFPS)
		vehicle=nil
		inVehicle=false
		checkVehicle()
		return
	end
	
	local angle,speed = calculateAngle()
	if isTimer (resetTimer) and angle ~= 0 then
		killTimer(resetTimer)
		showScore = true
		if comboReady then
			combo = combo + 1
			comboReady = false
		end
	end
	if angle == 0 then
		if not isTimer(resetTimer) then
			comboReady = true
			resetTimer = setTimer (function()
				if score == 0 then return end
				driftEnd (score,combo)
				score = 0
				combo = 0
				showScore = false
			end,1300,1)
		end
	end
	local gameSpeed = getGameSpeed()
	for k,v in ipairs(multipliers) do
		local pointsNeeded,multi = unpack(multipliers[k])
		if score > pointsNeeded then
			multiplier = multi
			break
		end
	end
	local fpsMultiplier = 100/fps
	local angleScore = angle/2
	local speedScore = speed*3
	local driftScore = angleScore*speedScore
	local addScore = math.floor(driftScore*multiplier)
	local gameSpeedFixedScore = math.floor(gameSpeed*addScore)
	score = score + math.floor(fpsMultiplier*gameSpeedFixedScore)
	if showScore then
		local color = (failDrift and red or green)
		dxDrawText ("Drift points x"..tostring(combo),textX,0,textX,textY-lineY,color,textScale,font,alignX,alignY)
		dxDrawText (score,textX,0,textX,textY,color,textScale,font,alignX,alignY)
	end

end

function checkVehicle(vehicleEntered)

	local isForcedFalse = forcedEvents[eventName] ~= true
	if localPlayer.inVehicle == inVehicle and isForcedFalse then return end
	
	local tempVehicle = vehicleEntered or getPedOccupiedVehicle(localPlayer)
	local seat = getPedOccupiedVehicleSeat(localPlayer)
	inVehicle = ((seat == 0 and allowedType[tempVehicle.vehicleType]) and (isForcedFalse and localPlayer.inVehicle or false) or false)

	if inVehicle and seat==0 then
		vehicle = tempVehicle
		addEventHandler("onClientVehicleDamage",vehicle,onCollide)
		addEventHandler("onClientElementDestroy",vehicle,checkVehicle)
		addEventHandler("onClientPlayerWasted",localPlayer,checkVehicle)
		addEventHandler("onClientRender",root,drawMeter)
		addEventHandler("onClientPreRender", root, updateFPS)
	elseif not inVehicle and vehicle then
		removeEventHandler("onClientVehicleDamage",vehicle,onCollide)
		removeEventHandler("onClientElementDestroy",vehicle,checkVehicle)
		removeEventHandler("onClientPlayerWasted",localPlayer,checkVehicle)
		removeEventHandler("onClientRender",root,drawMeter)
		removeEventHandler("onClientPreRender", root, updateFPS)
		vehicle=nil
	end

end

local function loadRecords(records,maxPosition,myAcc)

	guiSetText(gui.window,"Top "..tostring(maxPosition).." drifters")

	guiGridListClear(gui.list)
	local guestID = 0
	for position,record in ipairs(records) do
		local player,score,name,isGuest = record.username,record.score,record.playername,record.isGuest
		if isGuest == "true" then
			guestID=guestID+1
			if myAcc == "guest" then
				myAcc = hash("sha512",getPlayerSerial())
			end
		end
		local row = guiGridListAddRow(gui.list,"#"..tostring(position).." "..name,(isGuest == "true" and "guest_"..tostring(guestID) or player),convertNumber(score))
		if player == myAcc then
			guiGridListSetItemColor(gui.list,row,gui.namecolumn,0,255,0,255)
			guiGridListSetItemColor(gui.list,row,gui.usercolumn,0,255,0,255)
			guiGridListSetItemColor(gui.list,row,gui.scorecolumn,0,255,0,255)
		end
	end
	
end

local function toggleGUI()

	local isVisible = guiGetVisible(gui.window)
	
	if isVisible then
		guiSetVisible(gui.window,false)
		showCursor(false)
	else
		guiSetVisible(gui.window,true)
		showCursor(true)
	end

end

local function initScript()

	addEvent("onClientDriftEnd",false)
	addEvent("Drift:loadRecords",true)
	
	gui.window = guiCreateWindow(0.35,0.15,0.3,0.7,"",true)
	gui.list = guiCreateGridList(0,0.05,1,0.95,true,gui.window)
	gui.namecolumn = guiGridListAddColumn(gui.list,"Player",0.4)
	gui.usercolumn = guiGridListAddColumn(gui.list,"User",0.3)
	gui.scorecolumn = guiGridListAddColumn(gui.list,"Score",0.2)
	guiGridListSetSortingEnabled(gui.list,false)
	
	guiSetVisible(gui.window,false)
	
	bindKey("F5","down",toggleGUI)
	
	checkVehicle()
	addEventHandler("Drift:loadRecords",localPlayer,loadRecords)
	addEventHandler("onClientPlayerVehicleEnter",localPlayer,checkVehicle)
	addEventHandler("onClientPlayerVehicleExit",localPlayer,checkVehicle)
	
	triggerServerEvent("Drift:scriptLoaded",localPlayer)

end

addEventHandler("onClientResourceStart",resourceRoot,initScript)