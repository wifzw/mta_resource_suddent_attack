--- Türkçe Kaliteli Scriptin Adresi : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İyi Oyunlar...

--- EKRAN ORTALAMA KODU ---

sx,sy = guiGetScreenSize()
g,u = 330,25
px,py = sx/2-g/2 ,sy/2-u/2

local logoanimspeed = 0 
local bg, bu = sx, 25
local x,y = (sx - bg) / 41, (sy  - bu) / 1

-- DOSYALAR --
local benim_shaderim =  dxCreateShader("dosyalar/shaderler/texture3d.fx")
local benim_targetim =  dxCreateRenderTarget(sx,sy,true)
local yazi_tipi      =  dxCreateFont("dosyalar/fontlar/fonte2.ttf",15)
local fonte2      =  dxCreateFont("dosyalar/fontlar/yazi_tipi4.ttf",15)

--- tuş kapatma ---
butonlar = {
{"SistemKapatma", -- 
{["F1"] = true,["t"] = true,["u"] = true,["f2"] = true,["F8"] = true,["Console"] = true,["tab"] = true,["TAB"] = true}
},
}

esccjanims = { -- 
	"shift",
	"shldr",
	"stretch",
	"strleg",
	"time",
}

--// Tuş Engelleme //--

addEventHandler("onClientKey", root, function(buton, atak)  -- 
for i,v in pairs(butonlar) do 
local veri,tus = unpack(v) 
if tus[buton] and getElementData(localPlayer, veri) then 
cancelEvent() 
end
end
end)


-- script startlanınca olacak olylar --

panel_durum = "giris_ekrani"

anim_start = getTickCount();
anim_startG = getTickCount();
anim_startK = getTickCount();
anim_startKK = getTickCount();


setElementPosition(localPlayer,0,0,-5)	-- adamı yer altına göm ki kill kasmasın millet.
setElementFrozen(localPlayer,true)
setFarClipDistance(8000)


showChat(false)
showCursor(true)
--exports["TG-Hud"]:CustomHud(false)
showPlayerHudComponent("all",false) 
--setElementData(localPlayer,"ChatKapat",1)
setElementData(localPlayer,"SistemKapatma",true)

-- muzik eklemeye üşendim sen ayarlarsın gerisi sende
--local muzik = playSound("dosyalar/sesler/s.mp3",false) or playSFX("genrl", 75, math.random(0,7), true) -- 0 dan 7 kadar gtasa sesi..


--setElementInterior(localPlayer, math.random(120,255)) -- 

-- hesap --
addEventHandler("onClientResourceStart",root,function()
gui_element_olustur("giris_bolumu")
local username, password = loadLoginFromXML()
if username ~= "" or password ~= "" then
kaydet = true
guiSetText ( gui_olustur[1], tostring(username))
guiSetText ( gui_olustur[2], tostring(password))
end
end)


local animX = 0
local animState = "-"

local sembol1 = ""
local sembol2 = ""
local sembol3 = ""

local anim1 = 2
local anim2 = 2
local anim3 = 2

-- KARAKTER SEÇME OLAY --
local karakterler = {230, 300, 0, 20, 29, 120} -- karaktelrini yaz

local max_karakter = #karakterler

 basilimi1 = tocolor(255,255,255,255)
 basilimi2 = tocolor(255,255,255,255)

function karakter_ilerle ( sda )
    sda = sda + 1
    if sda > max_karakter then sda = 1 end

    return sda
end


function karakter_gerile ( sda )
    sda = sda - 1
    if sda < 1 then sda = max_karakter end

    return sda
end


local zert = 1
function yeni_karakter_ilerle ( )
    zert = karakter_ilerle(zert)
	soundeffect()
	setPedAnimation ( ped , "PLAYIDLES",esccjanims[math.random(#esccjanims)], -1, true, false, false, false )
    setElementModel( ped, karakterler[zert] )
	 basilimi2 = tocolor(22, 81, 140,255)
	 basilimi1 = tocolor(255, 255, 255,255)
end

function yeni_karakter_gerile ( )
    zert = karakter_gerile(zert)
	soundeffect()
	setPedAnimation ( ped , "PLAYIDLES",esccjanims[math.random(#esccjanims)], -1, true, false, false, false )
    setElementModel( ped, karakterler[zert] )
	 basilimi1 = tocolor(22, 81, 140,255)
	 basilimi2 = tocolor(255, 255, 255,255)
end


--// EDİTBOXLAR /--

gui_olustur = {}


function gui_element_olustur(type)
	if tostring(type) == "sil" then
		for i = 1, 6 do
			if isElement(gui_olustur[i]) then
				destroyElement(gui_olustur[i])
			end
		end
		
	elseif tostring(type) == "giris_bolumu" then
		local username, password = loadLoginFromXML()
		gui_olustur[1] = guiCreateEdit(-1000, -1000, 0, 0,tostring(username) or "", false)
		guiEditSetMaxLength(gui_olustur[1], 22)		
	
		gui_olustur[2] = guiCreateEdit(-1000, -1000, 0, 0,tostring(password) or "", false)
		guiEditSetMaxLength(gui_olustur[2], 22)
	
	elseif tostring(type) == "kayit_bolumu" then
		gui_olustur[1] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(gui_olustur[1], 22)		
		gui_olustur[2] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(gui_olustur[2], 22)		
		gui_olustur[3] = guiCreateEdit(-1000, -1000, 0, 0, "", false)
		guiEditSetMaxLength(gui_olustur[3], 22)		
	end
end



-- tasarim --
function gizli_karakter_donustur(sifre)
    local uzunluk = utfLen(sifre)

    if uzunluk > 23 then
        uzunluk = 23
    end
    return string.rep("•", uzunluk)
end


local texture = dxCreateTexture("dosyalar/resimler/mask.png","dxt5")
local texture2 = dxCreateTexture("dosyalar/resimler/mask2.png","dxt5")

function mask()
	dxDrawImage(0,0,sx,sy,texture2,0,0,0,tocolor(0,0,0,200))
	dxDrawImage(0,0,sx,sy,texture,0,0,0,tocolor(0,0,0,110))
end
setElementData(localPlayer,"Zaman",0)
function log_tasarim()
	if panel_durum == "giris_ekrani" then
		suanki = getTickCount()
		local acilis_anim1 = interpolateBetween(0, 0, 0,  py, 0, 0, (suanki - anim_start) / ((anim_start + 1000) - anim_start), "InBack")
		local acilis_anim4 = interpolateBetween(0, 0, 0,  x, 0, 0, (suanki - anim_start) / ((anim_start + 1200) - anim_start), "InBack")
		local acilis_anim3 = interpolateBetween(0, 0, 0,  bg, 0, 0, (suanki - anim_start) / ((anim_start + 1200) - anim_start), "InBack")

		mask()

		button_olustur(" Sunucuya Giriş Yap",px,acilis_anim1,g,u,32, 63, 104,fonte2)
		button_olustur(" Kayıt Ol",px,acilis_anim1+30,330,u,160, 163, 104,fonte2)
		alt_tablo("www.sparrow-mta.blogspot.com - İyi Oyunlar.",acilis_anim4,y,acilis_anim3,bu,tocolor(0,0,0,180)) -- alt yazı
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
	ax, ay = sx/2, sy/2 - 340/2 - 30
	
	local acilis_anim2 = interpolateBetween(0, 0, 0,  ay - 15-animX/2, 0, 0, (suanki - anim_start) / ((anim_start + 1250) - anim_start), "InBack")
    dxDrawImage(ax - (453/1.5)/2-animX/2,acilis_anim2, 453/1.5+animX, 301/1.5+animX, "dosyalar/resimler/logo.png",0,0,0,tocolor(255,255,255,200))
	
	elseif panel_durum == "giris_bolumu" then
	suanki2 = getTickCount()
	local acilis_anim5 = interpolateBetween(0, 0, 0,  px, 0, 0, (suanki2 - anim_startG) / ((anim_startG + 1250) - anim_startG), "OutBounce")
	local acilis_anim6 = interpolateBetween(0, 0, 0,  sy, 0, 0, (suanki2 - anim_startG) / ((anim_startG + 1200) - anim_startG), "Linear")
	
	-- arka plan
	mask()
		
	-- kullanıcı adı box
	local sembol1 = ""
	if editbox == "edit1" then
	anim1 = anim1 + 1
	if(anim1<40)then
	sembol1 = "|"
	end
	if(anim1>80)then
	anim1 = 0
	end
	end
	
	editbox_olustur(guiGetText(gui_olustur[1])..sembol1,acilis_anim5,py+50,g,u,tocolor(22, 81, 140,255),"Kullanıcı Adı: "..guiGetText(gui_olustur[1]),"")
	
	-- şifre box
	local sembol2 = ""
	if editbox == "edit2" then
	anim2 = anim2 + 1
	if(anim2<40)then
	sembol2 = "|"
	end
	if(anim2>80)then
	anim2 = 0
	end
	end
	
	editbox_olustur(gizli_karakter_donustur(guiGetText(gui_olustur[2]))..sembol2,acilis_anim5,py+105,g,u,tocolor(22, 81, 140,255),"Şifre: "..guiGetText(gui_olustur[2]),"")
	
	-- HESABIMI KAYDET
	checkbox_olustur("Hesabımı Kaydet",acilis_anim5,py+135,20)
	
	if kaydet then
	dxDrawRectangle(acilis_anim5+5,py+140,10,10,tocolor(22, 81, 140,255))
	end
	
	button_olustur(" Sunucuya Giriş Yap",acilis_anim5,py+160,g,u,244, 66, 101,fonte2)
	button_olustur(" Geri Dön",acilis_anim5,py+190,g,u,116, 22, 142,fonte2)
	
	-- alt tablo
	local acilis_anim7 = interpolateBetween(0, 0, 0,  x, 0, 0, (suanki2 - anim_startG) / ((anim_startG + 1200) - anim_startG), "InBack")
	local acilis_anim8 = interpolateBetween(0, 0, 0,  bg, 0, 0, (suanki2 - anim_startG) / ((anim_startG + 1200) - anim_startG), "InBack")
	
	alt_tablo("www.sparrow-mta.blogspot.com - İyi Oyunlar.",acilis_anim7,y,acilis_anim8,bu,tocolor(0,0,0,180))
	
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
	ax, ay = sx/2, sy/2 - 340/2 - 30
	
	local acilis_anim7 = interpolateBetween(0, 0, 0,  ay - 15-animX/2, 0, 0, (suanki2 - anim_startG) / ((anim_startG + 1250) - anim_startG), "InBack")
    dxDrawImage(ax - (453/1.5)/2-animX/2,acilis_anim7, 453/1.5+animX, 301/1.5+animX, "dosyalar/resimler/logo.png",0,0,0,tocolor(255,255,255,math.abs(math.sin(getTickCount()/998))*255))
	
	elseif panel_durum == "kayit_bolumu" then
	
	suanki4 = getTickCount()
	
	local acilis_anim10 = interpolateBetween(0, 0, 0,  px, 0, 0, (suanki4 - anim_startKK) / ((anim_startKK + 1250) - anim_startKK), "OutBounce")
	local acilis_anim11 = interpolateBetween(0, 0, 0,  sy, 0, 0, (suanki4 - anim_startKK) / ((anim_startKK + 1200) - anim_startKK), "Linear")
	
	-- arka plan
	mask()
	
	-- kullanıcı editbox
	local sembol1 = ""
	if editbox == "edit3" then
	anim1 = anim1 + 1
	if(anim1<40)then
	sembol1 = "|"
	end
	if(anim1>80)then
	anim1 = 0
	end
	end
	
	editbox_olustur(guiGetText(gui_olustur[1])..sembol1,acilis_anim10,py+15,g,u,tocolor(22, 81, 140,255),"Kullanıcı Adı: "..guiGetText(gui_olustur[1]),"")
	
	-- şifre box2
	local sembol2 = ""
	if editbox == "edit4" then
	anim2 = anim2 + 1
	if(anim2<40)then
	sembol2 = "|"
	end
	if(anim2>80)then
	anim2 = 0
	end
	end
	
	editbox_olustur(gizli_karakter_donustur(guiGetText(gui_olustur[2]))..sembol2,acilis_anim10,py+70,g,u,tocolor(22, 81, 140,255),"Şifre: "..gizli_karakter_donustur(guiGetText(gui_olustur[2])),"")
	
	-- tekrar şifre box2
	local sembol3 = ""
	if editbox == "edit5" then
	anim3 = anim3 + 1
	if(anim2<40)then
	sembol3 = "|"
	end
	if(anim3>80)then
	anim3 = 0
	end
	end
	
	editbox_olustur(gizli_karakter_donustur(guiGetText(gui_olustur[3]))..sembol3,acilis_anim10,py+122,g,u,tocolor(22, 81, 140,255),"Tekrar Şifre: "..gizli_karakter_donustur(guiGetText(gui_olustur[3])),"")
	
	-- buttonlar
	button_olustur(" Sunucuya Kayıt Ol",acilis_anim10,py+155,g,u,150, 127, 12,fonte2)
	button_olustur(" Geri Dön",acilis_anim10,py+185,g,u,150, 32, 11,fonte2)
	
	-- alt tablo
	local c = interpolateBetween(0, 0, 0,  x, 0, 0, (suanki4 - anim_startKK) / ((anim_startKK + 1200) - anim_startKK), "InBack")
	local d = interpolateBetween(0, 0, 0,  bg, 0, 0, (suanki4 - anim_startKK) / ((anim_startKK + 1200) - anim_startKK), "InBack")
	
	alt_tablo("www.sparrow-mta.blogspot.com - İyi Oyunlar.",c,y,d,bu,tocolor(0,0,0,180))
	
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
	ax, ay = sx/2, sy/2 - 340/2 - 30
	
	local acilis_anim12 = interpolateBetween(0, 0, 0,  ay - 15-animX/2, 0, 0, (suanki4 - anim_startKK) / ((anim_startKK + 1250) - anim_startKK), "InBack")
    dxDrawImage(ax - (453/1.5)/2-animX/2,acilis_anim12, 453/1.5+animX, 301/1.5+animX, "dosyalar/resimler/logo.png",0,0,0,tocolor(255,255,255,math.abs(math.sin(getTickCount()/998))*255))
	
	
	elseif panel_durum == "karakter_olusturma" then
	suanki3 = getTickCount()

	local acilis_anim9 = interpolateBetween(0, 0, 0,  px, 0, 0, (suanki3 - anim_startK) / ((anim_startK + 1200) - anim_startK), "InBack")

	local x, y, z = getElementPosition (localPlayer)
	local konum = getZoneName ( x, y, z )
	local sehir = getZoneName ( x, y, z, true )
	
	local bg1, bu1 = sx, 25
	local x1,y1 = (sx - bg) / 41, (sy  - bu) / 1
	
	local a = interpolateBetween(0, 0, 0,  x1, 0, 0, (suanki3 - anim_startK) / ((anim_startK + 1200) - anim_startK), "InBack")
	local b = interpolateBetween(0, 0, 0,  bg1, 0, 0, (suanki3 - anim_startK) / ((anim_startK + 1200) - anim_startK), "InBack")
	
	alt_tablo("Karakter seçmek için sağ ve sol ok tuşlarını kullanınız.",a,y1,b,bu1,tocolor(0,0,0,180))
	panel_olustur(" Hoş Geldiniz.",acilis_anim9-380/1.4,py-70,310,170,tocolor(22, 81, 140,2550)," Merhaba: #0066ff"..getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "")..""," "..getElementData(localPlayer,"Zaman")," "..sehir.."",basilimi1,basilimi2)
	button_olustur(" Haydi Başla",acilis_anim9-380/1.4,py+70,310,u,41, 35, 155,fonte2)
	end
end
addEventHandler("onClientRender",root,log_tasarim)

--// EKRAN AYARLARI //--
local ekran_konumlari1 = {guiGetScreenSize()}
local logo_buyukluk1 = {53, 51}
local resim_konumlari1 = {ekran_konumlari1[1]/2 - logo_buyukluk1[1]/2,ekran_konumlari1[2]/2 - logo_buyukluk1[2]/2}
local dondur = 0

local anim_start_s = getTickCount()
local yazi_tipi   = dxCreateFont("dosyalar/fontlar/yazi_tipi1.otf",15) 

--// TASARİM //--
local bolgeler = { 
--{ x , y , z }
{ 0 , 0 , 0 } , -- /getpos { x , y , z }
{ 1 , 1 , 1 } , 

} 

addEventHandler("onClientRender",root,function()
	if yukleme_durum == true then
	suanki = getTickCount();
	acilis_anim_load1 = interpolateBetween(0, 0, 0, ekran_konumlari1[2], 0, 0, (suanki - anim_start_s) / ((anim_start_s + 2000) - anim_start_s), "Linear")
	acilis_anim_load2 = interpolateBetween(0, 0, 0, resim_konumlari1[2], 0, 0, (suanki - anim_start_s) / ((anim_start_s + 2000) - anim_start_s), "Linear")
	
	dondur = dondur + 2 > 360 and 0 or dondur + 2
	
	dxDrawRectangle(0,0,ekran_konumlari1[1],acilis_anim_load1,tocolor(0,0,0,120));

	dxDrawImage(resim_konumlari1[1]-110,acilis_anim_load2,logo_buyukluk1[1],logo_buyukluk1[2], "dosyalar/resimler/yukleniyor.png", dondur, 0, 0, tocolor(22, 81, 140,255), false)
	dxDrawText("Oyuncu verileriniz, yüklenirken lütfen bekleyiniz!",resim_konumlari1[1]-50,acilis_anim_load2+15,120,25,tocolor(255,255,255,math.abs(math.sin(getTickCount()/998))*255),0.8,yazi_tipi)
	end
end)


-- olaylar --
function tiklama_olay(button,state)
	if button == "left" and state == "down" then
			--* sunucu giriş yap *--
			if isInSlot(px,py,g,u) and panel_durum == "giris_ekrani" then 
			panel_durum  = "giris_bolumu"
			anim_startG = getTickCount();
			gui_element_olustur("giris_bolumu")
			soundbutton()
			return end
			
			--* sunucuya kayıt ol *--
			if isInSlot(px,py+30,350,u) and panel_durum == "giris_ekrani" then 
			panel_durum  = "kayit_bolumu"
			anim_startKK = getTickCount();
			gui_element_olustur("kayit_bolumu")
			soundbutton()
			return end
			
			--* geri dön *--
			if isInSlot(px,py+190,g,u) and panel_durum == "giris_bolumu" then 
			panel_durum  = "giris_ekrani"
			anim_start = getTickCount();
			gui_element_olustur("sil")
			sembol1 = ""
			sembol2 = ""
			anim1 = 0
			anim2 = 0
			soundbutton()
			return end
			
			--* editboxlar *--
			if isInSlot(px,py+50,g,u) and panel_durum == "giris_bolumu" then 
			if guiEditSetCaretIndex(gui_olustur[1], string.len(guiGetText(gui_olustur[1]))) then
			editbox = "edit1"
			anim1 = 1
			guiBringToFront(gui_olustur[1])
			soundbutton()
			end
			return end
			
			if isInSlot(px,py+105,g,u) and panel_durum == "giris_bolumu" then 
			if guiEditSetCaretIndex(gui_olustur[2], string.len(guiGetText(gui_olustur[2]))) then
			editbox = "edit2"
			anim2 = 1
			guiBringToFront(gui_olustur[2])
			soundbutton()
			end
			return end
			
			if isInSlot(px,py+15,g,u) and panel_durum == "kayit_bolumu" then 
			if guiEditSetCaretIndex(gui_olustur[1], string.len(guiGetText(gui_olustur[1]))) then
			editbox = "edit3"
			anim1 = 1
			guiBringToFront(gui_olustur[1])
			soundbutton()
			end
			return end
			
			if isInSlot(px,py+70,g,u) and panel_durum == "kayit_bolumu" then 
			if guiEditSetCaretIndex(gui_olustur[2], string.len(guiGetText(gui_olustur[2]))) then
			editbox = "edit4"
			anim2 = 1
			guiBringToFront(gui_olustur[2])
			soundbutton()
			end
			return end
			
			if isInSlot(px,py+122,g,u) and panel_durum == "kayit_bolumu" then 
			if guiEditSetCaretIndex(gui_olustur[3], string.len(guiGetText(gui_olustur[3]))) then
			editbox = "edit5"
			anim3 = 1
			guiBringToFront(gui_olustur[3])
			soundbutton()
			end
			return end
			
			--* hesabımı  kaydet *--
			if isInSlot(px,py+135,20,20) and panel_durum == "giris_bolumu" then 
			kaydet = not kaydet
			soundbutton()
			return end
			
			--* kayıt bölümü geri dön *--
			if isInSlot(px,py+185,g,u) and panel_durum == "kayit_bolumu" then 
			panel_durum  = "giris_ekrani"
			anim_start = getTickCount();
			gui_element_olustur("sil")
			sembol1 = ""
			sembol2 = ""
			anim1 = 2
			anim2 = 2
			anim3 = 2
			soundbutton()
			return end
			
			--* giris yap button *--
			if isInSlot(px,py+160,g,u) and panel_durum == "giris_bolumu" then 
			local user  = guiGetText(gui_olustur[1])
			local pas  = guiGetText(gui_olustur[2])
		
			if kaydet then
			hesap_kaydet = true
			else
			hesap_kaydet = false
			end
			soundbutton()
			triggerServerEvent("LoginPanel:Giris",localPlayer,user,pas,hesap_kaydet)
		
			return end
			
			--* kayıt ol button *--
			if isInSlot(px,py+155,g,u) and panel_durum == "kayit_bolumu" then 
			user2 = guiGetText(gui_olustur[1])
			pas2  = guiGetText(gui_olustur[2])
			pasc = guiGetText(gui_olustur[3])
		
		
			triggerServerEvent("LoginPanel:Kayıt",localPlayer,user2,pas2,pasc)
			soundbutton()
			return end
			--* oyna *--
			if isInSlot(px-380/2,py+70,310,u) and panel_durum == "karakter_olusturma" then 
			setFarClipDistance(750)
			stopSound(muzik)
			soundbutton()
			yukleme_durum = true
			anim_start_s = getTickCount();
			destroyElement(ped)
			setElementDimension(localPlayer, 0)
			setCameraMatrix(1353.158203125,-1173.5380859375,173.88003540039,1289.9091796875,-1237.69921875,130.48803710938)
			showCursor(false)
		
			unbindKey( "arrow_l", "up", yeni_karakter_ilerle )
			unbindKey( "arrow_r", "up", yeni_karakter_gerile)
			panel_durum = "nil"
		
			setTimer(function()
			yukleme_durum = false
			setElementModel(localPlayer,karakterler[zert] )

		--	setElementAlpha(localPlayer,255) 
			setCameraTarget(localPlayer)
			setElementFrozen(localPlayer,false)
		
			bolges = bolgeler[math.random(#bolgeler)] 
			setElementPosition(localPlayer,unpack(bolges))	
			
			--exports["TG-Hud"]:CustomHud(true)
			showPlayerHudComponent("radar",true) 
			--setElementData(localPlayer,"ChatKapat",0)
			showChat(true)
			setElementData(localPlayer,"SistemKapatma",false)
			
			end,8000,1)
		
			
			return end
		end
	end
addEventHandler("onClientClick",root,tiklama_olay)

addEvent("LoginPanel:Hide",true)
addEventHandler("LoginPanel:Hide",root,function()

		    panel_durum  = "karakter_olusturma"
			gui_element_olustur("sil")
			anim_startK = getTickCount();
			
			removeEventHandler("onClientRender",root,updateCamPosition)
			setCameraTarget(localPlayer)
			
			setCameraMatrix(1413.9775390625,-1475.0341796875,70.367042541504,1322.3408203125,-1437.2001953125,57.279769897461)
			
			ped = createPed(0,1410.81995, -1472.68347, 69.97146,210) --  64 id ped cokmu aradın.
			
			setPedAnimation ( ped , "PLAYIDLES", esccjanims[math.random(#esccjanims)], -1, true, false, false, false )
			setElementFrozen (ped, true )
			setElementDimension(ped, 20)
			setElementDimension(localPlayer, 20)
--			setElementRotation(ped,0,0,155) -- buna ne gerek var ?? createPed(x,y,z,rot) anladın, sen.
			
			bindKey( "arrow_l", "up", yeni_karakter_ilerle )
			bindKey( "arrow_r", "up", yeni_karakter_gerile)
end)

addEvent("olay",true)
addEventHandler("olay",root,function()

panel_durum = "giris_ekrani"

anim_start = getTickCount();
anim_startG = getTickCount();
anim_startK = getTickCount();
anim_startKK = getTickCount();



showChat(false)
showCursor(true)
exports["TG-Hud"]:CustomHud(false)
showPlayerHudComponent("all",false) 
setElementData(localPlayer,"ChatKapat",1)
setElementData(localPlayer,"SistemKapatma",true)

gui_element_olustur("giris_bolumu")
local username, password = loadLoginFromXML()
if username ~= "" or password ~= "" then
kaydet = true
guiSetText ( gui_olustur[1], tostring(username))
guiSetText ( gui_olustur[2], tostring(password))
end
end)
-- taslak --

function checkbox_olustur(yazi,x,y,w)
	if isInSlot(x, y, w, 20) then 
	dxDrawRectangle(x, y, w, 20,tocolor(94, 94, 94,160));
	dxDrawRecLine(x,y,20,w,tocolor(22, 81, 140,255))
	dxDrawText(yazi,x+23,y+1,w+x,20+y,tocolor(255,255,255,180),0.8,yazi_tipi,"left","center",false,false,false,true)
	else
	dxDrawRectangle(x, y, w, 20,tocolor(94, 94, 94,200));
	dxDrawText(yazi,x+23,y+1,w+x,20+y,tocolor(255,255,255,255),0.8,yazi_tipi,"left","center",false,false,false,true)
	end
end


function yazi_olustur(yazi,x,y,w,h,renk)
	dxDrawText(yazi,x+23,y+1,20+x,20+y,renk,0.8,fonte2,"left","center",false,false,false,true)
end


function panel_olustur(yazi,x,y,w,h,renk,bilesen1,bilesen2,bilesen3,renk_y1,renk_y2)
	dxDrawRectangle(x, y, w, h,tocolor(0, 0, 0,160));
	dxDrawRectangle(x, y, w, 25,tocolor(0, 0, 0,180));
	dxDrawRectangle(x, y+25, w, 1,renk);
	dxDrawText(yazi,x-1,y-1,w+x,25+y,tocolor(255,255,255,255),0.7,fonte2,"center","center");
	-- bileşkenler
	dxDrawText(bilesen1,x+5,y+50,w,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true);
	dxDrawText(bilesen2,x+5,y+100,w,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true);
	dxDrawText(bilesen3,x+5,y+150,w,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true);
--	dxDrawText(bilesen4,x+5,y+210,w,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true);
	
	dxDrawText("",x+260,y+220,w,25+y,renk_y1,0.7,fonte2,"left","center",false,false,false,true); --fixed byshep
	dxDrawText("",x+30,y+220,w,25+y,renk_y2,0.7,fonte2,"left","center",false,false,false,true);
	dxDrawText(" "..getElementModel(ped),x+140,y+220,w,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true);
end

function editbox_olustur(yazi,x,y,w,h,renk,ust,icon)
	if isInSlot(x, y, w, h) then 
	dxDrawRectangle(x, y, w, h,tocolor(94, 94, 94,160));
	dxDrawRecLine(x,y,w,h,renk)
	dxDrawText(yazi,x+25,y-2,w+x,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true)
	dxDrawText(ust,x,y-55,w+x,25+y,tocolor(255,255,255,190),0.7,fonte2,"center","center",false,false,false,true)
	dxDrawText(icon,x+5,y-2,w+x,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true)
	else
	dxDrawRectangle(x, y, w, h,tocolor(94, 94, 94,200));
	dxDrawText(yazi,x+25,y-2,w+x,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true)
	dxDrawText(ust,x,y-55,w+x,25+y,tocolor(255,255,255,255),0.7,fonte2,"center","center",false,false,false,true)
	dxDrawText(icon,x+5,y-2,w+x,25+y,tocolor(255,255,255,255),0.7,fonte2,"left","center",false,false,false,true)
	end
end
	
function button_olustur(yazi,x,y,w,h,r,g,b,font)

	if isInSlot(x, y, w, h) then 
	dxDrawRectangle(x, y, w, h,tocolor(30,30,31,120));
	dxDrawRecLine(x,y,w,h,tocolor(30,30,31,255))
	
	dxDrawText(yazi,x-1,y-1,w+x,25+y,tocolor(0,0,0,255),0.7,font,"center","center")
	dxDrawText(yazi,x,y,w+x,25+y,tocolor(255,255,255,255),0.7,font,"center","center")
	
	else
	
	dxDrawRectangle(x, y, w, h,tocolor(30,30,31,255));
	dxDrawRecLine(x,y,w,h,tocolor(0,102,255,255))
	
	dxDrawText(yazi,x-1,y-1,w+x,25+y,tocolor(0,0,0,255),0.7,font,"center","center")
	dxDrawText(yazi,x,y,w+x,25+y,tocolor(255,255,255,255),0.7,font,"center","center")
	
	end
end

function dxDrawRecLine(x,y,w,h,color)
    dxDrawRectangle(x,y,w,1,color) -- h
	dxDrawRectangle(x,y+h,w,1,color) -- h
	dxDrawRectangle(x,y,1,h,color) -- v
	dxDrawRectangle(x+w-1,y,1,h,color) -- v
end

function alt_tablo(yazi,x,y,w,h,renk)
	dxDrawRectangle(x,y,w,h,renk)
	dxDrawText(yazi,x,y,w+x,25+y,tocolor(255,255,255,math.abs(math.sin(getTickCount()/998))*255),0.7,yazi_tipi,"center","center",false,false,false,true)
end


function inBox(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end

function isInSlot(xS,yS,wS,hS)
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(inBox(xS,yS,wS,hS, cursorX, cursorY)) then
			return true
		else
			return false
		end
	end	
end

-- hesap kaydetme --

function loadLoginFromXML()
	local xml_save_log_File = xmlLoadFile("dosyalar/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("dosyalar/userdata.xml", "login")
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
	local xml_save_log_File = xmlLoadFile("dosyalar/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("dosyalar/userdata.xml", "login")
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
	local xml_save_log_File = xmlLoadFile("dosyalar/userdata.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("dosyalar/userdata.xml", "login")
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

-- kamera anim --
local camX,camY,camZ,camX2,camY2,camZ2 = -1292.03333, 679.29205, 198.11470,2059.5166015625,1278.7858886719,29.821063995361


local lastCamTick = 0
local camDist = getDistanceBetweenPoints3D (camX,camY,camZ,camX2,camY2,camZ)
local currentCamAngle = 270
local lastClick = 0

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end

function soundeffect()
playSFX("script", 205, 0, false)
end

function soundbutton()
playSFX("script", 192, 5, false)
end

function updateCamPosition ()
	local newCamTick = getTickCount ()
	local delay = newCamTick - lastCamTick
	lastCamTick = newCamTick
	local angleChange = delay/300
	currentCamAngle = currentCamAngle + angleChange
	local newX,newY = getPointFromDistanceRotation (camX,camY,camDist,currentCamAngle)
	setCameraMatrix (camX,camY,camZ,newX,newY,camZ2)
end
addEventHandler("onClientRender", getRootElement(), updateCamPosition)