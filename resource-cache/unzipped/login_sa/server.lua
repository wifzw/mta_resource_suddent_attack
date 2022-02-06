--- Türkçe Kaliteli Scriptin Adresi : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İyi Oyunlar...


function login(username, password, hesap_kaydet)
if not hasObjectPermissionTo(getThisResource(), "function.addAccount", true) then
		exports["infobox"]:addNotification(source, "ACL'den admin yetkisi verin.\nAdmin yetkisi verdiğiniz halde çalışmıyorsa, tüm yetkileri verin.","hatali")
		return
	end
	for k,v in ipairs(getElementsByType ( "player" )) do
					local hesabal = getPlayerAccount(v) 
					local isminial = getAccountName(hesabal)
					if  (username == tostring(isminial)) then
						exports["infobox"]:addNotification(source, "Bu hesaptaki oyunda.", "dikkat")
						return
					end
				end
	if not (username == "") then
		if not (password == "") then
			local account = getAccount(username, password)
			if (account ~= false) then
				logIn(source, account, password) 
			--	setElementData(source, "loggedin", true)
				triggerClientEvent(source, "LoginPanel:Hide", getRootElement())
				exports["infobox"]:addNotification(source, "Başarılı bir şekilde giriş yaptınız, iyi oyunlar.", "basarili")
				if hesap_kaydet == true then
					triggerClientEvent(source, "saveLoginToXML", getRootElement(), username, password)
				else
					triggerClientEvent(source, "resetSaveXML", getRootElement(), username, password)
				end
			else
				exports["infobox"]:addNotification(source, "Kullanıcı adınız veya şifreniz hatalı.", "dikkat")
			end
		else
			exports["infobox"]:addNotification(source, "Lütfen şifrenizi girin.", "dikkat")
		end
	else
		exports["infobox"]:addNotification(source, "Lütfen kullanıcı adınızı girin.", "dikkat")
	end
end
addEvent("LoginPanel:Giris", true)
addEventHandler("LoginPanel:Giris", root, login)

function uyeol(user2, pas2, pasc) --yapıcam bu logini kfaa taktım
	if not hasObjectPermissionTo(getThisResource(), "function.addAccount", true) then
		--triggerClientEvent(source, "setInfoText", source, 9)
		exports["infobox"]:addNotification(source, "ACL'den admin yetkisi verin.\nAdmin yetkisi verdiğiniz halde çalışmıyorsa, tüm yetkileri verin.","hatali")
		return 
	end
	if getAccount(user2) then
				exports["infobox"]:addNotification(source, "Bu hesap kullanılmaktadır.", "dikkat")
			return
		end
        if not (user2 == "") then 
                if not (pas2 == "") then
                        if not (pasc == "") then
                                if not (pas2 == pasc)then exports["infobox"]:addNotification(source,"Şifreler uyuşmuyor!","dikkat") return end
                                local hesap = getAccount (user2,pas2)
                                if (hesap == false) then
                                    local hesapekleme = addAccount(tostring(user2),tostring(pas2))
								exports["infobox"]:addNotification(source, "Başarılı bir şekilde yeni hesabınız oluşturuldu, şimdi giriş yapın.", "basarili")
                                    if (hesapekleme) then
                                        local hesap = getAccount ( user2, pas2 )
										
                                        exports["infobox"]:addNotification(source,"Başarılı bir şekilde kayıt oldunuz, şimdi giriş yapın.","basarili")
										--triggerClientEvent(source,"LoginPanel:HesapKaydetme",source,user2,pas2)
                                    end
                                                                end
                        else
                                exports["infobox"]:addNotification(source,"Lütfen şifrenizi girin!","dikkat")
                        end
                else
                        exports["infobox"]:addNotification(source,"Lütfen şifrenizi giriné","dikkat")
                end
        else
                exports["infobox"]:addNotification(source,"Lütfen kullanıcı adınızı girin!","dikkat")
        end
end
addEvent("LoginPanel:Kayıt", true)
addEventHandler("LoginPanel:Kayıt", root, uyeol)


-- girdi --
addEventHandler("onPlayerJoin",root,function()
triggerClientEvent(source,"olay",root)
end)