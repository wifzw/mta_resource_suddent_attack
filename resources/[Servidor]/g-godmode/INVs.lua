
function setInince(thePlayer)
    if (hasObjectPermissionTo(thePlayer, "function.banPlayer")) then
        if (getElementData(thePlayer, "godmode") == "true") then
            setElementData(thePlayer,"godmode", "false")
            outputChatBox("You are no longer Invincible", thePlayer)
        else
            setElementData(thePlayer,"godmode", "true")
            outputChatBox("You are now the new god", thePlayer)
        end
    else
        outputChatBox("You do not have permission for this", thePlayer)
    end
end
addCommandHandler("saProtectGod", setInince)