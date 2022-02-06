function noadmdamage()
if (getElementData(source, "godmode") == "true") then
    cancelEvent()
else
 end
end
addEventHandler("onClientPlayerDamage", getRootElement(), noadmdamage)
