sx,sy = guiGetScreenSize()
x,y =  (sx/1366), (sy/768)

messages = {}
editBox = {}
editBox.__index = editBox
editBox.instances = {}

function onClientResourceStart()
	tick = getTickCount()
	font = dxCreateFont("gfx/sans-pro-regular.ttf", 20)
	sound = playSound("sfx/music.mp3",true)
	g = {}
	g.user = editBox.new()
	g.user:setPosition(x*610,y*320,x*213,y*41)
	g.user.color = {79,86,94,160}
	g.user.font = font
	g.user.text = loadLoginFromXML()
	g.user.visible = true
	g.user.onInput = function()
		g.user.color = {87, 95, 104, 160}
	end
	g.user.onOutput = function()
		g.user.color = {79,86,94,160}
	end
	
	g.pass = editBox.new()
	g.pass:setPosition(x*610,y*390,x*213,y*41)
	g.pass.color = {79,86,94,160}
	g.pass.font = font
	g.pass.masked = true
	g.pass.visible = true
	g.pass.onInput = function()
		g.pass.color = {87, 95, 104, 160}
	end
	g.pass.onOutput = function()
		g.pass.color = {79,86,94,160}
	end
	
	g.rUser = editBox.new()
	g.rUser:setPosition(x*610,y*320,x*213,y*41)
	g.rUser.color = {79,86,94,160}
	g.rUser.font = font
	g.rUser.onInput = function()
		g.rUser.color = {87, 95, 104, 160}
	end
	g.rUser.onOutput = function()
		g.rUser.color = {79,86,94,160}
	end
	
	g.rPass = editBox.new()
	g.rPass:setPosition(x*610,y*390,x*213,y*41)
	g.rPass.color = {79,86,94,160}
	g.rPass.font = font
	g.rPass.masked = true
	g.rPass.onInput = function()
		g.rPass.color = {87, 95, 104, 160}
	end
	g.rPass.onOutput = function()
		g.rPass.color = {79,86,94,160}
	end

	showChat(false)
	showCursor(true)
	addEventHandler("onClientRender", root, paint)
end
addEventHandler("onClientResourceStart",resourceRoot,onClientResourceStart)

function paint()
	local rh,ry = interpolateBetween(0, (y*559/2)+y*105, 0, y*559, y*105, 0, (getTickCount()-tick)/1400, "Linear")

	dxDrawImage(0,0,sx,sy,"gfx/wallpaper.png")
	if getTickCount()-tick > 1500 then
		local bColor = tocolor(45, 103, 154,200)
		if isMouseInPosition(x*552,y*450,x*262,y*44) then
			bColor = tocolor(45, 103, 154,200)
		end
		dxDrawImage(x*605,y*90,x*199,y*198,"gfx/logo.png",getTickCount()/100,0,0,tocolor(255,255,255,255))
		
		if not inRegisterTab then
			dxDrawRectangle(x*562,y*320,x*49,y*41,tocolor(40,45,48,160))
			dxDrawImage(x*570,y*325,x*33,y*31,"gfx/user.png")
			dxDrawRectangle(x*562,y*390,x*49,y*41,tocolor(40,45,48,160))
			dxDrawImage(x*575,y*395,x*23,y*31,"gfx/pass.png")
		
			dxDrawRectangle(x*561,y*450,x*262,y*44,bColor)
			dxDrawBorder(x*561,y*450,x*262,y*44,tocolor(0,0,0,240),1.4)
			dxDrawText("Iniciar Sessão",x*561,y*450,x*552+x*275,y*450+y*44,tocolor(255,255,255),y*0.75,font,"center","center")
		
			dxDrawText([[Deseja criar uma conta?
      Crie aqui #00ff82Register.]],x*600,y*420,x*588+x*192,y*592+y*43,tocolor(255,255,255),y*0.6,font,"center","center",false,false,false,true)
		end

		for k,self in pairs(editBox.instances) do
			if self.visible then
				local px,py,pw,ph = self:getPosition()
				local text = self.masked and string.gsub(self.text,".","•") or self.text
				local alignX = dxGetTextWidth(text,self.scale,self.font) <= pw and "left" or "right"
				dxDrawRectangle(px, py, pw, ph, tocolor(unpack(self.color)))
				dxDrawText(text,px+x*5, py,px-x*5+pw, py+ph,tocolor(unpack(self.textColor)),self.scale,self.font,alignX,"center",true)		
				if self.input and dxGetTextWidth(text,self.scale,self.font) <= pw then
					local lx = dxGetTextWidth(text,self.scale,self.font)+px+x*8
					local lx = dxGetTextWidth(text,self.scale,self.font)+px+x*8
					dxDrawLine(lx, py+y*10, lx, py+ph-y*10, tocolor(255,255,255,math.abs(math.sin(getTickCount()/300))*200), 2)
				end
			end
		end
		
	if not inRegisterTab then
		dxDrawBorder(x*561,y*320,x*262,y*41,tocolor(0,0,0,240),1)
		dxDrawBorder(x*561,y*390,x*262,y*41,tocolor(0,0,0,240),1)
	else
	
		dxDrawRectangle(x*561,y*320,x*49,y*41,tocolor(40,45,48,160))
		dxDrawImage(x*570,y*325,x*33,y*31,"gfx/user.png")
		dxDrawRectangle(x*561,y*390,x*49,y*41,tocolor(40,45,48,160))
		dxDrawImage(x*575,y*395,x*23,y*31,"gfx/pass.png")
		dxDrawBorder(x*561,y*320,x*262,y*41,tocolor(0,0,0,240),1)
		dxDrawBorder(x*561,y*390,x*262,y*41,tocolor(0,0,0,240),1)
		
		dxDrawRectangle(x*561,y*450,x*262,y*44,bColor)
		dxDrawBorder(x*561,y*450,x*262,y*44,tocolor(0,0,0,240),1.4)
		dxDrawText("Cadastre-se",x*561,y*450,x*552+x*262,y*450+y*44,tocolor(255,255,255),y*1,font,"center","center")
	end
	
	end
		
	if getKeyState("backspace") then
		for k,self in pairs(editBox.instances) do
			if self.visible and self.input then
				if not keyState then
					keyState = getTickCount() + 400
					self.text = string.sub(self.text,1,string.len(self.text)-1)
				elseif keyState and keyState < getTickCount() then
					keyState = getTickCount()+100
					self.text = string.sub(self.text,1,string.len(self.text)-1)
				end
				return
			end
		end
		keyState = nil
	end
	
	for i, v in pairs(messages) do
		if v.visible then
			dxDrawRectangle(sx-dxGetTextWidth(v.text, 1, "default-bold")-10, 35*i, dxGetTextWidth(v.text, 1, "default-bold")+50, 32,v.color)
			dxDrawBorder(sx-dxGetTextWidth(v.text, 1, "default-bold")-10, 35*i, dxGetTextWidth(v.text, 1, "default-bold")+20, 32,tocolor(255,255,255,200),1.6)
			dxDrawText(v.text,sx-dxGetTextWidth(v.text,1,"default-bold")-5, 9+35*i, dxGetTextWidth(v.text, 1, "default-bold"), 32, tocolor(255,255,255,255), 1, "default-bold", "left", "top", false, false ,false, true)
		end
	end
end

function onClientClick(button,state,cX,cY)
	if not isCursorShowing() then
		return
	end
	if button == "left" and state == "up" then
		for k,self in pairs(editBox.instances) do
			if self.visible then
				if self.input then
					self.input = nil
					self.onOutput()
				end
				local x,y,w,h = self:getPosition()
				if isMouseInPosition(x,y,w,h) then
					self.input = true
					self.onInput()
				end
			end
		end
		if not inRegisterTab then
			if isMouseInPosition(x*552,y*450,x*262,y*44) then
				triggerServerEvent("onRequestLogin",localPlayer,g.user.text,g.pass.text, true)
			elseif isMouseInPosition(x*700,y*520,x*44,y*22) then
				g.user.visible = false
				g.pass.visible = false
				
				inRegisterTab = true
				g.rUser.visible = true
				g.rPass.visible = true
			end
		else
			if isMouseInPosition(x*552,y*450,x*262,y*44) then
				triggerServerEvent("onRequestRegister",localPlayer,g.rUser.text,g.rPass.text)
			end
		end
	end
end
addEventHandler("onClientClick", root, onClientClick)

function onClientCharacter(character)
	if not isCursorShowing() then
		return
	end
	for k,self in pairs(editBox.instances) do
		if self.visible and self.input then
			if (string.len(self.text)) < self.maxLength then
				self.text = self.text..character
			end
		end
	end
end
addEventHandler("onClientCharacter", root, onClientCharacter)

function editBox.new()
	local self = setmetatable({}, editBox)
	self.text = ""
	self.maxLength = 20
	self.scale = y*0.8
	self.state = "normal"
	self.font = "sans"
	self.color = {255,255,255,220}
	self.textColor = {255,255,255,220}
	table.insert(editBox.instances, self)
	return self
end

function editBox:getPosition()
	return self.x, self.y, self.w, self.h
end

function editBox:setPosition(x,y,w,h)
	self.x, self.y, self.w, self.h = x,y,w,h
	return true
end

function dxDrawBorder(posX, posY,posW,posH,color,scale)
	dxDrawLine(posX, posY, posX+posW, posY, color, scale,false)
	dxDrawLine(posX, posY, posX, posY+posH, color, scale,false)
	dxDrawLine(posX, posY+posH, posX+posW, posY+posH, color, scale,false)
	dxDrawLine(posX+posW, posY, posX+posW, posY+posH, color, scale,false)
end

function isMouseInPosition(x,y,width,height)
    local cx, cy = getCursorPosition()
    local cx, cy = (cx*sx), (cy*sy)
    if (cx >= x and cx <= x + width) and (cy >= y and cy <= y + height) then
        return true
    else
        return false
    end
end

function onLogin()
	showChat(true)
	showCursor(false)
	stopSound(sound)
	removeEventHandler("onClientRender", root, paint)
	removeEventHandler("onClientClick",root,onClientClick)
	removeEventHandler("onClientCharacter",root,onClientCharacter)
end
addEvent("onLogin", true)
addEventHandler("onLogin", localPlayer, onLogin)

function onRegister()
	g.user.visible = true
	g.pass.visible = true
	g.user.text = ""
	g.pass.text = ""
		
	inRegisterTab = false
	g.rUser.visible = false
	g.rPass.visible = false
	g.rUser.text = ""
	g.rPass.text = ""
end
addEvent("onRegister", true)
addEventHandler("onRegister", localPlayer, onRegister)

function loadLoginFromXML()
	local XML = xmlLoadFile ("userdata.xml")
    if not XML then
        XML = xmlCreateFile("userdata.xml", "login")
    end
	
    local usernameNode = xmlFindChild (XML, "username", 0)
    if usernameNode then
        return xmlNodeGetValue(usernameNode)
    else
		return ""
    end
    xmlUnloadFile ( XML )
end

function saveLoginToXML(username)
    local XML = xmlLoadFile ("userdata.xml")
    if not XML then
        XML = xmlCreateFile("userdata.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (XML, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(XML, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
    xmlSaveFile(XML)
    xmlUnloadFile (XML)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", root, saveLoginToXML)


function login_text(result, text)
	if result == "sucess" then
	    addNotification(text,1)
	elseif result == "error" then
	    addNotification(text,2)
	end
end
addEvent("login_text",true)
addEventHandler("login_text",root,login_text)

function addNotification(text, type)
    text = string.gsub(text,"#%x%x%x%x%x%x","")
	local i = 0
	if text == "" or text == nil or not type then
		return
	else
		for i = 0, #messages+1 do
			if messages[i] then
				i = i+1
			else
				messages[i] = {}
				messages[i].text = text
				messages[i].visible = true
				if type == 1 then
					messages[i].color = tocolor(0,255,0,160)
				elseif type == 2 then
					messages[i].color = tocolor(255,0,0,160)
				end
				setTimer(removeNotify,5000,1,i)
			end
		end
	end
end

function removeNotify(i)
	messages[i].visible = false
	messages[i] = nil
end

function dxDrawBorder(posX, posY,posW,posH,color,scale)
	dxDrawLine(posX, posY, posX+posW, posY, color, scale,false)
	dxDrawLine(posX, posY, posX, posY+posH, color, scale,false)
	dxDrawLine(posX, posY+posH, posX+posW, posY+posH, color, scale,false)
	dxDrawLine(posX+posW, posY, posX+posW, posY+posH, color, scale,false)
end