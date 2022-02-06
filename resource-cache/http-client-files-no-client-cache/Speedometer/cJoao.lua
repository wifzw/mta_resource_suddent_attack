local screen = {guiGetScreenSize()}
local x, y = (screen[1]/1366), (screen[2]/768)
local font = dxCreateFont('files/font.ttf', x*42, false)
local visible = true

function velocimetro ()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if vehicle and not getElementData(localPlayer, "BloqHud") then
        local kmh = getElementSpeed(vehicle, 2)
        local ymotor = ((getElementHealth(vehicle)) / 10)
        local ygasosa = (getElementData(vehicle, 'JOAO.fuel') or 100)
        dxDrawImage(x * 1068, y * 524, x * 263, y * 209, 'files/base.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(math.floor(tonumber(kmh)), x * 1131, y * 589, x * 1216, y * 649, tocolor(234, 223, 223, 255), 1.00, font, "center", "center", false, false, false, false, false)
        dxDrawRoundedRectangle(x * 1288, y * (690-(ymotor/100 * 129)), x * 18, y * (129 / 100 * ymotor), tocolor(139, 0, 255, 255), 3)
        dxDrawRoundedRectangle(x * 1313, y * (690-(ygasosa/100 * 129)), x * 18, y * (129 / 100 * ygasosa), tocolor(139, 0, 255, 255), 3)
        dxDrawImage(x * 1316, y * 672, x * 13, y * 13, 'files/fuel.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x * 1290, y * 672, x * 13, y * 13, 'files/motor.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)
        if isVehicleLocked(vehicle) then
            dxDrawImage(x * 1132, y * 685, x * 21, y * 21, "files/lock.png", 0, 0, 0, tocolor(139, 0, 255, 255))
        else
            dxDrawImage(x * 1132, y * 685, x * 21, y * 21, "files/lock.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        end
        if isVehicleDamageProof(vehicle) then
            dxDrawImage(x * 1207, y * 685, x * 21, y * 21, "files/blindagem.png", 0, 0, 0, tocolor(139, 0, 255, 255))
        else
            dxDrawImage(x * 1207, y * 685, x * 21, y * 21, "files/blindagem.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        end
        if getElementData(localPlayer, "cinto") then
            dxDrawImage(x * 1157, y * 685, x * 21, y * 21, "files/cinto.png", 0, 0, 0, tocolor(139, 0, 255, 255))
        else
            dxDrawImage(x * 1157, y * 685, x * 21, y * 21, "files/cinto.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        end
        if getElementData(localPlayer, "cinto") then
            dxDrawImage(x * 1182, y * 685, x * 21, y * 21, "files/light.png", 0, 0, 0, tocolor(139, 0, 255, 255))
        else
            dxDrawImage(x * 1182, y * 685, x * 21, y * 21, "files/light.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        end
        if (tonumber(kmh) <= 160) then
            hou_circle(x * 1172.5, y * 630, x * 209, y * 209, tocolor(145, 46, 222, 255), 226, kmh/0.6, 10)
        elseif (tonumber(kmh) >= 160) then
            hou_circle(x * 1172.5, y * 630, x * 209, y * 209, tocolor(145, 46, 222, 255), 226, 270, 10)
        end
    end
end
addEventHandler('onClientRender', root, velocimetro)

function loadMod (state)
    if visible == true  then
        removeEventHandler('onClientRender', root, velocimetro)
    else
        addEventHandler('onClientRender', root, velocimetro)
    end
    visible = state
end


function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function drawBorde(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200)
        end
      
        if (not bgColor) then
            bgColor = borderColor
        end        
        postGUI = false

        dxDrawRectangle(x, y, w, h, bgColor, postGUI)

        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI) -- top
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI) -- bottom
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI) -- left
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI) -- right
    end
end

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

----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy