
sx, sy = guiGetScreenSize()
g, u = 330, 25
px, py = sx / 2 - g / 2, sy / 2 - u / 2

local logoanimspeed = 0
local bg, bu = sx, 25
local x, y = (sx - bg) / 41, (sy - bu) / 1

-- Import Shaders --

local fonte2 = dxCreateFont("fonts/fonte2.ttf", 15)

--- Desativar Botoes ---
buttonDisable = {
    { "disable_functions", --
      { ["F1"] = true, ["t"] = true, ["u"] = true, ["f2"] = true, ["F8"] = true, ["Console"] = true, ["tab"] = true, ["TAB"] = true }
    },
}

esccjanims = { -- 
    "shift",
    "shldr",
    "stretch",
    "strleg",
    "time",
}

--// Bloqueio de Teclas //--

addEventHandler("onClientKey", root, function(buton, attack)
    --
    for _, button_active in pairs(buttonDisable) do
        local veri, tus = unpack(button_active)
        if tus[buton] and getElementData(localPlayer, veri) then
            cancelEvent()
        end
    end
end)


-- Script Inicializado (O Que vai Acontecer) --

panel_status = "login_panel"

anim_start = getTickCount();
anim_startG = getTickCount();
anim_startK = getTickCount();
anim_startKK = getTickCount();

setElementPosition(localPlayer, 0, 0, -5)    -- Coloca o Player de baixo da terra (Evitar players matando).
setElementFrozen(localPlayer, true)
setFarClipDistance(8000)

showChat(false)
showCursor(true)
--exports["TG-Hud"]:CustomHud(false)
showPlayerHudComponent("all", false)
setElementData(localPlayer, "disable_functions", true)

local music = playSound("sfx/music.mp3", true)


-- Conta --
addEventHandler("onClientResourceStart", root, function()
    create_gui_element("section_entry")
    local username, password = loadLoginFromXML()
    if username ~= "" or password ~= "" then
        salve = true
        guiSetText(create_gui[1], tostring(username))
        guiSetText(create_gui[2], tostring(password))
    end
end)

local animX = 0
local animState = "-"

local sembol1 = ""
local sembol2 = ""


local anim1 = 2
local anim2 = 2
local anim3 = 2

-- Evento Selecão de Personagem --
local personagens = { 40, 44, 46, 69, 29, 14 } -- Personagens ID

local max_characters = #personagens

print1 = tocolor(255, 255, 255, 255)
print2 = tocolor(255, 255, 255, 255)

function character_advanced (character_value)
    character_value = character_value + 1
    if character_value > max_characters then
        character_value = 1
    end

    return character_value
end

function character_backward (character_value)
    character_value = character_value - 1
    if character_value < 1 then
        character_value = max_characters
    end

    return character_value
end

local zert = 1
function new_characters_advanced ()
    zert = character_advanced(zert)
    soundeffect()
    setPedAnimation(ped, "PLAYIDLES", esccjanims[math.random(#esccjanims)], -1, true, false, false, false)
    setElementModel(ped, personagens[zert])
    print2 = tocolor(22, 81, 140, 255)
    print1 = tocolor(255, 255, 255, 255)
end

function new_character_reversed ()
    zert = character_backward(zert)
    soundeffect()
    setPedAnimation(ped, "PLAYIDLES", esccjanims[math.random(#esccjanims)], -1, true, false, false, false)
    setElementModel(ped, personagens[zert])
    print1 = tocolor(22, 81, 140, 255)
    print2 = tocolor(255, 255, 255, 255)
end


--// Caixa de Edicao /--

create_gui = {}

function create_gui_element(type)
    if tostring(type) == "delete" then
        for i = 1, 6 do
            if isElement(create_gui[i]) then
                destroyElement(create_gui[i])
            end
        end

    elseif tostring(type) == "section_entry" then
        local username, password = loadLoginFromXML()
        create_gui[1] = guiCreateEdit(-1000, -1000, 0, 0, tostring(username) or "", false)
        guiEditSetMaxLength(create_gui[1], 22)

        create_gui[2] = guiCreateEdit(-1000, -1000, 0, 0, tostring(password) or "", false)
        guiEditSetMaxLength(create_gui[2], 22)

    elseif tostring(type) == "section_register" then
        create_gui[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
        guiEditSetMaxLength(create_gui[1], 22)
        create_gui[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
        guiEditSetMaxLength(create_gui[2], 22)
        create_gui[3] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
        guiEditSetMaxLength(create_gui[3], 22)
    end
end



-- Projeto --
function hidden_character_freeze(password)
    local length_ = utfLen(password)

    if length_ > 23 then
        length_ = 23
    end
    return string.rep("•", length_)
end

local texture = dxCreateTexture("images/mask.png", "dxt5")
local texture2 = dxCreateTexture("images/mask2.png", "dxt5")

function mask()
    dxDrawImage(0, 0, sx, sy, texture2, 0, 0, 0, tocolor(0, 0, 0, 200))
    dxDrawImage(0, 0, sx, sy, texture, 0, 0, 0, tocolor(0, 0, 0, 110))
end
setElementData(localPlayer, "Time", 0)
function log_design()
    if panel_status == "login_panel" then
        current = getTickCount()
        local opening_anim1 = interpolateBetween(0, 0, 0, py, 0, 0, (current - anim_start) / ((anim_start + 1000) - anim_start), "InBack")

        mask()

        button_create("Entrar", px, opening_anim1, g, u, 32, 63, 104, fonte2)
        button_create("Registrar", px, opening_anim1 + 30, 330, u, 160, 163, 104, fonte2)

        -- logo --
        if animState == "-" then
            animX = animX + logoanimspeed
            if animX >= 20 then
                animX = 20
                animState = "+"
            end
        elseif animState == "+" then
            animX = animX - logoanimspeed
            if animX <= 0 then
                animX = 0
                animState = "-"
            end
        end
        ax, ay = sx / 2, sy / 2 - 340 / 2 - 30

        local opening_anim2 = interpolateBetween(0, 0, 0, ay - 15 - animX / 2, 0, 0, (current - anim_start) / ((anim_start + 1250) - anim_start), "InBack")
        dxDrawImage(ax - (453 / 1.5) / 2 - animX / 2, opening_anim2, 453 / 1.5 + animX, 301 / 1.5 + animX, "images/logo.png", 0, 0, 0, tocolor(255, 255, 255, 200))

    elseif panel_status == "section_entry" then
        current2 = getTickCount()
        local opening_anim5 = interpolateBetween(0, 0, 0, px, 0, 0, (current2 - anim_startG) / ((anim_startG + 1250) - anim_startG), "OutBounce")

        -- Fundo
        mask()

        -- Caixa de nome de usuário
        local sembol1 = ""
        if editbox == "edit1" then
            anim1 = anim1 + 1
            if (anim1 < 40) then
                sembol1 = "|"
            end
            if (anim1 > 80) then
                anim1 = 0
            end
        end

        editbox_create(guiGetText(create_gui[1]) .. sembol1, opening_anim5, py + 50, g, u, tocolor(22, 81, 140, 255), "Usuário: " .. guiGetText(create_gui[1]), "")

        -- Caixa de Senha
        local sembol2 = ""
        if editbox == "edit2" then
            anim2 = anim2 + 1
            if (anim2 < 40) then
                sembol2 = "|"
            end
            if (anim2 > 80) then
                anim2 = 0
            end
        end

        editbox_create(hidden_character_freeze(guiGetText(create_gui[2])) .. sembol2, opening_anim5, py + 105, g, u, tocolor(22, 81, 140, 255), "Senha: " .. guiGetText(create_gui[2]), "")

        -- Cadastrar Conta
        checkbox_create("Lembrar Senha?", opening_anim5, py + 135, 20)

        if salve then
            dxDrawRectangle(opening_anim5 + 5, py + 140, 10, 10, tocolor(22, 81, 140, 255))
        end

        button_create("Entrar no servidor", opening_anim5, py + 160, g, u, 244, 66, 101, fonte2)
        button_create(" Voltar", opening_anim5, py + 190, g, u, 116, 22, 142, fonte2)

        if animState == "-" then
            animX = animX + logoanimspeed
            if animX >= 20 then
                animX = 20
                animState = "+"
            end
        elseif animState == "+" then
            animX = animX - logoanimspeed
            if animX <= 0 then
                animX = 0
                animState = "-"
            end
        end
        ax, ay = sx / 2, sy / 2 - 340 / 2 - 30

        local opening_anim7 = interpolateBetween(0, 0, 0, ay - 15 - animX / 2, 0, 0, (current2 - anim_startG) / ((anim_startG + 1250) - anim_startG), "InBack")
        dxDrawImage(ax - (453 / 1.5) / 2 - animX / 2, opening_anim7, 453 / 1.5 + animX, 301 / 1.5 + animX, "images/logo.png", 0, 0, 0, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 998)) * 255))

    elseif panel_status == "section_register" then

        current4 = getTickCount()

        local opening_anim10 = interpolateBetween(0, 0, 0, px, 0, 0, (current4 - anim_startKK) / ((anim_startKK + 1250) - anim_startKK), "OutBounce")

        -- Fundo
        mask()

        --Caixa de Edição do Usuário
        local sembol1 = ""
        if editbox == "edit3" then
            anim1 = anim1 + 1
            if (anim1 < 40) then
                sembol1 = "|"
            end
            if (anim1 > 80) then
                anim1 = 0
            end
        end

        editbox_create(guiGetText(create_gui[1]) .. sembol1, opening_anim10, py + 15, g, u, tocolor(22, 81, 140, 255), "Usuário: " .. guiGetText(create_gui[1]), "")

        -- şifre box2
        local sembol2 = ""
        if editbox == "edit4" then
            anim2 = anim2 + 1
            if (anim2 < 40) then
                sembol2 = "|"
            end
            if (anim2 > 80) then
                anim2 = 0
            end
        end

        editbox_create(hidden_character_freeze(guiGetText(create_gui[2])) .. sembol2, opening_anim10, py + 70, g, u, tocolor(22, 81, 140, 255), "Senha: " .. hidden_character_freeze(guiGetText(create_gui[2])), "")

        -- Novamente Caixa de senha 2
        local sembol3 = ""
        if editbox == "edit5" then
            anim3 = anim3 + 1
            if (anim2 < 40) then
                sembol3 = "|"
            end
            if (anim3 > 80) then
                anim3 = 0
            end
        end

        editbox_create(hidden_character_freeze(guiGetText(create_gui[3])) .. sembol3, opening_anim10, py + 122, g, u, tocolor(22, 81, 140, 255), "Confirme a senha: " .. hidden_character_freeze(guiGetText(create_gui[3])), "")

        -- botões [REGISTRO]
        button_create("Registrar", opening_anim10, py + 155, g, u, 150, 127, 12, fonte2)
        button_create(" Voltar", opening_anim10, py + 185, g, u, 150, 32, 11, fonte2)

        --Mesa Inferior
        local c = interpolateBetween(0, 0, 0, x, 0, 0, (current4 - anim_startKK) / ((anim_startKK + 1200) - anim_startKK), "InBack")
        local d = interpolateBetween(0, 0, 0, bg, 0, 0, (current4 - anim_startKK) / ((anim_startKK + 1200) - anim_startKK), "InBack")

        if animState == "-" then
            animX = animX + logoanimspeed
            if animX >= 20 then
                animX = 20
                animState = "+"
            end
        elseif animState == "+" then
            animX = animX - logoanimspeed
            if animX <= 0 then
                animX = 0
                animState = "-"
            end
        end
        ax, ay = sx / 2, sy / 2 - 340 / 2 - 30

        local opening_anim12 = interpolateBetween(0, 0, 0, ay - 15 - animX / 2, 0, 0, (current4 - anim_startKK) / ((anim_startKK + 1250) - anim_startKK), "InBack")
        dxDrawImage(ax - (453 / 1.5) / 2 - animX / 2, opening_anim12, 453 / 1.5 + animX, 301 / 1.5 + animX, "images/logo.png", 0, 0, 0, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 998)) * 255))


    elseif panel_status == "character_creation" then
        now3 = getTickCount()

        local opening_anim9 = interpolateBetween(0, 0, 0, px, 0, 0, (now3 - anim_startK) / ((anim_startK + 1200) - anim_startK), "InBack")

        local x, y, z = getElementPosition(localPlayer)
        local city = getZoneName(x, y, z, true)

        local bg1, bu1 = sx, 25
        local x1, y1 = (sx - bg) / 41, (sy - bu) / 1

        local a = interpolateBetween(0, 0, 0, x1, 0, 0, (now3 - anim_startK) / ((anim_startK + 1200) - anim_startK), "InBack")
        local b = interpolateBetween(0, 0, 0, bg1, 0, 0, (now3 - anim_startK) / ((anim_startK + 1200) - anim_startK), "InBack")

        sub_table("Use as teclas de seta para a direita e para a esquerda para selecionar os caracteres.", a, y1, b, bu1, tocolor(0, 0, 0, 180))
        create_panel(" Bem vindo(a).", opening_anim9 - 380 / 1.4, py - 70, 310, 170, tocolor(22, 81, 140, 2550), " Olá: #0066ff" .. getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "") .. "", " " .. getElementData(localPlayer, "Time"), " " .. city .. "", print1, print2)
        button_create(" Vamos começar", opening_anim9 - 380 / 1.4, py + 70, 310, u, 41, 35, 155, fonte2)
    end
end
addEventHandler("onClientRender", root, log_design)

--// Config Tela //--
local screen_locations1 = { guiGetScreenSize() }
local logo_size1 = { 53, 51 }
local image_locations1 = { screen_locations1[1] / 2 - logo_size1[1] / 2, screen_locations1[2] / 2 - logo_size1[2] / 2 }
local turn = 0

local anim_start_s = getTickCount()
local Fonte = dxCreateFont("fonts/fonte1.otf", 15)

--// EDITAR AONDE O PLAYER VAI ESTAR APOS SE REGISTRAR //--
--local bolgeler = {
--    --{ x , y , z }
--    { 0, 0, 0 }, -- /getpos { x , y , z }
--    { 1, 1, 1 },
--
--}

addEventHandler("onClientRender", root, function()
    if upload_status == true then
        current = getTickCount();
        opening_anim_load1 = interpolateBetween(0, 0, 0, screen_locations1[2], 0, 0, (current - anim_start_s) / ((anim_start_s + 2000) - anim_start_s), "Linear")
        opening_anim_load2 = interpolateBetween(0, 0, 0, image_locations1[2], 0, 0, (current - anim_start_s) / ((anim_start_s + 2000) - anim_start_s), "Linear")

        turn = turn + 2 > 360 and 0 or turn + 2

        dxDrawRectangle(0, 0, screen_locations1[1], opening_anim_load1, tocolor(0, 0, 0, 120));

        dxDrawImage(image_locations1[1] - 110, opening_anim_load2, logo_size1[1], logo_size1[2], "images/loading.png", turn, 0, 0, tocolor(22, 81, 140, 255), false)
        dxDrawText("Aguarde enquanto os dados do seu jogador estão sendo carregados!", image_locations1[1] - 50, opening_anim_load2 + 15, 120, 25, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 998)) * 255), 0.8, Fonte)
    end
end)


-- Eventos --
function click_event(button, state)
    if button == "left" and state == "down" then
        --* Login *--
        if isInSlot(px, py, g, u) and panel_status == "login_panel" then
            panel_status = "section_entry"
            anim_startG = getTickCount();
            create_gui_element("section_entry")
            soundbutton()
            return
        end

        --* Cadastrar *--
        if isInSlot(px, py + 30, 350, u) and panel_status == "login_panel" then
            panel_status = "section_register"
            anim_startKK = getTickCount();
            create_gui_element("section_register")
            soundbutton()
            return
        end

        --* Botao Voltar *--
        if isInSlot(px, py + 190, g, u) and panel_status == "section_entry" then
            panel_status = "login_panel"
            anim_start = getTickCount();
            create_gui_element("delete")
            sembol1 = ""
            sembol2 = ""
            anim1 = 0
            anim2 = 0
            soundbutton()
            return
        end

        --* Caixas de edição *--
        if isInSlot(px, py + 50, g, u) and panel_status == "section_entry" then
            if guiEditSetCaretIndex(create_gui[1], string.len(guiGetText(create_gui[1]))) then
                editbox = "edit1"
                anim1 = 1
                guiBringToFront(create_gui[1])
                soundbutton()
            end
            return
        end

        if isInSlot(px, py + 105, g, u) and panel_status == "section_entry" then
            if guiEditSetCaretIndex(create_gui[2], string.len(guiGetText(create_gui[2]))) then
                editbox = "edit2"
                anim2 = 1
                guiBringToFront(create_gui[2])
                soundbutton()
            end
            return
        end

        if isInSlot(px, py + 15, g, u) and panel_status == "section_register" then
            if guiEditSetCaretIndex(create_gui[1], string.len(guiGetText(create_gui[1]))) then
                editbox = "edit3"
                anim1 = 1
                guiBringToFront(create_gui[1])
                soundbutton()
            end
            return
        end

        if isInSlot(px, py + 70, g, u) and panel_status == "section_register" then
            if guiEditSetCaretIndex(create_gui[2], string.len(guiGetText(create_gui[2]))) then
                editbox = "edit4"
                anim2 = 1
                guiBringToFront(create_gui[2])
                soundbutton()
            end
            return
        end

        if isInSlot(px, py + 122, g, u) and panel_status == "section_register" then
            if guiEditSetCaretIndex(create_gui[3], string.len(guiGetText(create_gui[3]))) then
                editbox = "edit5"
                anim3 = 1
                guiBringToFront(create_gui[3])
                soundbutton()
            end
            return
        end

        --* Salvar Conta *--
        if isInSlot(px, py + 135, 20, 20) and panel_status == "section_entry" then
            salve = not salve
            soundbutton()
            return
        end

        --* Voltar para a seção de registro *--
        if isInSlot(px, py + 185, g, u) and panel_status == "section_register" then
            panel_status = "login_panel"
            anim_start = getTickCount();
            create_gui_element("delete")
            sembol1 = ""
            sembol2 = ""
            anim1 = 2
            anim2 = 2
            anim3 = 2
            soundbutton()
            return
        end

        --* Botão de login *--
        if isInSlot(px, py + 160, g, u) and panel_status == "section_entry" then
            local user = guiGetText(create_gui[1])
            local pas = guiGetText(create_gui[2])

            if salve then
                account_save = true
            else
                account_save = false
            end
            soundbutton()
            triggerServerEvent("Panel:Login", localPlayer, user, pas, account_save)
            return
        end

        --botão de registro *--
        if isInSlot(px, py + 155, g, u) and panel_status == "section_register" then
            user2 = guiGetText(create_gui[1])
            pas2 = guiGetText(create_gui[2])
            pasc = guiGetText(create_gui[3])

            triggerServerEvent("Panel:Register", localPlayer, user2, pas2, pasc)
            soundbutton()
            return
        end
        --* Toque *--
        if isInSlot(px - 380 / 2, py + 70, 310, u) and panel_status == "character_creation" then
            setFarClipDistance(750)
            stopSound(music)
            soundbutton()
            upload_status = true
            anim_start_s = getTickCount();
            destroyElement(ped)
            setElementDimension(localPlayer, 0)
            setCameraMatrix(1353.158203125, -1173.5380859375, 173.88003540039, 1289.9091796875, -1237.69921875, 130.48803710938)
            showCursor(false)

            unbindKey("arrow_l", "up", new_characters_advanced)
            unbindKey("arrow_r", "up", new_character_reversed)
            panel_status = "nil"

            setTimer(function()
                upload_status = false
                setElementModel(localPlayer, personagens[zert])

                --	setElementAlpha(localPlayer,255)
                setCameraTarget(localPlayer)
                setElementFrozen(localPlayer, false)

                --bolges = bolgeler[math.random(#bolgeler)]
                --setElementPosition(localPlayer, unpack(bolges))

                --exports["TG-Hud"]:CustomHud(true)
                --showPlayerHudComponent("all", true)
                showPlayerHudComponent("crosshair", true)
                --setElementData(localPlayer,"chatClose",0)
                showChat(true)
                setElementData(localPlayer, "disable_functions", false)


            end, 8000, 1)

            return
        end
    end
end
addEventHandler("onClientClick", root, click_event)

addEvent("LoginPanel:Hide", true)
addEventHandler("LoginPanel:Hide", root, function(isGuest, playerX, playerY, playerZ, playerInt, playerDim, playerSkin)

    if isGuest then
        panel_status = "character_creation"
        create_gui_element("delete")
        anim_startK = getTickCount();

        removeEventHandler("onClientRender", root, updateCamPosition)
        setCameraTarget(localPlayer)

        setCameraMatrix(1413.9775390625, -1475.0341796875, 70.367042541504, 1322.3408203125, -1437.2001953125, 57.279769897461)

        ped = createPed(0, 1410.81995, -1472.68347, 69.97146, 210) --  64 id Você ligou para o ped?

        setPedAnimation(ped, "PLAYIDLES", esccjanims[math.random(#esccjanims)], -1, true, false, false, false)
        setElementFrozen(ped, true)
        setElementDimension(ped, 20)
        setElementDimension(localPlayer, 20)
        --			setElementRotation(ped,0,0,155) -- o que você precisa disso ?? createPed(x,y,z,rot) Você entendeu.

        bindKey("arrow_l", "up", new_characters_advanced)
        bindKey("arrow_r", "up", new_character_reversed)
    else
        removeEventHandler("onClientRender", root, updateCamPosition)
        setFarClipDistance(750)
        stopSound(music)
        soundbutton()
        upload_status = true
        anim_start_s = getTickCount();

        showCursor(false)

        unbindKey("arrow_l", "up", new_characters_advanced)
        unbindKey("arrow_r", "up", new_character_reversed)
        panel_status = "nil"

        upload_status = false

        --	setElementAlpha(localPlayer,255)

        showPlayerHudComponent("crosshair", true)
        showChat(true)
        setElementData(localPlayer, "disable_functions", false)
    end
end)

addEvent("olay", true)
addEventHandler("olay", root, function()

    panel_status = "login_panel"

    anim_start = getTickCount();
    anim_startG = getTickCount();
    anim_startK = getTickCount();
    anim_startKK = getTickCount();

    showChat(false)
    showCursor(true)
    --exports["TG-Hud"]:CustomHud(false)
    showPlayerHudComponent("all", false)
    setElementData(localPlayer, "chatClose", 1)
    setElementData(localPlayer, "disable_functions", true)

    create_gui_element("section_entry")
    local username, password = loadLoginFromXML()
    if username ~= "" or password ~= "" then
        salve = true
        guiSetText(create_gui[1], tostring(username))
        guiSetText(create_gui[2], tostring(password))
    end
end)
-- Rascunho --

function checkbox_create(writing, x, y, w)
    if isInSlot(x, y, w, 20) then
        dxDrawRectangle(x, y, w, 20, tocolor(94, 94, 94, 160));
        dxDrawRecLine(x, y, 20, w, tocolor(22, 81, 140, 255))
        dxDrawText(writing, x + 23, y + 1, w + x, 20 + y, tocolor(255, 255, 255, 180), 0.8, Fonte, "left", "center", false, false, false, true)
    else
        dxDrawRectangle(x, y, w, 20, tocolor(94, 94, 94, 200));
        dxDrawText(writing, x + 23, y + 1, w + x, 20 + y, tocolor(255, 255, 255, 255), 0.8, Fonte, "left", "center", false, false, false, true)
    end
end

function create_text(writing, x, y, w, h, color)
    dxDrawText(writing, x + 23, y + 1, 20 + x, 20 + y, color, 0.8, fonte2, "left", "center", false, false, false, true)
end

function create_panel(writing, x, y, w, h, color, component1, component2, component3, color_y1, color_y2)
    dxDrawRectangle(x, y, w, h, tocolor(0, 0, 0, 160));
    dxDrawRectangle(x, y, w, 25, tocolor(0, 0, 0, 180));
    dxDrawRectangle(x, y + 25, w, 1, color);
    dxDrawText(writing, x - 1, y - 1, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "center", "center");
    -- components
    dxDrawText(component1, x + 5, y + 50, w, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true);
    dxDrawText(component2, x + 5, y + 100, w, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true);
    dxDrawText(component3, x + 5, y + 150, w, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true);
    --	dxDrawText(component4,x+5,y+210,w,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true);

    dxDrawText("", x + 260, y + 220, w, 25 + y, color_y1, 0.7, fonte2, "left", "center", false, false, false, true);
    dxDrawText("", x + 30, y + 220, w, 25 + y, color_y2, 0.7, fonte2, "left", "center", false, false, false, true);
    dxDrawText(" " .. getElementModel(ped), x + 140, y + 220, w, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true);
end

function editbox_create(writing, x, y, w, h, color, main, icon)
    if isInSlot(x, y, w, h) then
        dxDrawRectangle(x, y, w, h, tocolor(94, 94, 94, 160));
        dxDrawRecLine(x, y, w, h, color)
        dxDrawText(writing, x + 25, y - 2, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true)
        dxDrawText(main, x, y - 55, w + x, 25 + y, tocolor(255, 255, 255, 190), 0.7, fonte2, "center", "center", false, false, false, true)
        dxDrawText(icon, x + 5, y - 2, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true)
    else
        dxDrawRectangle(x, y, w, h, tocolor(94, 94, 94, 200));
        dxDrawText(writing, x + 25, y - 2, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true)
        dxDrawText(main, x, y - 55, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "center", "center", false, false, false, true)
        dxDrawText(icon, x + 5, y - 2, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, fonte2, "left", "center", false, false, false, true)
    end
end

function button_create(writing, x, y, w, h, r, g, b, font)

    if isInSlot(x, y, w, h) then
        dxDrawRectangle(x, y, w, h, tocolor(30, 30, 31, 120));
        dxDrawRecLine(x, y, w, h, tocolor(30, 30, 31, 255))

        dxDrawText(writing, x - 1, y - 1, w + x, 25 + y, tocolor(0, 0, 0, 255), 0.7, font, "center", "center")
        dxDrawText(writing, x, y, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, font, "center", "center")

    else

        dxDrawRectangle(x, y, w, h, tocolor(30, 30, 31, 255));
        dxDrawRecLine(x, y, w, h, tocolor(0, 102, 255, 255))

        dxDrawText(writing, x - 1, y - 1, w + x, 25 + y, tocolor(0, 0, 0, 255), 0.7, font, "center", "center")
        dxDrawText(writing, x, y, w + x, 25 + y, tocolor(255, 255, 255, 255), 0.7, font, "center", "center")

    end
end

function dxDrawRecLine(x, y, w, h, color)
    dxDrawRectangle(x, y, w, 1, color) -- h
    dxDrawRectangle(x, y + h, w, 1, color) -- h
    dxDrawRectangle(x, y, 1, h, color) -- v
    dxDrawRectangle(x + w - 1, y, 1, h, color) -- v
end

function sub_table(writing, x, y, w, h, color)
    dxDrawRectangle(x, y, w, h, color)
    dxDrawText(writing, x, y, w + x, 25 + y, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 998)) * 255), 0.7, Fonte, "center", "center", false, false, false, true)
end

function inBox(dX, dY, dSZ, dM, eX, eY)
    if (eX >= dX and eX <= dX + dSZ and eY >= dY and eY <= dY + dM) then
        return true
    else
        return false
    end
end

function isInSlot(xS, yS, wS, hS)
    if (isCursorShowing()) then
        XY = { guiGetScreenSize() }
        local cursorX, cursorY = getCursorPosition()
        cursorX, cursorY = cursorX * XY[1], cursorY * XY[2]
        if (inBox(xS, yS, wS, hS, cursorX, cursorY)) then
            return true
        else
            return false
        end
    end
end

-- salvar conta --

function loadLoginFromXML()
    local xml_save_log_File = xmlLoadFile("userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("userdata.xml", "login")
    end
    local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
    local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    else
        return "", ""
    end
    xmlUnloadFile(xml_save_log_File)
end

function saveLoginToXML(username, password)
    local xml_save_log_File = xmlLoadFile("userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("userdata.xml", "login")
    end
    if (username ~= "") then
        local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
        if not usernameNode then
            usernameNode = xmlCreateChild(xml_save_log_File, "username")
        end
        xmlNodeSetValue(usernameNode, tostring(username))
    end
    if (password ~= "") then
        local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
        if not passwordNode then
            passwordNode = xmlCreateChild(xml_save_log_File, "password")
        end
        xmlNodeSetValue(passwordNode, tostring(password))
    end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile(xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

function resetSaveXML()
    local xml_save_log_File = xmlLoadFile("userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("userdata.xml", "login")
    end
    if (username ~= "") then
        local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
        if not usernameNode then
            usernameNode = xmlCreateChild(xml_save_log_File, "username")
        end
        xmlNodeSetValue(usernameNode, "")
    end
    if (password ~= "") then
        local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
        if not passwordNode then
            passwordNode = xmlCreateChild(xml_save_log_File, "password")
        end
        xmlNodeSetValue(passwordNode, "")
    end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile(xml_save_log_File)
end
addEvent("resetSaveXML", true)
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)

-- Camera Anim --
local camX, camY, camZ, camX2, camY2, camZ2 = -1292.03333, 679.29205, 198.11470, 2059.5166015625, 1278.7858886719, 29.821063995361

local lastCamTick = 0
local camDist = getDistanceBetweenPoints3D(camX, camY, camZ, camX2, camY2, camZ)
local currentCamAngle = 270

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x + dx, y + dy;
end

function soundeffect()
    playSFX("script", 205, 0, false)
end

function soundbutton()
    playSFX("script", 192, 5, false)
end

function updateCamPosition ()
    local newCamTick = getTickCount()
    local delay = newCamTick - lastCamTick
    lastCamTick = newCamTick
    local angleChange = delay / 300
    currentCamAngle = currentCamAngle + angleChange
    local newX, newY = getPointFromDistanceRotation(camX, camY, camDist, currentCamAngle)
    setCameraMatrix(camX, camY, camZ, newX, newY, camZ2)
end
addEventHandler("onClientRender", getRootElement(), updateCamPosition)