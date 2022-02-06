function login(username, password, account_save)
    if not hasObjectPermissionTo(getThisResource(), "function.addAccount", true) then
        exports._infobox:addNotification(source, "Conceder privilégio de administrador da ACL.\nSe o administrador não funcionar mesmo que você o tenha concedido, conceda todos os privilégios")
        return
    end
    for k, v in ipairs(getElementsByType("player")) do
        local account_player = getPlayerAccount(v)
        local account_name = getAccountName(account_player)
        if (username == tostring(account_name)) then
            exports._infobox:addNotification(source, "No jogo nesta conta.", "warning")
            return
        end
    end
    if not (username == "") then
        if not (password == "") then
            local account = getAccount(username, password)
            if (account ~= false) then
                logIn(source, account, password)
                triggerClientEvent(source, "LoginPanel:Hide", getRootElement())
                exports._infobox:addNotification(source, "Você se logou com sucesso, bom jogo.", "success")
                if account_save == true then
                    triggerClientEvent(source, "saveLoginToXML", getRootElement(), username, password)
                else
                    triggerClientEvent(source, "resetSaveXML", getRootElement(), username, password)
                end
            else
                exports._infobox:addNotification(source, "Seu nome de usuário ou senha está incorreto.", "error")
            end
        else
            exports._infobox:addNotification(source, "Por favor, insira sua senha.", "error")
        end
    else
        exports._infobox:addNotification(source, "Por favor insira seu nome de usuário", "error")
    end
end
addEvent("Panel:Login", true)
addEventHandler("Panel:Login", root, login)

function register(user2, pas2, pasc)
    if not hasObjectPermissionTo(getThisResource(), "function.addAccount", true) then
        exports._infobox:addNotification(source, "Conceder privilégio de administrador da ACL.\nSe não estiver funcionando, mesmo que você tenha concedido autoridade de administrador, conceda todos os privilégios.", "error")
        return
    end
    if getAccount(user2) then
        exports._infobox:addNotification(source, "Essa conta já existe!", "error")
        return
    end
    if not (user2 == "") then

        if not (pas2 == "") then

            if not (pasc == "") then
                if not (pas2 == pasc) then
                    exports._infobox:addNotification(source, "As senhas não coincidem!", "error")
                    return
                end
                local addConta = getAccount(user2, pas2)
                if (addConta == false) then
                    local addConta = addAccount(tostring(user2), tostring(pas2))
                    exports._infobox:addNotification(source, "Sua nova conta foi criada com sucesso, faça login agora.", "success")

                    if (addConta) then
                        local addConta = getAccount(user2, pas2)
                        exports._infobox:addNotification(source, "Você se registrou com sucesso, faça o login agora.", "success")

                    end
                end
            else
                exports._infobox:addNotification(source, "Por favor, insira sua senha!", "error")
            end
        else
            exports._infobox:addNotification(source, "Por favor, insira sua senha!", "error")
        end
    else
        exports._infobox:addNotification(source, "Por favor insira seu nome de usuário!", "error")
    end
end
addEvent("Panel:Register", true)
addEventHandler("Panel:Register", root, register)


addEventHandler("onPlayerJoin", root, function()
    triggerClientEvent(source, "olay", root)
end)