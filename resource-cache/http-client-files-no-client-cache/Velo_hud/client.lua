addEventHandler ( "onPlayerJoin", root, 
    function ()
        setPlayerHudComponentVisible ( source, "ammo", false )    -- Hide the ammo displays for the newly joined player
        setPlayerHudComponentVisible ( source, "weapon", false )  -- Hide the weapon displays for the newly joined player
    end
)


-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy

local screenW, screenH = guiGetScreenSize()
local resW, resH = 1366,768
local x, y = (screenW/resW), (screenH/resH)

local regular = exports['mrp_assets']:getFont('Elemental_End.ttf', 10)
local regular2 = exports['mrp_assets']:getFont('Elemental_End.ttf', 12)
local font = dxCreateFont('files/fonts/Elemental_End.ttf', 6)
local font2 = dxCreateFont('files/fonts/Elemental_End.ttf', 20)

--===================================================
--== DX.
--===================================================

addEventHandler('onClientRender', getRootElement(), function()
    --dxDrawText('FPS: '..(tonumber(counter2) or 0)..' | ID: '..(getElementData(localPlayer, 'ID') or 0)..' |', x*1057, y*745, x*1278, y*775, tocolor(255, 255, 255, 120), 1.00, regular, 'right', 'center', false, false, false, false, false)
    --dxDrawText('Normal', x*1168, y*608, x*1310, y*633, tocolor(255, 255, 255, 255), 1.00, regular, 'right', 'center', false, false, false, false, false)
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not vehicle then
        dxDrawImage(x*1132, y*634, x*218, y*95, 'files/img/backgroundP.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*962, y*656, x*160, y*50, 'files/img/'..getPedWeapon(localPlayer)..'.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
        if getPedWeapon(localPlayer) ~= 0 and 28 then
            dxDrawText(getPedAmmoInClip(localPlayer, getPedWeaponSlot(localPlayer))..'/'..getPedTotalAmmo(localPlayer) - getPedAmmoInClip(localPlayer), x*1032, y*706, x*1112, y*726, tocolor(255, 255, 255, 255), 1.00, font, 'center', 'center', false, false, false, false, false)
        end
        modestyRectangleRounded(x*1184, y*650, x*(100*1.45), y*25, '3', tocolor(31, 31, 31, 240), false)
        if getElementHealth(localPlayer) ~= 0 then
            modestyRectangleRounded(x*1184, y*650, x*((math.floor(getElementHealth(localPlayer)))*1.45), y*25, '3', tocolor(170, 0, 0, 240), false)
        end
        modestyRectangleRounded(x*1184, y*686, x*(100*1.45), y*25, '3', tocolor(31, 31, 31, 240), false)
        if getPedArmor(localPlayer) ~= 0 then
            modestyRectangleRounded(x*1184, y*686, x*((math.floor(getPedArmor(localPlayer)))*1.45), y*25, '3', tocolor(0, 150, 255, 240), false)
        end
        dxDrawImage(x*1108, y*606, x*42, y*43, 'files/img/coroa.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
end)

function modestyVoice()

end
addEventHandler('onClientRender', getRootElement(), modestyVoice)

function modestyVoice2()
    dxDrawImage(x*1310, y*608, x*30, y*25, 'files/img/mic1.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

addEventHandler('onClientPlayerVoiceStart', getRootElement(), function()
    if isEventHandlerAdded('onClientRender', getRootElement(), modestyVoice) then
        addEventHandler('onClientRender', getRootElement(), modestyVoice2)
        removeEventHandler('onClientRender', getRootElement(), modestyVoice)
    end
end)

addEventHandler('onClientPlayerVoiceStop', getRootElement(), function()
    if not isEventHandlerAdded('onClientRender', getRootElement(), modestyVoice) then
        addEventHandler('onClientRender', getRootElement(), modestyVoice)
        removeEventHandler('onClientRender', getRootElement(), modestyVoice2)
    end
end)

--===================================================
--== Essentials.
--===================================================

function modestyRectangleRounded(x, y, w, h, tipo, borderColor, bgColor, postGUI)
    borderColor = borderColor or tocolor(0, 0, 0, 200)
    bgColor = bgColor or borderColor
    dxDrawRectangle(x, y, w, h, bgColor, postGUI)
    if tipo == '3' then
        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI)
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI)
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI)
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI)
    end
end

function isEventHandlerAdded(sEventName, pElementAttachedTo, func)
    if type(sEventName) == 'string' and isElement(pElementAttachedTo) and type(func) == 'function' then
        local aAttachedFunctions = getEventHandlers(sEventName, pElementAttachedTo)
        if type(aAttachedFunctions) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs(aAttachedFunctions) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end


-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy


function convertNumber(number)
    local formatted = number
    while true do
        formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')
        if ( k==0 ) then
            break
        end
    end
    return formatted 
end

local counter = 0
local starttick
local currenttick

addEventHandler('onClientRender', root, function()
    if not starttick then
        starttick = getTickCount()
    end
    counter = counter + 1
    currenttick = getTickCount()
    if currenttick - starttick >= 1000 then
        counter2 = counter
        counter = 0
        starttick = false
    end
end)

local components = {'ammo', 'area_name', 'armour', 'breath', 'clock', 'health', 'money', 'radar', 'vehicle_name', 'weapon', 'radio', 'wanted'}

addEventHandler('onClientResourceStart', getResourceRootElement(getThisResource()),
function()
    for _, component in ipairs(components) do
		setPlayerHudComponentVisible(component, false)
	end
end)

function hou_circle(x, y, width, height, color, angleStart, angleSweep, borderWidth)
	height = height or width
	color = color or tocolor(255,255,255)
	borderWidth = borderWidth or 1e9
	angleStart = angleStart or 0
	angleSweep = angleSweep or 360 - angleStart
	if ( angleSweep < 360 ) then
		angleEnd = math.fmod( angleStart + angleSweep, 360 ) + 0
	else
		angleStart = 0
		angleEnd = 360
	end
	x = x - width / 2
	y = y - height / 2
	if not circleShader then
		circleShader = dxCreateShader('files/shaders/hou_circle.fx')
	end
	dxSetShaderValue(circleShader, 'sCircleWidthInPixel', width);
	dxSetShaderValue(circleShader, 'sCircleHeightInPixel', height);
	dxSetShaderValue(circleShader, 'sBorderWidthInPixel', borderWidth);
	dxSetShaderValue(circleShader, 'sAngleStart', math.rad(angleStart) - math.pi );
	dxSetShaderValue(circleShader, 'sAngleEnd', math.rad(angleEnd) - math.pi );
	dxDrawImage(x, y, width, height, circleShader, 0, 0, 0, color)
end

function getVehicleSpeed()
    if isPedInVehicle(getLocalPlayer()) then
	    local theVehicle = getPedOccupiedVehicle (getLocalPlayer())
        local vx, vy, vz = getElementVelocity (theVehicle)
        return math.sqrt(vx^2 + vy^2 + vz^2) * 165
    end
    return 0
end



-- Sitemiz : https://sparrow-mta.blogspot.com/
-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy