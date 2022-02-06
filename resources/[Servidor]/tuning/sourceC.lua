local screenX, screenY = guiGetScreenSize()

local function reMap(x, in_min, in_max, out_min, out_max)
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

local responsiveMultipler = reMap(screenX, 1024, 1920, 0.75, 1)

local function respc(num)
    return math.ceil(num * responsiveMultipler)
end

local panelState = false

local RobotoFont = false
local RobotoFontBold = false

local headerHeight = respc(80)
local logoSize = headerHeight * 0.75

local buttons = {}
local activeButton = false
local sliderData = {}

local selectedVehicle = false

local buttonWidth = respc(160)
local buttonHeight = respc(30)

local selectPanelWidth = respc(450)
local selectPanelHeight = respc(500)
local selectPanelPosX = (screenX - selectPanelWidth) * 0.5
local selectPanelPosY = (screenY - selectPanelHeight) * 0.5
local selectLogoPosX = selectPanelPosX + respc(10)
local selectLogoPosY = selectPanelPosY + headerHeight / 2 - logoSize / 2

local colorPickerHSL = {hue = 0.5, saturation = 0.5, lightness = 0.5}
local colorPickerRGB = {red = 255, green = 255, blue = 255, hex = "#FFFFFF"}
local pickingColor = false
local pickingLuminance = false
local activeColorInput = false
local baseColorsEx = {}

local currentColor = 1

local tuningButtons = {
	{key = "closePanel", text = "Kapat!", type = "button"},
}

local vehicleData = {}

local exitingProcess = false

local screenAnim = false
local screenAnimMultipler = 0
local fullScreenMode = false

local showroomVehicle = false

local camera = false
local lastCursorPos = false
local lastPlayerPos = false

local promptDetails = false
local components = {"bonnet_dummy", "boot_dummy", "door_lf_dummy", "door_rf_dummy", "door_lr_dummy", "door_rr_dummy"}

local selectedCategory = 1
local selectedItem = 1
local selectedTuning = nil

local maxMenu = 0
local menuScroll = 0

function togglePanel(state, tuningId)

	if state then

		if not panelState then

			RobotoFont = dxCreateFont("files/fonts/Roboto-Regular.ttf", respc(17.5), false, "antialiased")
			RobotoFontBold = dxCreateFont("files/fonts/Roboto-Bold.ttf", respc(17.5), false, "antialiased")

			initTuning(tuningId)

			addEventHandler("onClientRender", getRootElement(), onRenderHandler)
			addEventHandler("onClientKey", getRootElement(), onKeyHandler, true, "low-500")
			addEventHandler("onClientClick", getRootElement(), onClickHandler)
			addEventHandler("onClientCharacter", getRootElement(), onCharacterHandler)

		end
		setElementData(localPlayer, 'BloqHud', true)
		setPlayerHudComponentVisible("radar", false)
		showChat(false)
		showCursor(true)

	else

		if panelState then

			removeEventHandler("onClientRender", getRootElement(), onRenderHandler)
			removeEventHandler("onClientKey", getRootElement(), onKeyHandler)
			removeEventHandler("onClientClick", getRootElement(), onClickHandler)
			removeEventHandler("onClientCharacter", getRootElement(), onCharacterHandler)

			setVehicleColor(showroomVehicle, unpack(vehicleData.lastColor)) 

			triggerServerEvent("leaveTuning", showroomVehicle, selectedTuning)

			resetTuning()			

			if isElement(RobotoFont) then
				destroyElement(RobotoFont)
			end
			RobotoFont = nil

			if isElement(RobotoFontBold) then
				destroyElement(RobotoFontBold)
			end
			RobotoFontBold = nil

		end
		setElementData(localPlayer, 'BloqHud', false)
		setPlayerHudComponentVisible("radar", true)
		showChat(true)
		showCursor(false)

	end

	buttons = {}
	activeButton = false
	activeFakeInput = false
	fakeInputValue = {}
	panelState = state

	visibleItem = 0

	pickingColor = false
	pickingLuminance = false
	activeColorInput = false

	fullScreenMode = false

end

addEvent("showTuning", true)
addEventHandler("showTuning", root, function(vehicle, id)
	setElementVelocity(vehicle, 0, 0, 0)
	setElementAngularVelocity(vehicle, 0, 0, 0)
	setAnalogControlState("accelerate", 0, true)
	togglePanel(true, id)
end)

function initTuning(tuningId)
	exitingProcess = true
	fadeCamera(false, 1)
	setTimer(
		function (tuningId)
			selectedTuning = tuningId

			addEventHandler("onClientPreRender", getRootElement(), onPreRenderHandler)

			showroomVehicle = getPedOccupiedVehicle(localPlayer)

			fillPaintjobsTable(showroomVehicle)

			vehicleData.lastColor = {getVehicleColor(showroomVehicle, true)}

			for k, v in pairs(tunings) do
				if v.effect then
					vehicleData[v.effect] = getElementData(showroomVehicle, "vehicle.tuning." .. v.effect) or 0
				end
			end
			
			local x, y, z, rz = unpack(tuningMarkers[tuningId])

			triggerServerEvent("enterTuning", showroomVehicle, tuningId, distanceFromLand)

			camera = {}
			camera.view = "base"
			camera.rotation = 45
			camera.height = -1.5
			camera.zoomLevel = 1
			camera.zoomInterpolate = false
			camera.moveInterpolate = false
			camera.startPos = false
			camera.stopPos = false
			camera.position = {x - 7.5 * math.sin(rz), y + 7.5 * math.cos(rz), z + 2.5, x, y, z}

			screenAnimMultipler = 0
			screenAnim = {getTickCount() + 250, 0, 1, "enteringProcess"}
			

			fadeCamera(true, 1)
			exitingProcess = false
		end,
	1000, 1, tuningId)
end

function resetTuning()
	removeEventHandler("onClientPreRender", getRootElement(), onPreRenderHandler)
	setCameraTarget(localPlayer)
end

function onPreRenderHandler(timeSlice)
	if not isElement(showroomVehicle) or not camera then
		return
	end

	if getKeyState("mouse1") and not isMTAWindowActive() and not pickingColor and not pickingLuminance and not promptDetails and not camera.moveInterpolate then
		local cursorX, cursorY = getCursorPosition()

		if tonumber(cursorX) then
			cursorX = cursorX * screenX
			cursorY = cursorY * screenY

			if not lastCursorPos then
				lastCursorPos = {
					onMoveStartX = cursorX,
					onMoveStartY = cursorY,
					yawStart = camera.rotation,
					pitchStart = camera.height
				}
			end

			camera.rotation = lastCursorPos.yawStart - (cursorX - lastCursorPos.onMoveStartX) / screenX * 270
			camera.height = lastCursorPos.pitchStart + (cursorY - lastCursorPos.onMoveStartY) / screenY * 20

			if camera.rotation > 360 then
				camera.rotation = camera.rotation - 360
			elseif camera.rotation < 0 then
				camera.rotation = camera.rotation + 360
			end

			local maxZ = math.abs(getElementDistanceFromCentreOfMassToBaseOfModel(showroomVehicle) - 1)

			if camera.height > maxZ then
				camera.height = maxZ
			elseif camera.height < -2 then
				camera.height = -2
			end
		end
	elseif lastCursorPos then
		lastCursorPos = false
	end

	if camera.zoomInterpolate then
		local elapsedTime = getTickCount() - camera.zoomInterpolate[1]
		local progress = elapsedTime / 150

		camera.zoomLevel = interpolateBetween(camera.zoomInterpolate[2], 0, 0, camera.zoomInterpolate[3], 0, 0, progress, "InOutQuad")

		if progress >= 1 then
			camera.zoomInterpolate = false
		end
	end

	if camera.moveInterpolate then
		local elapsedTime = getTickCount() - camera.moveInterpolate
		local progress = elapsedTime / 475

		camera.rotation, camera.height, camera.zoomLevel = interpolateBetween(
			camera.startPos[1], camera.startPos[2], camera.startPos[3],
			camera.stopPos[1] or camera.startPos[1], camera.stopPos[2] or camera.startPos[2], camera.stopPos[3] or camera.startPos[3],
			progress, "InOutQuad")

		if progress >= 1 then
			camera.moveInterpolate = false
			camera.zoomInterpolate = false
		end
	end

	local deltaX = camera.position[1] - camera.position[4]
	local deltaY = camera.position[2] - camera.position[5]
	local theta = math.rad(camera.rotation)

	setCameraMatrix(
		camera.position[4] + deltaX * math.cos(theta) - deltaY * math.sin(theta),
		camera.position[5] + deltaX * math.sin(theta) + deltaY * math.cos(theta),
		camera.position[3] + camera.height,
		camera.position[4],
		camera.position[5],
		camera.position[6],
		0, 70 / camera.zoomLevel
	)
end

function changeCamera(view)
	if not view or camera.view == view then
		return
	end

	camera.startPos = {camera.rotation, camera.height, camera.zoomLevel}

	if view == "base" then
		camera.stopPos = {45, -1.5, 1}
	elseif view == "front" then
		camera.stopPos = {0, -1.5, 1}
	elseif view == "rear" then
		camera.stopPos = {180, -1.5, 1}
	end

	camera.moveInterpolate = getTickCount()
	camera.view = view
end

function formatNumber(amount, stepper)
	local left, center, right = string.match(math.floor(amount), "^([^%d]*%d)(%d*)(.-)$")
	return left .. string.reverse(string.gsub(string.reverse(center), "(%d%d%d)", "%1" .. (stepper or " "))) .. right
end

function luminanceDistance(r1, g1, b1, r2, g2, b2)
	return math.abs((0.2126 * r1 + 0.7152 * g1 + 0.0722 * b1) - (0.2126 * r2 + 0.7152 * g2 + 0.0722 * b2))
end

function onRenderHandler()

	local currentMoney = getPlayerMoney(localPlayer)

	buttons = {}

	local cursorX, cursorY = getCursorPosition()

	if tonumber(cursorX) then
		cursorX = cursorX * screenX
		cursorY = cursorY * screenY
	end

	local vehicle = showroomVehicle
	local category = tunings[selectedCategory]

	--- ** Háttér
	if screenAnim and screenAnim[1] and getTickCount() >= screenAnim[1] then
		local elapsedTime = getTickCount() - screenAnim[1]
		local progress = elapsedTime / 475

		screenAnimMultipler = interpolateBetween(screenAnim[2], 0, 0, screenAnim[3], 0, 0, progress, "OutQuad")

		if progress > 1 then
			screenAnim[1] = false
		end
	end

	local sx, sy = screenX, headerHeight
	local x, y = 0, -sy + sy * screenAnimMultipler

	dxDrawRectangle(x, y, sx, sy, tocolor(47, 47, 47, 240))
	dxDrawRectangle(x, y, sx, sy, tocolor(75, 75, 75, 120))

	-- ** Cím
	local logoPosX = x + respc(10)
	local logoPosY = y + sy / 2 - logoSize / 2

	dxDrawImage(logoPosX, logoPosY, logoSize, logoSize, "files/icons/logo.png", 0, 0, 0, tocolor(255, 255, 255))
	dxDrawText("Modifiye Paneli - SparroWMTA", logoPosX + logoSize + (logoPosX - x), y, 0, y + sy, tocolor(255, 255, 255), 1, RobotoFont, "left", "center")

	dxDrawText("Cüzdandaki Paranız :\n#6fcc9f" .. formatNumber(currentMoney) .. "#ffffff $", x, y, sx + x, sy + y, tocolor(255, 255, 255), 0.65, RobotoFont, "center", "center", false, false, false, true)

	if exitingProcess or screenAnim[4] == "enteringProcess" then
		dxDrawRectangle(x, y + sy, sx, respc(4), tocolor(255, 130, 243, 255 * screenAnimMultipler))
	else
		dxDrawRectangle(x, y + sy, sx, respc(4), tocolor(255, 130, 243))
	end

	-- ** Főgombok
	local buttonStartPosX = x + sx - (buttonWidth + respc(10))

	for k = 1, #tuningButtons do
		local v = tuningButtons[k]
		local x2 = buttonStartPosX - (k - 1) * (buttonWidth + respc(10))
		local y2 = y + sy / 2 - buttonHeight / 2

		if v.type == "button" then
			if string.find(v.key, "close") then
				drawButton(v.key, v.text, x2, y2, buttonWidth, buttonHeight, tocolor(200, 50, 50))
			else
				drawButton(v.key, v.text, x2, y2, buttonWidth, buttonHeight, tocolor(255, 130, 243))
			end
		end
	end

	-- ** Alsó sáv
	local barHeight = respc(120)
	local barPosY = screenY - barHeight * screenAnimMultipler

	dxDrawRectangle(x, barPosY, sx, barHeight, tocolor(47, 47, 47, 240))

	if exitingProcess or screenAnim[4] == "enteringProcess" then
		dxDrawRectangle(x, barPosY - respc(4), sx, respc(4), tocolor(255, 130, 243, 255 * screenAnimMultipler))
	else
		dxDrawRectangle(x, barPosY - respc(4), sx, respc(4), tocolor(255, 130, 243))
	end

	-- ** Menü pontok
	local menuPosX, menuPosY = x + respc(35), barPosY + respc(10)
	local menuWidth, menuHeight = barHeight - respc(20), barHeight - respc(20) 
	local menuMargin = respc(10)

	maxMenu = math.floor(sx / (menuWidth + menuMargin))

	for i = 1, maxMenu do
		local tuning = tunings[i + menuScroll]

		if tuning then
			local mx = menuPosX + (menuWidth + menuMargin) * (i - 1)

			dxDrawRectangle(mx, menuPosY, menuWidth, menuHeight, tocolor(75, 75, 75))
			
			if activeButton == "menu:" .. i + menuScroll or selectedCategory == i + menuScroll then
				drawOutline(mx, menuPosY, menuWidth, menuHeight, tocolor(255, 130, 243))
			else
				drawOutline(mx, menuPosY, menuWidth, menuHeight, tocolor(125, 125, 125))
			end
			
			--if tuning.icon then
				dxDrawImage(mx + respc(15), menuPosY + respc(15), menuWidth - respc(30), menuHeight - respc(30), "files/icons/" .. ((tuning and tuning.icon) or "unavailable") .. ".png", 0, 0, 0, activeButton == "menu:" .. i and tocolor(255, 130, 243) or tocolor(255, 255, 255))
			--end

			buttons["menu:" .. i + menuScroll] = {mx, menuPosY, menuWidth, menuHeight}
		end
	end

	local sx, sy = respc(300), screenY - barHeight - headerHeight - respc(4)*2
	local x, y = screenX - sx * screenAnimMultipler, 0 + headerHeight + respc(4)
	local startY = y

	dxDrawRectangle(x, y, sx, sy, tocolor(47, 47, 47, 240))

	dxDrawText(category.name, x, y, x + sx, y + respc(50), tocolor(255, 255, 255), 1, RobotoFontBold, "center", "center")
	
	if category.description then
		dxDrawText(category.description, x, y + respc(55), x + sx, y + respc(40), tocolor(255, 255, 255), 0.575, RobotoFont, "center", "center")
	end

	dxDrawRectangle(x + respc(5), y + respc(70), sx - respc(10), 2, tocolor(255, 255, 255))

	if category.type ~= "color" then
		y = y + respc(35)

		local rowWidth, rowHeight = sx, respc(45)

		if category.subMenu then
			for i = 0, #category.subMenu do
				y = y + rowHeight

				local item = category.subMenu[i]

				if item then
					if i ~= #category.subMenu then
						dxDrawRectangle(x, y + rowHeight, sx, 2, tocolor(60, 60, 60, 160))
					end

					if selectedItem == i then
						dxDrawImage(x, y, sx, rowHeight, "files/active_menu_item.png", 0, 0, 0, tocolor(255, 255, 255, 255))
					elseif activeButton == "selectItem:" .. i then
						dxDrawImage(x, y, sx, rowHeight, "files/active_menu_item.png", 0, 0, 0, tocolor(255, 255, 255, 255))
					end

					dxDrawText(item.name .. " " .. (vehicleData[category.effect] == i and "#ffffff(Aktif)" or ""), x + respc(10), y, x + sx, y + rowHeight, tocolor(255, 255, 255), 0.6, RobotoFont, "left", "center", false, false, false, true)
					
					if item.price > currentMoney then
						dxDrawText(item.price > 0 and formatNumber(item.price) .. " $" or "Ücretsiz", x, y, x + sx - respc(10), y + rowHeight, tocolor(215, 89, 89), 0.6, RobotoFont, "right", "center")
					else
						dxDrawText(item.price > 0 and formatNumber(item.price) .. " $" or "Ücretsiz", x, y, x + sx - respc(10), y + rowHeight, tocolor(255, 255, 255), 0.6, RobotoFont, "right", "center")
					end
					buttons["selectItem:" .. i] = {x, y, rowWidth, rowHeight}
				end
			end

			if selectedItem then
				drawButton("install", "Uygula!", x + respc(10), startY + sy - buttonHeight - respc(10), sx - respc(20), buttonHeight, tocolor(255, 130, 243))
			end
		end
	elseif category.type == "color" then
		-- Színkeverő
		y = y + respc(85)

		local colorPickerSizeX = sx - respc(20)
		local colorPickerSizeY = respc(200)
		local colorPickerPosX = x + respc(10)
		local colorPickerPosY = y

		dxDrawImage(colorPickerPosX, colorPickerPosY, colorPickerSizeX, colorPickerSizeY, "files/colorpalette.png")
		drawOutline(colorPickerPosX, colorPickerPosY, colorPickerSizeX, colorPickerSizeY, tocolor(75, 75, 75))

		if pickingColor then
			colorPickerHSL.hue = reMap(cursorX - colorPickerPosX, 0, colorPickerSizeX, 0, 1)
			colorPickerHSL.saturation = reMap(cursorY - colorPickerPosY, 0, colorPickerSizeY, 1, 0)

			if colorPickerHSL.hue < 0 then
				colorPickerHSL.hue = 0
			elseif colorPickerHSL.hue > 1 then
				colorPickerHSL.hue = 1
			end

			if colorPickerHSL.saturation < 0 then
				colorPickerHSL.saturation = 0
			elseif colorPickerHSL.saturation > 1 then
				colorPickerHSL.saturation = 1
			end

			updateColorPicker(true)
		end

		buttons["colorPickerSelect"] = {colorPickerPosX, colorPickerPosY, colorPickerSizeX, colorPickerSizeY}

		-- Színkeverő pozíció
		local colorX = colorPickerPosX + reMap(colorPickerHSL.hue, 0, 1, 0, colorPickerSizeX) - respc(6)
		local colorY = colorPickerPosY + reMap(colorPickerHSL.saturation, 0, 1, colorPickerSizeY, 0) - respc(6)
		local r, g, b = hslToRgb(colorPickerHSL.hue, colorPickerHSL.saturation, 0.5)

		dxDrawRectangle(colorX - 1, colorY - 1, respc(12) + 2, respc(12) + 2, tocolor(0, 0, 0))
		dxDrawRectangle(colorX, colorY, respc(12), respc(12), tocolor(r * 255, g * 255, b * 255))

		-- Fényesség
		local luminanceSizeY = respc(12)
		local luminancePos = reMap(colorPickerHSL.lightness, 0, 1, 0, colorPickerSizeX)

		y = y + colorPickerSizeY + respc(10)

		dxDrawRectangle(colorPickerPosX - 1, y - 1, colorPickerSizeX + 2, luminanceSizeY + 2, tocolor(125, 125, 125))

		for i = 0, colorPickerSizeX do
			local r, g, b = hslToRgb(colorPickerHSL.hue, colorPickerHSL.saturation, i / colorPickerSizeX)
			dxDrawRectangle(colorPickerPosX + i, y, 1, luminanceSizeY, tocolor(r * 255, g * 255, b * 255))
		end

		dxDrawRectangle(colorPickerPosX + luminancePos - respc(4), y - respc(6), respc(8), luminanceSizeY + respc(12), tocolor(75, 75, 75))
		drawOutline(colorPickerPosX + luminancePos - respc(4), y - respc(6), respc(8), luminanceSizeY + respc(12), tocolor(125, 125, 125))

		if pickingLuminance then
			colorPickerHSL.lightness = reMap(cursorX - colorPickerPosX, 0, colorPickerSizeX, 0, 1)

			if colorPickerHSL.lightness < 0 then
				colorPickerHSL.lightness = 0
			elseif colorPickerHSL.lightness > 1 then
				colorPickerHSL.lightness = 1
			end

			updateColorPicker(true)
		end

		buttons["luminanceSelect"] = {colorPickerPosX, y, colorPickerSizeX, luminanceSizeY}

		-- RGB input
		local inputSizeX = dxGetTextWidth("255", 0.6, RobotoFont) + respc(12)
		local inputSizeY = respc(25)

		y = y + luminanceSizeY + respc(10)

		dxDrawText("RGB:", x + respc(10), y, 0, y + inputSizeY, tocolor(255, 255, 255), 0.75, RobotoFontBold, "left", "center")

		for k, v in pairs({"red", "green", "blue"}) do
			local x = x + sx - (inputSizeX + respc(10)) * 3 + (inputSizeX + respc(10)) * (k - 1)

			dxDrawRectangle(x, y, inputSizeX, inputSizeY, tocolor(75, 75, 75))

			if activeColorInput == v then
				drawOutline(x, y, inputSizeX, inputSizeY, tocolor(255, 130, 243))
			else
				buttons["colorInputSelect:" .. v] = {x, y, inputSizeX, inputSizeY}
			end

			dxDrawText(colorPickerRGB[v], x, y, x + inputSizeX, y + inputSizeY, tocolor(255, 255, 255), 0.6, RobotoFont, "center", "center")
		end

		-- HEX input
		y = y + inputSizeY + respc(10)

		dxDrawText("Kod:", x + respc(10), y, 0, y + inputSizeY, tocolor(255, 255, 255), 0.75, RobotoFontBold, "left", "center")

		local inputSizeX = dxGetTextWidth("#FFFFFF", 0.6, RobotoFont) + respc(12)
		local x2 = x + sx - (inputSizeX + respc(10))

		dxDrawRectangle(x2, y, inputSizeX, inputSizeY, tocolor(75, 75, 75))

		if activeColorInput == "hex" then
			drawOutline(x2, y, inputSizeX, inputSizeY, tocolor(255, 130, 243))
		else
			buttons["colorInputSelect:hex"] = {x2, y, inputSizeX, inputSizeY}
		end

		dxDrawText(colorPickerRGB["hex"], x2, y, x2 + inputSizeX, y + inputSizeY, tocolor(255, 255, 255), 0.6, RobotoFont, "center", "center")

		-- Szín állító
		y = y + inputSizeY + respc(10)
		drawButton("changecolor", "Renk : " .. currentColor, x + respc(10), y, sx - respc(20), buttonHeight, tocolor(255, 130, 243))
		
		drawButton("recolor", "Boya", x + respc(10), startY + sy - buttonHeight - respc(10) - buttonHeight - respc(10), sx - respc(20), buttonHeight, tocolor(255, 130, 243))
		drawButton("resetcolor", "İptal", x + respc(10), startY + sy - buttonHeight - respc(10), sx - respc(20), buttonHeight, tocolor(255, 130, 243))
	end

	y = y + respc(85)

	local rowNum = 4
	local marginSize = respc(20)
	local oneSize = (sx - (rowNum + 1) * marginSize) / rowNum

	-- ** Megerősítő panel
	if promptDetails then
		local _, newlines = utf8.gsub(promptDetails[2], "\n", "")
		local sx = dxGetTextWidth(promptDetails[2], 0.75, RobotoFont, true) + respc(40)
		local sy = respc(120) + newlines * dxGetFontHeight(0.75, RobotoFont)
		local x, y = screenX / 2 - sx / 2, screenY / 2 - sy / 2

		drawShadow(x, y, sx, sy, tocolor(0, 0, 0, 150))
		drawOutline(x - 1, y - 1, sx + 2, sy + 2, tocolor(50, 50, 50))
		dxDrawRectangle(x, y, sx, sy, tocolor(47, 47, 47, 240))

		dxDrawText(promptDetails[2], x, y + respc(20), x + sx, y + respc(20), tocolor(255, 255, 255), 0.75, RobotoFont, "center", "top", false, false, false, true)

		local sizeForButton = (sx - respc(60)) / 2

		y = y + sy - respc(40) - respc(20)

		drawButton("acceptPrompt", promptDetails[3] or "Aceitar", x + respc(20), y, sizeForButton, respc(40), tocolor(50, 200, 50))
		drawButton("declinePrompt", promptDetails[4] or "Recusar", x + respc(40) + sizeForButton, y, sizeForButton, respc(40), tocolor(200, 50, 50))
	end

	-- ** Jármű interakciók
	if fullScreenMode then
		activeVehiclePiece = false

		if not screenAnim[1] then
			local _, _, vehicleRotZ = getElementRotation(showroomVehicle)
			local cameraX, cameraY, cameraZ = getCameraMatrix()

			for i = 1, #components do
				local componentX, componentY, componentZ = getVehicleComponentPosition(showroomVehicle, components[i], "world")

				if componentX then
					if string.find(components[i], "door") then
						componentX, componentY = rotateAround(vehicleRotZ, 0, -1, componentX, componentY)
					end

					if getDistanceBetweenPoints3D(cameraX, cameraY, cameraZ, componentX, componentY, componentZ) <= 7.5 then
						local screenPosX, screenPosY = getScreenFromWorldPosition(componentX, componentY, componentZ)

						if screenPosX and screenPosY then
							local buttonSizeX = respc(80)
							local buttonSizeY = respc(35)

							screenPosX = screenPosX - buttonSizeX / 2
							screenPosY = screenPosY - buttonSizeY / 2

							local doorRatio = getVehicleDoorOpenRatio(showroomVehicle, i - 1)

							if doorRatio == 0 then
								drawButton("openCloseDoor:" .. i - 1, "Aç", screenPosX, screenPosY, buttonSizeX, buttonSizeY, tocolor(255, 130, 243))
							elseif doorRatio == 1 then
								drawButton("openCloseDoor:" .. i - 1, "Kapat", screenPosX, screenPosY, buttonSizeX, buttonSizeY, tocolor(200, 50, 50))
							end
						end
					end
				end
			end
		end

		local alpha = 1 - screenAnimMultipler
		local fontHeight = dxGetFontHeight(0.75, RobotoFont) * 1.5
		local lineHeight = respc(48)
		local linePosX = respc(15)
		local linePosY = barPosY - lineHeight * 1.5

		local totalWidth = 0
		local w1 = dxGetTextWidth("Normal Mod", 0.75, RobotoFont)
		local w2 = dxGetTextWidth("Hareketli Kamera", 0.75, RobotoFont)
		local w3 = dxGetTextWidth("Farlar", 0.75, RobotoFont)

		totalWidth = totalWidth + w1 + w2 + w3 + lineHeight * 3 + respc(10) * 3

		dxDrawRectangle(linePosX, linePosY, totalWidth, lineHeight, tocolor(47, 47, 47, 200 * alpha))
		drawOutline(linePosX, linePosY, totalWidth, lineHeight, tocolor(75, 75, 75, 255 * alpha))

		dxDrawImage(linePosX + respc(5), linePosY + (lineHeight - fontHeight) / 2, fontHeight, fontHeight, "files/icons/c.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText("Normal Mod", linePosX + lineHeight, linePosY, 0, linePosY + lineHeight, tocolor(255, 255, 255, 255 * alpha), 0.75, RobotoFont, "left", "center")

		linePosX = linePosX + lineHeight + w1 + respc(10)

		dxDrawImage(linePosX + respc(5), linePosY + (lineHeight - fontHeight) / 2, fontHeight, fontHeight, "files/mouse.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText("Hareketli Kamera", linePosX + lineHeight, linePosY, 0, linePosY + lineHeight, tocolor(255, 255, 255, 255 * alpha), 0.75, RobotoFont, "left", "center")

		linePosX = linePosX + lineHeight + w2 + respc(10)

		dxDrawImage(linePosX + respc(5), linePosY + (lineHeight - fontHeight) / 2, fontHeight, fontHeight, "files/icons/l.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText("Farlar", linePosX + lineHeight, linePosY, 0, linePosY + lineHeight, tocolor(255, 255, 255, 255 * alpha), 0.75, RobotoFont, "left", "center")
	else
		local alpha = screenAnimMultipler
		local fontHeight = dxGetFontHeight(0.75, RobotoFont) * 1.5
		local lineHeight = respc(48)
		local linePosX = respc(15)
		local linePosY = barPosY - lineHeight * 1.5

		local totalWidth = 0
		local w1 = dxGetTextWidth("Etkileşim", 0.75, RobotoFont)
		local w2 = dxGetTextWidth("Hareket", 0.75, RobotoFont)
		local w3 = dxGetTextWidth("Hareketli Kamera", 0.75, RobotoFont)

		totalWidth = totalWidth + w1 + w2 + w3 + lineHeight * 2 + respc(55) * 2

		dxDrawRectangle(linePosX, linePosY, totalWidth, lineHeight, tocolor(47, 47, 47, 200 * alpha))
		drawOutline(linePosX, linePosY, totalWidth, lineHeight, tocolor(75, 75, 75, 255 * alpha))

		dxDrawImage(linePosX + respc(5), linePosY + (lineHeight - fontHeight) / 2, fontHeight, fontHeight, "files/icons/c.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText("Etkileşim", linePosX + lineHeight, linePosY, 0, linePosY + lineHeight, tocolor(255, 255, 255, 255 * alpha), 0.75, RobotoFont, "left", "center")

		linePosX = linePosX + lineHeight + w1 + respc(10)

		dxDrawImage(linePosX + respc(5), linePosY + (lineHeight - fontHeight) / 2, fontHeight, fontHeight, "files/icons/arrow_l.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawImage(linePosX + respc(5) + fontHeight + respc(5), linePosY + (lineHeight - fontHeight) / 2, fontHeight, fontHeight, "files/icons/arrow_r.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText("Hareket", linePosX + lineHeight + fontHeight + respc(5), linePosY, 0, linePosY + lineHeight, tocolor(255, 255, 255, 255 * alpha), 0.75, RobotoFont, "left", "center")
	
		linePosX = linePosX + lineHeight + w2 + respc(40)

		dxDrawImage(linePosX + respc(5), linePosY + (lineHeight - fontHeight) / 2, fontHeight, fontHeight, "files/mouse.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText("Hareketli Kamera", linePosX + lineHeight, linePosY, 0, linePosY + lineHeight, tocolor(255, 255, 255, 255 * alpha), 0.75, RobotoFont, "left", "center")
	end

	-- ** Gombok kezelése
	activeButton = false

	if tonumber(cursorX) then
		for k, v in pairs(buttons) do
			if cursorX >= v[1] and cursorX <= v[1] + v[3] and cursorY >= v[2] and cursorY <= v[2] + v[4] then
				activeButton = k
				break
			end
		end
	end
end

function onKeyHandler(key, press)
	if exitingProcess then
		cancelEvent()
	end

	if key ~= "escape" and key ~= "F12" then
		cancelEvent()
	end

	if panelState then
		if not promptDetails and not activeColorInput and not pickingLuminance and not pickingColor and not fullScreenMode then
			if key == "backspace" and press then
				promptDetails = {"exitShowroom", "Çıkmak istediğine emin misin?", "Evet", "Hayır"}
				playSound("files/sounds/info.wav")
			end
		end

		if isElement(showroomVehicle) and not promptDetails then
			if press then
				if not activeColorInput and not pickingLuminance and not pickingColor then
					if key == "c" then
						if not screenAnim[1] then
							fullScreenMode = not fullScreenMode

							if fullScreenMode then
								changeCamera("front")
								screenAnim = {getTickCount(), 1, 0}
							else
								changeCamera("base")
								screenAnim = {getTickCount(), 0, 1}
							end

							for i = 0, 5 do
								setVehicleDoorOpenRatio(showroomVehicle, i, 0, 250)
							end

							setVehicleOverrideLights(showroomVehicle, 1)
						end
					elseif key == "l" and fullScreenMode then
						if not screenAnim[1] then
							if getVehicleOverrideLights(showroomVehicle) == 2 then
								setVehicleOverrideLights(showroomVehicle, 1)
							else
								setVehicleOverrideLights(showroomVehicle, 2)
							end
						end
					elseif key == "arrow_l" and not fullScreenMode then
						if #tunings > maxMenu then
							menuScroll = menuScroll - 1
							
							if menuScroll <= 0 then
								menuScroll = 0	
							end
						end
					elseif key == "arrow_r" and not fullScreenMode then
						if #tunings - maxMenu > menuScroll then
							menuScroll = menuScroll + 1

							if menuScroll > #tunings then
								menuScroll = #tunings
							end
						end
					end
				end
			end

			if isCursorShowing() and not isMTAWindowActive() then
				if camera then
					if (key == "mouse_wheel_up" or key == "mouse_wheel_down") and not camera.zoomInterpolate then
						local value = 0

						if key == "mouse_wheel_down" then
							if camera.zoomLevel > 0.5 then
								value = camera.zoomLevel - 0.2 * camera.zoomLevel
							end
						elseif camera.zoomLevel <= 1.75 then
							value = camera.zoomLevel + 0.2 * camera.zoomLevel
						end

						if value < 0.5 then
							value = 0.5
						elseif value > 1.75 then
							value = 1.75
						end

						camera.zoomInterpolate = {getTickCount(), camera.zoomLevel, value}
					end
				end
			end

			if activeColorInput then
				if key == "backspace" and press then
					if activeColorInput == "hex" then
						if utf8.len(colorPickerRGB[activeColorInput]) > 1 then
							colorPickerRGB[activeColorInput] = utf8.sub(colorPickerRGB[activeColorInput], 1, -2)

							if isElement(showroomVehicle) then
								local color = {getVehicleColor(showroomVehicle, true)}

								if currentColor == 1 then
									setVehicleColor(showroomVehicle, colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								elseif currentColor == 2 then
									setVehicleColor(showroomVehicle, color[1], color[2], color[3], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								elseif currentColor == 3 then
									setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								elseif currentColor == 4 then
									setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								end
							end
						end
					else
						if utf8.len(colorPickerRGB[activeColorInput]) > 0 then
							colorPickerRGB[activeColorInput] = tonumber(utf8.sub(colorPickerRGB[activeColorInput], 1, -2)) or 0

							colorPickerHSL.hue, colorPickerHSL.saturation, colorPickerHSL.lightness = rgbToHsl(colorPickerRGB.red / 255, colorPickerRGB.green / 255, colorPickerRGB.blue / 255)
							colorPickerRGB.hex = rgbToHex(colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)

							if isElement(showroomVehicle) then
								local color = {getVehicleColor(showroomVehicle, true)}

								if currentColor == 1 then
									setVehicleColor(showroomVehicle, colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								elseif currentColor == 2 then
									setVehicleColor(showroomVehicle, color[1], color[2], color[3], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								elseif currentColor == 3 then
									setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								elseif currentColor == 4 then
									setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
								end
							end
						end
					end
				end
			end
		end
	end
end

function onCharacterHandler(character)
	if exitingProcess or promptDetails then
		return
	end

	if not activeColorInput then
		return
	end

	character = utf8.upper(character)

	if activeColorInput == "hex" then
		if utf8.len(colorPickerRGB[activeColorInput]) < 7 and utf8.find("0123456789ABCDEF", character) then
			colorPickerRGB[activeColorInput] = colorPickerRGB[activeColorInput] .. character
		end

		if utf8.len(colorPickerRGB[activeColorInput]) >= 7 then
			local r, g, b = fixRGB(hexToRgb(colorPickerRGB[activeColorInput]))

			colorPickerHSL.hue, colorPickerHSL.saturation, colorPickerHSL.lightness = rgbToHsl(r / 255, g / 255, b / 255)
			colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue = r, g, b
		end

		if isElement(showroomVehicle) then
			local color = {getVehicleColor(showroomVehicle, true)}

			if currentColor == 1 then
				setVehicleColor(showroomVehicle, colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
			elseif currentColor == 2 then
				setVehicleColor(showroomVehicle, color[1], color[2], color[3], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
			elseif currentColor == 3 then
				setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
			elseif currentColor == 4 then
				setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
			end
		end
	else
		if tonumber(character) then
			if utf8.len(colorPickerRGB[activeColorInput]) < 3 then
				colorPickerRGB[activeColorInput] = tonumber(colorPickerRGB[activeColorInput] .. character)
			end

			if colorPickerRGB[activeColorInput] > 255 then
				colorPickerRGB[activeColorInput] = 255
			end

			colorPickerHSL.hue, colorPickerHSL.saturation, colorPickerHSL.lightness = rgbToHsl(colorPickerRGB.red / 255, colorPickerRGB.green / 255, colorPickerRGB.blue / 255)
			colorPickerRGB.hex = rgbToHex(colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)

			if isElement(showroomVehicle) then
				local color = {getVehicleColor(showroomVehicle, true)}

				if currentColor == 1 then
					setVehicleColor(showroomVehicle, colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
				elseif currentColor == 2 then
					setVehicleColor(showroomVehicle, color[1], color[2], color[3], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
				elseif currentColor == 3 then
					setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
				elseif currentColor == 4 then
					setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
				end
			end
		end
	end
end

function onClickHandler(button, state)
	if  exitingProcess or (screenAnim and screenAnim[1]) then
		return
	end

	if button == "left" then
		pickingColor = false
		pickingLuminance = false

		if activeButton then
			local buttonDetails = split(activeButton, ":")

			if state == "down" then
				if buttonDetails[1] == "openCloseDoor" then
					local door = tonumber(buttonDetails[2])

					if door then
						if getVehicleDoorOpenRatio(showroomVehicle, door) > 0 then
							setVehicleDoorOpenRatio(showroomVehicle, door, 0, 250)
						else
							setVehicleDoorOpenRatio(showroomVehicle, door, 1, 500)
						end
					end
				elseif activeButton == "acceptPrompt" then
					if promptDetails[1] == "exitShowroom" then
						screenAnim = {getTickCount(), 1, 0}
						exitingProcess = true

						fadeCamera(false, 1)
						setTimer(
							function ()
								togglePanel(false)
								fadeCamera(true, 1)
								exitingProcess = false
							end,
						1000, 1)
					end

					promptDetails = false
				elseif buttonDetails[1] == "menu" then
					selectedCategory = tonumber(buttonDetails[2])

					if tunings[selectedCategory].effect then
						selectedItem = vehicleData[tunings[selectedCategory].effect] or 0
					end
				elseif buttonDetails[1] == "selectItem" then
					selectedItem = tonumber(buttonDetails[2])

					local category = tunings[selectedCategory]

					--if category.name == "Paintjob" then
					--	iprint('paintjob')
					--end
				elseif activeButton == "install" then
					if selectedCategory and selectedItem then
						local category = tunings[selectedCategory]

						if category then
							local vehicle = getPedOccupiedVehicle(localPlayer)
							local level = selectedItem

							if getPlayerMoney(localPlayer) >= category.subMenu[level].price then 
								vehicleData[category.effect] = level
							end

							triggerServerEvent("applyTuning", vehicle, category.effect, level, category.subMenu[level].price)
						end
					end
				elseif activeButton == "changecolor" then
					currentColor = currentColor + 1
					
					if currentColor > 4 then
						currentColor = 1
					end
				elseif activeButton == "recolor" then
					local color = {getVehicleColor(showroomVehicle, true)}

					if currentColor == 1 then
						setVehicleColor(showroomVehicle, colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
					elseif currentColor == 2 then
						setVehicleColor(showroomVehicle, color[1], color[2], color[3], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
					elseif currentColor == 3 then
						setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
					elseif currentColor == 4 then
						setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue)
					end
					
					local vehicle = getPedOccupiedVehicle(localPlayer)
					triggerServerEvent("recolorVehicle", vehicle, {getVehicleColor(showroomVehicle, true)}, 500)
				elseif activeButton == "resetcolor" then
					setVehicleColor(showroomVehicle, unpack(vehicleData.lastColor))
					updateColorPicker()
				elseif activeButton == "declinePrompt" then
					if promptDetails then
						promptDetails = false
						playSound("files/sounds/error.wav")
					end
				elseif buttonDetails[1] == "colorInputSelect" and not promptDetails then
					if buttonDetails[2] then
						activeColorInput = buttonDetails[2]
					end
				elseif activeButton == "closeSelectPanel" and not promptDetails then
					togglePanel(false)
				elseif activeButton == "closePanel" and not promptDetails then
					promptDetails = {"exitShowroom", "Çıkmak istediğine emin misin?", "Evet", "Hayır"}
					playSound("files/sounds/info.wav")
				elseif activeButton == "colorPickerSelect" then
					if not promptDetails then
						pickingColor = true
					end
				elseif activeButton == "luminanceSelect" then
					if not promptDetails then
						pickingLuminance = true
					end
				end
			end
		else
			if state == "down" then
				activeColorInput = false
			end
		end
	end
end

addEvent("changeLastColor", true)
addEventHandler("changeLastColor", root, function(color)
	vehicleData.lastColor = color
end)

-- ////////////////////////////// --
-- Kisegítő funkciók
-- ////////////////////////////// --

function drawSlider(k, x, y, w, h, min, max)

	if not sliderData[k] then sliderData[k] = 0 end

	local cursorX, cursorY = getCursorPosition()

	if tonumber(cursorX) then
		cursorX = cursorX * screenX
		cursorY = cursorY * screenY
	end

	local sliderWidth = w
	local sliderHeight = h

	local sliderBaseX = x
	local sliderBaseY = y

	local sliderX = sliderBaseX + reMap(sliderData[k], min, max, 0, sliderWidth - respc(15))
	local sliderY = sliderBaseY + (respc(10) - sliderHeight) / 2
	y2 = sliderY

	dxDrawRectangle(sliderBaseX, sliderBaseY, sliderWidth, respc(10), tocolor(75, 75, 75))
	drawOutline(sliderBaseX, sliderBaseY, sliderWidth, respc(10), tocolor(125, 125, 125))

	dxDrawRectangle(sliderX, sliderY, respc(15), sliderHeight, tocolor(255, 130, 243))
	drawOutline(sliderX, sliderY, respc(15), sliderHeight, tocolor(50, 170, 255))

	if getKeyState("mouse1") and sliderMoveX then
		if activeSlider == k then
			local sliderValue = (cursorX - sliderMoveX - sliderBaseX) / (sliderWidth - respc(15))

			if sliderValue < 0 then
				sliderValue = 0
			end

			if sliderValue > 1 then
				sliderValue = 1
			end

			sliderData[k] = reMap(sliderValue, 0, 1, min, max)
		end
	else
		sliderMoveX = false
		activeSlider = false
	end

	if not sliderMoveX and activeButton == k then
		sliderMoveX = cursorX - sliderX
		activeSlider = k
	end


	buttons[k] = {sliderX, sliderY, respc(15), sliderHeight}
end

function drawShadow(x, y, sx, sy, color)
	dxDrawImage(x - 128, y - 128, sx + 256, sy + 256, "files/icons/shadow.png", 0, 0, 0, color)
end

function drawButton(k, text, x, y, sx, sy, hoverColor, bgColor)
	if bgColor then
		dxDrawRectangle(x, y, sx, sy, bgColor)
	else
		dxDrawRectangle(x, y, sx, sy, tocolor(75, 75, 75))
	end

	local borderColor = tocolor(125, 125, 125)
	if activeButton == k then
		borderColor = hoverColor
	end

	drawOutline(x, y, sx, sy, borderColor)
	dxDrawText(text, x, y, x + sx, y + sy, -1, 0.6, RobotoFont, "center", "center")

	buttons[k] = {x, y, sx, sy}
end

function drawButtonEx(k, text, x, y, sx, sy, active)
	local bgColor = tocolor(75, 75, 75, 200)
	local borderColor = tocolor(125, 125, 125, 200)

	if active then
		bgColor = tocolor(255, 130, 243, 200)
		borderColor = tocolor(50, 170, 190, 200)
	end

	if activeButton == k then
		if active then
			bgColor = tocolor(255, 130, 243)
			borderColor = tocolor(50, 170, 190)
		else
			bgColor =tocolor(75, 75, 75)
			borderColor = tocolor(125, 125, 125)
		end
	end

	dxDrawRectangle(x, y, sx, sy, bgColor)
	drawOutline(x, y, sx, sy, borderColor)
	dxDrawText(text, x, y, x + sx, y + sy, tocolor(255, 255, 255), 0.6, RobotoFont, "center", "center")

	buttons[k] = {x, y, sx, sy}
end

function drawOutline(x, y, sx, sy, color)
	dxDrawRectangle(x, y, 1, sy, color) -- bal
	dxDrawRectangle(x + sx - 1, y, 1, sy, color) -- jobb
	dxDrawRectangle(x, y, sx, 1, color) -- felső
	dxDrawRectangle(x, y + sy - 1, sx, 1, color) -- alsó
end

function updateColorPicker(renderUpdate, r, g, b)
	if renderUpdate then
		r, g, b = hslToRgb(colorPickerHSL.hue, colorPickerHSL.saturation, colorPickerHSL.lightness)
		r, g, b = fixRGB(r * 255, g * 255, b * 255)

		colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue = r, g, b
		colorPickerRGB.hex = rgbToHex(r, g, b)

		if isElement(showroomVehicle) then
			local color = {getVehicleColor(showroomVehicle, true)}

			if currentColor == 1 then
				setVehicleColor(showroomVehicle, r, g, b)
			elseif currentColor == 2 then
				setVehicleColor(showroomVehicle, color[1], color[2], color[3], r, g, b)
			elseif currentColor == 3 then
				setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], r, g, b)
			elseif currentColor == 4 then
				setVehicleColor(showroomVehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], r, g, b)
			end
		end
	elseif isElement(showroomVehicle) then
		if not r or not g or not b then
			r, g, b = getVehicleColor(showroomVehicle, true)
		end

		colorPickerHSL.hue, colorPickerHSL.saturation, colorPickerHSL.lightness = rgbToHsl(r / 255, g / 255, b / 255)
		colorPickerRGB.red, colorPickerRGB.green, colorPickerRGB.blue = r, g, b
		colorPickerRGB.hex = rgbToHex(r, g, b)
	end
end

function fixRGB(r, g, b, a)
	r = math.floor(r)
	g = math.floor(g)
	b = math.floor(b)
	a = a and math.floor(a) or 255

	if r < 0 then
		r = 0
	elseif r > 255 then
		r = 255
	end

	if g < 0 then
		g = 0
	elseif g > 255 then
		g = 255
	end

	if b < 0 then
		b = 0
	elseif b > 255 then
		b = 255
	end

	if a < 0 then
		a = 0
	elseif a > 255 then
		a = 255
	end

	return r, g, b, a
end

function hexToRgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

function rgbToHex(r, g, b, a)
	if (r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255) or (a and (a < 0 or a > 255)) then
		return false
	end

	if a then
		return string.format("#%.2X%.2X%.2X%.2X", r, g, b, a)
	else
		return string.format("#%.2X%.2X%.2X", r, g, b)
	end
end

function hslToRgb(h, s, l)
	local lightnessValue

	if l < 0.5 then
		lightnessValue = l * (s + 1)
	else
		lightnessValue = (l + s) - (l * s)
	end

	local lightnessValue2 = l * 2 - lightnessValue
	local r = hueToRgb(lightnessValue2, lightnessValue, h + 1 / 3)
	local g = hueToRgb(lightnessValue2, lightnessValue, h)
	local b = hueToRgb(lightnessValue2, lightnessValue, h - 1 / 3)

	return r, g, b
end

function hueToRgb(l, l2, h)
	if h < 0 then
		h = h + 1
	elseif h > 1 then
		h = h - 1
	end

	if h * 6 < 1 then
		return l + (l2 - l) * h * 6
	elseif h * 2 < 1 then
		return l2
	elseif h * 3 < 2 then
		return l + (l2 - l) * (2 / 3 - h) * 6
	else
		return l
	end
end

function rgbToHsl(r, g, b)
	local maxValue = math.max(r, g, b)
	local minValue = math.min(r, g, b)
	local h, s, l = 0, 0, (minValue + maxValue) / 2

	if maxValue == minValue then
		h, s = 0, 0
	else
		local different = maxValue - minValue

		if l < 0.5 then
			s = different / (maxValue + minValue)
		else
			s = different / (2 - maxValue - minValue)
		end

		if maxValue == r then
			h = (g - b) / different

			if g < b then
				h = h + 6
			end
		elseif maxValue == g then
			h = (b - r) / different + 2
		else
			h = (r - g) / different + 4
		end

		h = h / 6
	end

	return h, s, l
end

function getColorFromDecimal(decimal)
	local red = bitExtract(decimal, 16, 8)
	local green = bitExtract(decimal, 8, 8)
	local blue = bitExtract(decimal, 0, 8)
	local alpha = bitExtract(decimal, 24, 8)

	return red, green, blue, alpha
end


----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy