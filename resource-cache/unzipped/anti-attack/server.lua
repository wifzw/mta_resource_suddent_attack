CMDBLOQUEAR = {
    ["logout"] = true,
    ["hackv2"] = true,
    ["alemaomoney1"] = true,
    ["me"] = true,
    ["wp"] = true,
    ["mensagem"] = true,
    ["whois"] = true,
    ["unregister"] = true,
    ["start"] = true,
    ["stop"] = true,
    ["restart"] = true,
    ["refresh"] = true,
    ["msg"] = true,
    ["engine"] = true,
    ["reconnect"] = true,
    ["shutdown"] = true,
    ["me"] = true,
    ["elcomando"] = true,
    ["motor"] = true,
    ["pm"] = true,
    ["sendmtaflood"] = true,
}

function BLOQUEARCOMANDOS( Comando )
if CMDBLOQUEAR[ Comando ] == true then
if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Console")) then return end
cancelEvent()
triggerClientEvent(source, "addNotification", root, "Você não tem essa permissão!")
end
end
addEventHandler("onPlayerCommand", root, BLOQUEARCOMANDOS)