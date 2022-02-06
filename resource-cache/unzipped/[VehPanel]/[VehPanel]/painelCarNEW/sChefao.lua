----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy


---> ---> ---> ---> ❪ função fora do veiculo ❫ <--- <--- <--- <---
function semcarro()
 exports.a_infobox:addBox(source, 'info', 'Bir Araçta Değilsin.')
end
addEvent("semcarro", true)
addEventHandler("semcarro", getRootElement(), semcarro)

function F5_flip()
    local vehicle = getPedOccupiedVehicle(source)
    if vehicle then
    if isPedInVehicle(source) then
        local rotX, rotY, rotZ = getElementRotation(vehicle)
        setVehicleRotation(vehicle, 0, 0, (rotX > 90 and rotX < 270) and (rotZ + 180) or rotZ)
    end
end
end
addEvent("F5_flip", true)
addEventHandler("F5_flip", getRootElement(), F5_flip)

---> ---> ---> ---> ❪ função motor ❫ <--- <--- <--- <---
function MOTORONOFF ()
local vehicle = getPedOccupiedVehicle(source)
local vehicleHealth = getElementHealth ( vehicle )
    if vehicle and vehicleHealth > 350  then
    if getVehicleEngineState( vehicle ) == true then
        setVehicleEngineState( vehicle, false )
        exports.a_infobox:addBox(source, 'error', 'Motor Kapalı')
    else
        setVehicleEngineState( vehicle, true )
        exports.a_infobox:addBox(source, 'success', 'Motor Açık')
    end
else
    exports.a_infobox:addBox(source, 'error', 'Araç Bozuldu.')
end
end
addEvent("motorligado", true)
addEventHandler("motorligado", root, MOTORONOFF)

---> ---> ---> ---> ❪ função luzes ❫ <--- <--- <--- <---
function LUZESONOFF ()
    local vehicle = getPedOccupiedVehicle(source)
    if vehicle then
    if getVehicleOverrideLights( vehicle ) == 2 then
        setVehicleOverrideLights( vehicle, 1, nil)
        exports.a_infobox:addBox(source, 'error', 'Farlar Kapalı')
    else
        setVehicleOverrideLights( vehicle, 2, nil )
        exports.a_infobox:addBox(source, 'success', 'Farlar Açık')
    end
end
end
addEvent("farolligado", true)
addEventHandler("farolligado", root, LUZESONOFF)

---> ---> ---> ---> ❪ função freio ❫ <--- <--- <--- <---
function FREIOONOFF ()
    local vehicle = getPedOccupiedVehicle(source)
    if vehicle then
    frozen = isElementFrozen( vehicle, false )

    if frozen == false then
    setElementFrozen ( vehicle , true, nil )
    exports.a_infobox:addBox(source, 'success', 'El Freni Çekildi')
else
    setElementFrozen ( vehicle , false, nil )
    exports.a_infobox:addBox(source, 'error', 'El Freni İndirildi')
    end
end
end
addEvent("freioativado", true)
addEventHandler("freioativado", getRootElement(), FREIOONOFF)

---> ---> ---> ---> ❪ função suspensao on ❫ <--- <--- <--- <---
function SUSPENSAOON()
        local vehicle = getPedOccupiedVehicle(source)
        if vehicle then
                if not vehicle then return end
                setVehicleHandling ( vehicle, "suspensionLowerLimit", (getVehicleHandling(vehicle)['suspensionLowerLimit'])-0.1 )
                exports.a_infobox:addBox(source, 'success', 'Araç Süspansiyonu Yükseltildi')
        end
    end
addEvent("subir", true)
addEventHandler("subir", root, SUSPENSAOON)

---> ---> ---> ---> ❪ função suspensao off ❫ <--- <--- <--- <---
function SUSPENSAOOFF()
        local vehicle = getPedOccupiedVehicle(source)
        if vehicle then
                if not vehicle then return end
                setVehicleHandling ( vehicle, "suspensionLowerLimit", (getVehicleHandling(vehicle)['suspensionLowerLimit'])+0.1 )
                exports.a_infobox:addBox(source, 'error', 'Araç Süspansiyonu Düşürüldü')
        end
    end
addEvent("descer", true)
addEventHandler("descer", root, SUSPENSAOOFF)

---> ---> ---> ---> ❪ função porta malas ❫ <--- <--- <--- <---
function PORTA6()
local vehicle = getPedOccupiedVehicle(source)
if vehicle then
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 1 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 1, 1, 2500)
        exports.a_infobox:addBox(source, 'success', 'Bagaj Açık')
    else
        setVehicleDoorOpenRatio(vehicle, 1, 0, 2500)
        exports.a_infobox:addBox(source, 'error', 'Bagaj Kapalı')
    end
end
end
addEvent("porta6", true)
addEventHandler("porta6", root, PORTA6)

---> ---> ---> ---> ❪ função porta p1 ❫ <--- <--- <--- <---
function Chefao_P1()
local vehicle = getPedOccupiedVehicle(source)
if vehicle then
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 2 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 2, 1, 2500)
        exports.a_infobox:addBox(source, 'success', 'Kapı Açık')
    else
        setVehicleDoorOpenRatio(vehicle, 2, 0, 2500)
        exports.a_infobox:addBox(source, 'error', 'Kapı Kapalı')
    end
end
end
addEvent("Chefao_P1", true)
addEventHandler("Chefao_P1", root, Chefao_P1)

---> ---> ---> ---> ❪ função porta p2 ❫ <--- <--- <--- <---
function Chefao_P2()
local vehicle = getPedOccupiedVehicle(source)
if vehicle then
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 3 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 3, 1, 2500)
        exports.a_infobox:addBox(source, 'success', 'Kapı Açık')
    else
        setVehicleDoorOpenRatio(vehicle, 3, 0, 2500)
        exports.a_infobox:addBox(source, 'error', 'Kapı Kapalı')
    end
end
end
addEvent("Chefao_P2", true)
addEventHandler("Chefao_P2", root, Chefao_P2)

---> ---> ---> ---> ❪ função porta p3 ❫ <--- <--- <--- <---
function Chefao_P3()
local vehicle = getPedOccupiedVehicle(source)
if vehicle then
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 4 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 4, 1, 2500)
        exports.a_infobox:addBox(source, 'success', 'Kapı Açık')
    else
        setVehicleDoorOpenRatio(vehicle, 4, 0, 2500)
        exports.a_infobox:addBox(source, 'error', 'Kapı Kapalı')
    end
end
end
addEvent("Chefao_P3", true)
addEventHandler("Chefao_P3", root, Chefao_P3)

---> ---> ---> ---> ❪ função porta p4 ❫ <--- <--- <--- <---
function Chefao_P4()
local vehicle = getPedOccupiedVehicle(source)
if vehicle then
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 5 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 5, 1, 2500)
        exports.a_infobox:addBox(source, 'success', 'Kapı Açık')
    else
        setVehicleDoorOpenRatio(vehicle, 5, 0, 2500)
        exports.a_infobox:addBox(source, 'error', 'Kapı Kapalı')
    end
end
end
addEvent("Chefao_P4", true)
addEventHandler("Chefao_P4", root, Chefao_P4)
