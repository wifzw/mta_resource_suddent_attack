addEventHandler("onPlayerCommand",root,
    function (command)
        if(command == "logout") then
            cancelEvent()
        elseif command == "register" then
            cancelEvent()
        elseif command == "login" then
            cancelEvent()
        end
    end
)