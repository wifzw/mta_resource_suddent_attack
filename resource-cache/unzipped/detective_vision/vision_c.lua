local sw,sh = guiGetScreenSize()
local osw = sw/1280
local osh = sh/1024
local maxdist = 200
local vis = 0
local currentUse = false
local infoTable = {{"Health",true,nil},{"Armor",true,nil},{"Weapon",true,nil},{"Vehicle",true,nil},{"Team",true,"player"}}
local colors = {window=tocolor(0,0,200,130),windowHead=tocolor(0,0,0,180),windowHeadText=tocolor(255,0,0,255),windowText=tocolor(255,0,0,255)}

--BONES--
local lvl1bones = {[54] = 53,[53] = 52,[52] = 51,[51] = 1,[44] = 43,[43] = 42,[42] = 41,[41] = 1,[1] = 2,[2] = 3,[3] = 4,[26] = 25,[25] = 24,[24] = 23,[23] = 22,[21] = 22,
[36] = 35,[35] = 34,[34] = 33,[33] = 32,[31] = 32,[4] = 6,[6] = 7,[7] = 4,[32] = 41,[22] = 51}
local lvl2bones = {[5] = 32, [22] = 5, [24] = 23, [23] = 22, [32] = 33, [33] = 34, [1] = 5, [51] = 1, [41] = 1, [52] = 51, [42] = 41, [6] = 5, [53] = 52, [43] = 42}
local lvl3bones = {[24] = 23, [23] = 5, [34] = 33, [33] = 5, [1] = 5, [52] = 1, [42] = 1, [53] = 52, [43] = 42}
--BONES--

function getType(element)
	if isElement(element) then
	 return getElementType(element)
	else
	 return type(element)
	end
end

function isNormalValue(value)
	if getType(value) ~= "table" then
	return false, "Argument must be 'table'"
	elseif getType(value[1]) ~= "string" or getType(value[2]) ~= "string" then
	return false, "Value should be like '{string showingName, string elementData, player/ped/nil workingElement, [{childValue1,childValue2,..}]}"
	end
	if value[4] then
		if getType(value[4]) ~= "table" then
		return false, "Child values must be 'table'"
		else
			for i,value in ipairs(value[4]) do
			local isNormal, debugMessage = isNormalValue(value)
				if not isNormal then
				return isNormal, debugMessage
				end
			end
		end
	end
return true
end

function addWindowInfo(value)
local isNormal, debugMessage = isNormalValue(value)
	if not isNormal then
	return isNormal, debugMessage
	end
infoTable[#infoTable+1] = value
return true
end

function removeWindowInfo(v1,v2,v3)
if v1 then
	for i,value in ipairs(infoTable) do
		if value[1] == v1 then
			if v2 then
				if value[2] == v2 then
					if v3 then
						if value[3] == v3 then
						table.remove(infoTable,i)
						return true
						end
					else
					table.remove(infoTable,i)
					return true
					end
				end
			else
			table.remove(infoTable,i)
			return true
			end
		end
	end
end
return false
end

function table.ps(pl)
local scores = {}
local n = 0
local win = {}
	for k,v in pairs(pl) do
	table.insert(scores,v)
	end
table.sort(scores,function(a,b) return a<b end)
	for i,v in ipairs(scores) do
	n = n + 1
	local find = 0
		for e,r in pairs(pl) do
			if r == v and find ~= 1 then
			win[i] = e
			find = 1
			end
		end
	end
return win
end

function checkTarget(tab)
local target = table.ps(tab)[1]
	if target == getLocalPlayer() or target == nil then
	target = table.ps(tab)[2]
	end
	if target then
	drawInfoWindow(target)
	end
end

function getValue(ped,value,num)
local ret = getElementData(ped,value[2])
local space = " "
if ret then
	if value[4] then
		for i,value in ipairs(value[4]) do
		ret = tostring(ret).."\n"..space:rep(num+1)..value[1]..": "..tostring(getValue(ped,value,num+1))
		end
	end
end
return ret
end

function getStandartValue(ped,value)
local ret
	if value == "Health" then
	ret = math.floor(getElementHealth(ped))
	elseif value == "Armor" then
	ret = math.floor(getPedArmor(ped))
	elseif value == "Weapon" then
	local pedWeap = getPedWeapon(ped)
	ret = getWeaponNameFromID(pedWeap).." (ID: "..pedWeap..")"
	ret = ret.."\n Ammo: "..getPedTotalAmmo(ped)
	elseif value == "Vehicle" then
	local pedVeh = getPedOccupiedVehicle(ped)
	ret = "-"
		if pedVeh then
		local vModel = getElementModel(pedVeh)
		ret = getVehicleNameFromModel(vModel).." (ID: "..vModel..")\n Vehicle Health: "..math.ceil(getElementHealth(pedVeh))
			if getVehicleOccupant(pedVeh) == ped then
			ret = ret.."\n Seat: Driver"
			else
			ret = ret.."\n Seat: Passenger"
			end
		end
	elseif value == "Team" then
	local team = getPlayerTeam(ped)
	ret = team
		if team then
		ret = getTeamName(team)
		end
	end
 return ret
end

function drawInfoWindow(ped)
local pedType = getType(ped)
local color2 = tocolor(205,205,205,255)
local color3 = tocolor(50,50,50,255)
local txt = ""
local txtname = ""
local alltxt = ""
	if pedType == "player" then
	txtname = getPlayerName(ped)
	else
	txtname = string.upper(pedType)
	end

	if getElementHealth(ped) > 0 then
	txt = math.floor(getElementHealth(ped)) .. " HP"
	else
	txt = "DEAD"
	end
if getType(ped) == "player" then
local plteam = getPlayerTeam(ped)
	if (plteam) then
	local tr,tg,tb = getTeamColor(plteam)
	color2 = tocolor(255-tr,255-tg,255-tb,255)
	color3 = tocolor(tr,tg,tb,255)
	else
	color2 = tocolor(0,0,0,255)
	color3 = tocolor(255,255,255,255)
	end
end
local x8,y8,z8 = getPedBonePosition(ped,8)
local px8,py8 = getScreenFromWorldPosition(x8,y8,z8+0.3)
	if not px8 then
	x8,y8,z8 = getElementPosition(ped)
	px8,py8 = getScreenFromWorldPosition(x8,y8,z8)
	end
	for ind,value in ipairs(infoTable) do
	local vtxt = value[1]
		if not value[3] or value[3] == pedType then
			if value[2] == true then
			vtxt = vtxt..": "..tostring(getStandartValue(ped,vtxt))
			else
			vtxt = vtxt..": "..tostring(getValue(ped,value,0))
			end
			alltxt = alltxt..vtxt.."\n"
		end
	end
alltxt = alltxt:sub(1,alltxt:len()-1)
dxDrawText(txt,px8+1,py8-1,px8+1,py8-1,color2,1,"default-bold","center","center")
dxDrawText(txt,px8-1,py8+1,px8-1,py8+1,color2,1,"default-bold","center","center")
dxDrawText(txt,px8+1,py8+1,px8+1,py8+1,color2,1,"default-bold","center","center")
dxDrawText(txt,px8-1,py8-1,px8-1,py8-1,color2,1,"default-bold","center","center")
dxDrawText(txt,px8,py8,px8,py8,color3,1,"default-bold","center","center")
local _,amountOfN = string.gsub(alltxt,"\n","")
local windHeight = 35+15*(amountOfN+1)

dxDrawRectangle(sw-(osh*250+16),osh*650,osh*250,osh*windHeight,colors.window)
dxDrawRectangle(sw-(osh*250+16),osh*650,osh*250,osh*25,colors.windowHead)
dxDrawText(txtname,sw-(osh*250+16),osh*650,sw-6,osh*675,colors.windowHeadText,1,"default-bold","center","center")
dxDrawText(alltxt,sw-(osh*250+6),osh*680,sw-26,osh*850,colors.windowText,1 ,"default-bold","left","top",false,true)
end

function drawPedBones (ped)
local aList = {}
	if ped ~= getLocalPlayer() then
		local x,y,z = getCameraMatrix()
		local px,py,pz = getElementPosition(ped)
		local fDistance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
		if fDistance < 40 then
			aList = lvl1bones
		elseif fDistance < 90 and fDistance >= 40 then
			aList = lvl2bones
		elseif fDistance < maxdist and fDistance >= 90 then
			aList = lvl3bones
		end
		local playerTeam = nil
			if getType(ped) == "player" then
				playerTeam = getPlayerTeam( ped )
			end
		local red,green,blue = 200,200,200
			if playerTeam then
				red,green,blue = getTeamColor ( playerTeam )
			end
		local pedColor = tocolor(red,green,blue,255)
		for iFrom,iTo in pairs(aList) do
			local x1,y1,z1 = getPedBonePosition(ped,iFrom)
			local x2,y2,z2 = getPedBonePosition(ped,iTo)
				if not (x1 or x2) then
					return
				end
			local screenX1, screenY1 = getScreenFromWorldPosition ( x1,y1,z1 )
			local screenX2, screenY2 = getScreenFromWorldPosition ( x2,y2,z2 )
			if screenX1 and screenX2 then
			local scale = 25/fDistance
				if scale <= 1 then scale = 1 end
			dxDrawLine ( screenX1, screenY1, screenX2, screenY2, pedColor,scale)
			end
		end
	end
end

function drawBonesHandler()
local checkPeds = {}
local tx,ty
	if getControlState("aim_weapon") then
	 tx,ty = getScreenFromWorldPosition(getPedTargetEnd(getLocalPlayer()))
	else
	 tx,ty = sw/2,sh/2
	end
local lpx,lpy,lpz = getCameraMatrix()

	for i,pl in ipairs(getElementsByType("ped")) do
	local tpx,tpy,tpz = getElementPosition(pl)
	local px,py = getScreenFromWorldPosition(tpx,tpy,tpz)
		if px then
		local di = getDistanceBetweenPoints3D(lpx,lpy,lpz,tpx,tpy,tpz)
			if di < maxdist then
			drawPedBones(pl)
			checkPeds[pl] = ((tx-px)^2+(ty-py)^2)^0.5
			end
		end
	end
	for i,pl in ipairs(getElementsByType("player")) do
	local tpx,tpy,tpz = getElementPosition(pl)
	local px,py = getScreenFromWorldPosition(tpx,tpy,tpz)
		if px then
		local di = getDistanceBetweenPoints3D(lpx,lpy,lpz,tpx,tpy,tpz)
			if di < maxdist then
			drawPedBones(pl)
			checkPeds[pl] = ((tx-px)^2+(ty-py)^2)^0.5
			end
		end
	end
checkTarget(checkPeds)
end

--HANDLER

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),function()
local mtaVersion = tonumber(string.sub(getVersion()["mta"],1,3))
	if mtaVersion >= 1.1 then
		addEventHandler("onClientHUDRender",root,function ()
			if getCameraGoggleEffect() ~= "normal" then
			drawBonesHandler()
			currentUse = true
			else
			currentUse = false
			end
		end)
	else
	function useGoogles ()
		if isPedDoingTask ( getLocalPlayer (), "TASK_SIMPLE_GOGGLES_ON" ) and currentUse == false then
		addEventHandler("onClientRender",getRootElement(),drawBonesHandler)
		currentUse = true
		end
		if isPedDoingTask ( getLocalPlayer (), "TASK_SIMPLE_GOGGLES_OFF" ) and currentUse == true then
		removeEventHandler("onClientRender",getRootElement(),drawBonesHandler)
		currentUse = false
		end
	end

	function changeWeapon()
	setTimer (useGoogles, 50, 5 )
	local weapon = getPedWeapon (getLocalPlayer ())
		if weapon == 44 or weapon == 45 then
		setTimer (useGoogles, 50, 5 )
			if vis == 0 then vis = 1
			else vis = 0
			end
		end
	end

	setTimer(useGoogles,500,0)

	function hh()
	bindKey ("fire", "down", changeWeapon )
	end
	setTimer(hh,50,2)
	bindKey ("fire", "down", changeWeapon )
	addEventHandler("onClientPlayerWasted",getLocalPlayer(),function ()
	removeEventHandler("onClientRender",getRootElement(),drawBonesHandler)
	end)
	end
end)
