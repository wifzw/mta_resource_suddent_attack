-- Türkçe Kaliteli Scriptin Adresi : https://sparrow-mta.blogspot.com
-- SparroW MTA İyi Oyunlar Diler...

addEvent("onRequestLogin",true)
addEventHandler("onRequestLogin",resourceRoot,
	function(username,password,checksave)
		if not (username == "") then
			if not (password == "") then
				local account = getAccount ( username, password )
				if ( account ~= false ) then
					logIn(client,account,password)
					triggerClientEvent (client,"onClientPlayerLogin",resourceRoot)
					if checksave and checksave == "1" then
						triggerClientEvent(client,"useLoginFile",resourceRoot,"set",username,password)
					else
						triggerClientEvent(client,"useLoginFile",resourceRoot,"remove",username,password)
					end
				else
					triggerClientEvent(client,"setNotification",resourceRoot,"Nome de usuário ou senha incorretos...")
				end
			else
				triggerClientEvent(client,"setNotification",resourceRoot,"Coloque sua senha...")
			end
		else
			triggerClientEvent(client,"setNotification",resourceRoot,"Entre com seu nome de usuário...")
		end
	end
)

addEvent("onRequestRegister",true)
addEventHandler("onRequestRegister",resourceRoot,
	function(username,password,repassword)
		if not (username == "") then
			if not (password == "") then
				if not (repassword == "") then
					if password == repassword then
						local account = getAccount (username)
						if (account == false) then
							local accountAdded = addAccount(tostring(username),tostring(password))
							if (accountAdded) then
								logIn(client,accountAdded,password)
								triggerClientEvent(client,"onClientPlayerLogin",resourceRoot)
								triggerClientEvent(client,"useLoginFile",resourceRoot,"set",username,password)
								outputChatBox("*Você se registrou com sucesso...! ( Usuário: #ee8a11" .. username .. " #FFFFFF| Senha: #ee8a11" .. password .. "#FFFFFF )",client,255,255,255,true)
							else
								triggerClientEvent(client,"setNotification",resourceRoot,"Digite um nome de usuário ou senha diferente...")
							end
						else
							triggerClientEvent(client,"setNotification",resourceRoot,"Esta conta já foi criada...!")
						end
					else
						triggerClientEvent(client,"setNotification",resourceRoot,"As senhas não coincidem...!")
					end
				else
					triggerClientEvent(client,"setNotification",resourceRoot,"Confirme sua senha...!")
				end
			else
				triggerClientEvent(client,"setNotification",resourceRoot,"Digite uma senha para sua nova conta...!")
			end
		else
			triggerClientEvent(client,"setNotification",resourceRoot,"Insira um nome de usuário para criar uma conta...!")
		end
	end
)

-- Türkçe Çeviri : SparroW MTA
-- https://sparrow-mta.blogspot.com