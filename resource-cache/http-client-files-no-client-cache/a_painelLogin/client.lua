-- TÜRKÇE Çeviri SparroWMTA 
-- Sitemiz : https://sparrow-mta.blogspot.com 
-- Facebook : https://www.facebook.com/sparrowgta/ 
-- İnstagram : https://www.instagram.com/sparrowmta/ 

local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)
local PainelLogin = false
local PainelPlayer = false
local PainelRegister = false
local rot = 0
local rot2 = 0
local fontP = dxCreateFont("fonts/Roboto-Regular.ttf", 10, false, "proof")
-- Arka plan lokasyon/pozisyon
cameraPosition = {
	{1204.375, -488.3369140625, 193.68672180176, 1254.0888671875, -709.73828125, 168.93957519531, 902.78125, -2046.1171875, 126.89632415771, 1326.005859375, -1506.82421875, 90.99028778076,40000},
	{2934.8251953125, -1903.3349609375, 63.389129638672, 2672.46484375, -1706.90234375, 71.158432006836, 2159.9765625, -1890.1640625, 52.366584777832, 1615.2890625, -2203.3125, 39.027252197266, 40000},
	{2019.3046875, -1851.3701171875, 8.8369693756104, 2039.3046875, -1851.3701171875, 8.8369693756104, 2496.412109375, -1851.8974609375, 3.7407033443451, 2516.412109375, -1851.8974609375, 3.7407033443451, 40000},
	{1479.1708984375, -907.7998046875, 157.27688598633, 1308.4365234375, -787.44921875, 101.86915588379, 153.45703125, -1725.8759765625, 200.7652130127, 530.95703125, -1193.9462890625, 69.442398071289, 40000},
	{878.455078125, -1545.142578125, 79.936729431152, 725.533203125, -1481.2529296875, 10.100814819336, 435.046875, -1927.6533203125, 56.113700866699, 722.794921875, -1934.84375, 5.0585250854492, 40000},
	{1564.96875, -1305.927734375, 400.03671264648, 1493.982421875, -1691.9453125, 26.627010345459, 1233.90234375, -1488.73828125, 140.12214660645, 898.9267578125, -1710.4404296875, 25.806222915649, 40000}
}

local Usuario = createElement("EditBoxAccount")
local Senha = createElement("EditBoxAccount")
--
local UsuarioR = createElement("EditBoxAccount")
local SenhaR = createElement("EditBoxAccount")
local EmailR = createElement("EditBoxAccount")

function loginMenu()
	dxDrawRectangle(x*0, y*0, screenW, screenH, tocolor(11, 11, 11,220))

	rot = rot+2/24
	rot2 = rot2-2/24

	local fftMul = 0
	if isElement(musicaPainel) then
		local FFT = getSoundFFTData(musicaPainel, 2048, 0)
		
		if FFT then
			FFT[1] = math.sqrt(FFT[1]) * 2

			if FFT[1] < 0 then
				FFT[1] = 0
			elseif FFT[1] > 1 then
				FFT[1] = 1
			end

			fftMul = FFT[1]

			dxDrawImage(0, 0, screenW, screenH, "images/lights.png", 0, 0, 0, tocolor(255, 255, 255, 255 * FFT[1]))
		end
	end

	dxDrawImage(x*50, y*95, x*1109, y*599, "images/bols.png", rot, 0, 0, tocolor(255,255,255,50))
	dxDrawImage(x*172, y*95, x*1109, y*599, "images/bols.png", rot2, 0, 0, tocolor(255,255,255,50))
	dxDrawRectangle(x*519, y*175, x*327, y*416, tocolor(40, 40, 40,255))
	dxDrawRectangle(x*519, y*175, x*327, y*30, tocolor(47, 47, 47,255))
	dxDrawRectangle(x*519, y*590, x*327, y*2, tocolor(0, 148, 255,255))

	dxDrawImage(x*600, y*224, x*166, y*90, "images/logo.png")

	dxDrawRectangleBorde(x*557, y*335, x*252, y*36, tocolor(75, 75, 75,255))
	dxDrawRectangleBorde(x*557, y*383, x*252, y*36, tocolor(75, 75, 75,255))

	dxDrawEditBox("Usuário", x*557, y*335, x*252, y*36, false, 15, Usuario)
	dxDrawEditBox("Senha", x*557, y*383, x*252, y*36, true, 15, Senha)
	--
	if cursorPosition(x*557, y*488, x*252, y*36) then
		dxDrawRectangleBorde(x*557, y*488, x*252, y*36, tocolor(102, 149, 152,255))
	else
		dxDrawRectangleBorde(x*557, y*488, x*252, y*36, tocolor(102, 149, 130,255))
	end
	--
	if cursorPosition(x*661, y*533, x*148, y*36) then
		dxDrawRectangleBorde(x*661, y*533, x*148, y*36, tocolor(150, 87, 87,255))
	else
		dxDrawRectangleBorde(x*661, y*533, x*148, y*36, tocolor(150, 87, 65,255))
	end
	--

	dxDrawText("Conecte-se", x*556, y*487, x*808, y*523, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Registro", x*660, y*533, x*808, y*569, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Conecte-se", x*519, y*174, x*846, y*206, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
end

function registerMenu()
	dxDrawRectangle(x*0, y*0, screenW, screenH, tocolor(11, 11, 11,220))

	rot = rot+2/24
	rot2 = rot2-2/24

	local fftMul = 0
	if isElement(musicaPainel) then
		local FFT = getSoundFFTData(musicaPainel, 2048, 0)
		
		if FFT then
			FFT[1] = math.sqrt(FFT[1]) * 2

			if FFT[1] < 0 then
				FFT[1] = 0
			elseif FFT[1] > 1 then
				FFT[1] = 1
			end

			fftMul = FFT[1]

			dxDrawImage(0, 0, screenW, screenH, "images/lights.png", 0, 0, 0, tocolor(255, 255, 255, 255 * FFT[1]))
		end
	end

	dxDrawImage(x*50, y*95, x*1109, y*599, "images/bols.png", rot, 0, 0, tocolor(255,255,255,50))
	dxDrawImage(x*172, y*95, x*1109, y*599, "images/bols.png", rot2, 0, 0, tocolor(255,255,255,50))

	dxDrawRectangle(x*519, y*175, x*327, y*416, tocolor(40, 40, 40,255))
	dxDrawRectangle(x*519, y*175, x*327, y*30, tocolor(47, 47, 47,255))
	dxDrawRectangle(x*519, y*590, x*327, y*2, tocolor(0, 148, 255,255))

	dxDrawImage(x*600, y*224, x*166, y*90, "images/logo.png")
	dxDrawImage(x*525, y*184, x*25, y*12, "images/return.png")

	dxDrawRectangleBorde(x*557, y*335, x*252, y*36, tocolor(75, 75, 75,255))
	dxDrawRectangleBorde(x*557, y*383, x*252, y*36, tocolor(75, 75, 75,255))
	dxDrawRectangleBorde(x*557, y*431, x*252, y*36, tocolor(75, 75, 75,255))

	dxDrawEditBox("Kullanıcı Adı", x*557, y*335, x*252, y*36, false, 15, UsuarioR)
	dxDrawEditBox("Şifre", x*557, y*383, x*252, y*36, true, 15, SenhaR)
	dxDrawEditBox("Email", x*557, y*431, x*252, y*36, false, 30, EmailR)
	--
	if cursorPosition(x*557, y*488, x*252, y*36) then
		dxDrawRectangleBorde(x*557, y*488, x*252, y*36, tocolor(102, 149, 152,255))
	else
		dxDrawRectangleBorde(x*557, y*488, x*252, y*36, tocolor(102, 149, 130,255))
	end
	--

	dxDrawText("Kayıt OL", x*556, y*487, x*808, y*523, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Giriş Yap", x*519, y*174, x*846, y*206, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
end

function personagemMenu()
	avatar = getElementData(localPlayer, "conta.Avatar") or 1
	dxDrawRectangle(x*0, y*0, screenW, screenH, tocolor(11, 11, 11,220))
	dxDrawImage(x*308, y*170, x*750, y*428, "images/bg.png")
	dxDrawImage(x*775, y*191, x*74, y*84, "avatars/"..avatar..".png")

	local nome = getElementData(localPlayer, "Nome") or "Desconhecido"
	local sobrenome = getElementData(localPlayer, "Último nome") or "Desconhecido"
	local idade = getElementData(localPlayer, "Idade") or "Desconhecido"
	local id = getElementData(localPlayer, "ID") or "Sem ID"
	local apelido = getPlayerName(localPlayer)
	local emprego = getElementData(localPlayer, "Emprego") or "Desempregado"
	local identidade = getElementData(localPlayer, "Identidade") or "Você não tem identidade"
	local cash = getElementData(localPlayer, "conta.Cash") or 0
	local dinheiro = getPlayerMoney(localPlayer)
	local saldo_banco = getElementData(localPlayer, "conta.Banco") or 0

	dxDrawText("Nome: "..nome, x*613, y*307, x*1007, y*332, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Ultimo Nome: "..sobrenome, x*613, y*335, x*1007, y*361, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Idade: "..idade, x*613, y*364, x*1007, y*386, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("ID: "..id, x*613, y*391, x*1007, y*416, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Apelido: "..apelido, x*613, y*420, x*1007, y*441, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Emprego: "..emprego, x*613, y*447, x*1007, y*472, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Identidade: "..identidade, x*613, y*476, x*1007, y*501, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Cash: "..cash, x*613, y*503, x*1007, y*526, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Dinheiro: "..dinheiro, x*613, y*530, x*1007, y*555, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)
	dxDrawText("Saldo Bancário: "..saldo_banco, x*613, y*559, x*1007, y*584, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)

	if cursorPosition(x*609, y*258, x*135, y*30) then
		dxDrawRectangleBorde(x*609, y*258, x*135, y*30, tocolor(102, 149, 152,255))
	else
		dxDrawRectangleBorde(x*609, y*258, x*135, y*30, tocolor(102, 149, 130,255))
	end
	dxDrawText("Oyuna Başla", x*607, y*255, x*746, y*291, tocolor(255, 255, 255, 255), 1.00, fontP, "center", "center", false, false, false, false, false)

	dxDrawImage(x*747, y*237, x*129, y*8, "images/seta.png")
end

function criarPed()
    local skin = getElementModel(localPlayer)
    x1, y1, z1 = getCameraMatrix()
    pedHorizon = createPed(skin, x1, y1, z1)
    pedHype = exports.object_preview:createObjectPreview(pedHorizon, 0, 0, 170, x*255, y*114, x*351, y*499, false, true, true)
end

function destruirPed()
    exports.object_preview:destroyObjectPreview(pedHype)
    destroyElement(pedHorizon)
    pedHorizon = nil
end

local i = 1
local dx = 0.0

function renderCamera()
	if dx < 1 then
		dx = dx+0.001
		local _x, _y, _z = interpolateBetween ( cameraPosition[i][1], cameraPosition[i][2], cameraPosition[i][3], cameraPosition[i][4], cameraPosition[i][5], cameraPosition[i][6], dx, "SineCurve")
		setCameraMatrix ( _x, _y, _z, cameraPosition[i][7], cameraPosition[i][8], cameraPosition[i][9])
	elseif dx > 0 then
		_x, _y, _z = nil, nil, nil
		dx = 0.0
		i = i + 1
		if ( i >= 7) then
			i = 1
			dx = 0.0
		end	
	end
end

function onLoginStart()
	PainelLogin = true
	addEventHandler("onClientRender", getRootElement(), loginMenu)
	addEventHandler("onClientRender", getRootElement(), renderCamera)
	showCursor(true)
	showChat(false)
	exports.a_infobox:showInfobox("info", "Bem-vindo ao Suddent Attack!")
	musicaPainel = playSound("music.mp3")
	setSoundVolume(musicaPainel, 0.3)
end
addEventHandler("onPlayerJoin", getRootElement(), onLoginStart)
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onLoginStart)

addEvent("removeLogin", true)
addEventHandler("removeLogin", getRootElement(), 
	function()
		if PainelLogin == true then
			addEventHandler("onClientRender", getRootElement(), personagemMenu)
			criarPed()
			setCameraTarget(localPlayer, localPlayer)
			removeEventHandler("onClientRender", getRootElement(), loginMenu)
			removeEventHandler("onClientRender", getRootElement(), renderCamera)
			removeEventHandler("onClientRender", getRootElement(), registerMenu)
			PainelLogin = false
			PainelRegister = false
			PainelPlayer = true
			stopSound(musicaPainel)
		end
	end
)

addEventHandler("onClientClick", getRootElement(),
	function(b, s)
		if PainelLogin == true then
			if (b == "left") and (s == "down") then
				if cursorPosition(x*661, y*533, x*148, y*36) then
					PainelRegister = true
					PainelLogin = false
					addEventHandler("onClientRender", getRootElement(), registerMenu)
					removeEventHandler("onClientRender", getRootElement(), loginMenu)
				end
			end
		end
	end
)

addEventHandler("onClientClick", getRootElement(),
	function(b, s)
		if PainelRegister == true then
			if (b == "left") and (s == "down") then
				if cursorPosition(x*525, y*184, x*25, y*12) then
					PainelLogin = true
					PainelRegister = false
					removeEventHandler("onClientRender", getRootElement(), registerMenu)
					addEventHandler("onClientRender", getRootElement(), loginMenu)
				end
			end
		end
	end
)

addEventHandler("onClientClick", getRootElement(),
	function(b, s)
		if PainelPlayer == true then
			if (b == "left") and (s == "down") then
				if cursorPosition(x*609, y*258, x*135, y*30) then
					PainelPlayer = false
					PainelPlayer = false
					PainelLogin = false
					showChat(true)
					showCursor(false)
					destruirPed()
					removeEventHandler("onClientRender", getRootElement(), registerMenu)
					removeEventHandler("onClientRender", getRootElement(), personagemMenu)
					removeEventHandler("onClientRender", getRootElement(), renderCamera)
					removeEventHandler("onClientRender", getRootElement(), loginMenu)
				end
			end
		end
	end
)

addEventHandler("onClientClick", getRootElement(),
	function(b, s)
		if PainelLogin == true then
			if (b == "left") and (s == "down") then
				if cursorPosition(x*557, y*488, x*252, y*36) then
					local username = getElementData(Usuario, "text")
					local password = getElementData(Senha, "text")
					triggerServerEvent("hasClickLogin", localPlayer, username, password)
				end
			end
		end
	end
)

addEventHandler("onClientClick", getRootElement(),
	function(b, s)
		if PainelRegister == true then
			if (b == "left") and (s == "down") then
				if cursorPosition(x*557, y*488, x*252, y*36) then
					local username = getElementData(UsuarioR, "text")
					local password = getElementData(SenhaR, "text")
					local email = getElementData(EmailR, "text")
					triggerServerEvent("hasClickRegister", localPlayer, username, password, email)
				end
			end
		end
	end
)

addEventHandler("onClientClick", getRootElement(),
	function(button, state)
	    if PainelPlayer == true then  
	        if button == "left" and state == "down" then
	            if cursorPosition(x*744, y*233, x*26, y*8) then 
	                if avatar > 1 then
	                	setElementData(getLocalPlayer(), "conta.Avatar", avatar - 1)
	                end
	            end
	            if cursorPosition(x*854, y*233, x*26, y*8) then 
	                if avatar < 20 then
	                	setElementData(getLocalPlayer(), "conta.Avatar", avatar + 1)
	            	end
	        	end
	    	end
		end
	end
)

function dxDrawRectangleBorde(left, top, width, height, color, postgui)
    if not postgui then
        postgui = false;
    end

    left, top = left + 2, top + 2;
    width, height = width - 4, height - 4;

    dxDrawRectangle(left - 2, top, 2, height, color, postgui);
    dxDrawRectangle(left + width, top, 2, height, color, postgui);
    dxDrawRectangle(left, top - 2, width, 2, color, postgui);
    dxDrawRectangle(left, top + height, width, 2, color, postgui);

    dxDrawRectangle(left - 1, top - 1, 1, 1, color, postgui);
    dxDrawRectangle(left + width, top - 1, 1, 1, color, postgui);
    dxDrawRectangle(left - 1, top + height, 1, 1, color, postgui);
    dxDrawRectangle(left + width, top + height, 1, 1, color, postgui);

    dxDrawRectangle(left, top, width, height, color, postgui);
end

function cursorPosition(x, y, width, height)
    if(not isCursorShowing()) then
        return false
    end
    local sx, sy = guiGetScreenSize()
    local cx, cy = getCursorPosition()
    local cx, cy =(cx*sx),(cy*sy)
    if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
        return true
    else
        return false
    end
end