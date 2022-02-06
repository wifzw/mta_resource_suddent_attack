
--- Sitemiz : https://sparrow-mta.blogspot.com/

--- Facebook : https://facebook.com/sparrowgta/
--- İnstagram : https://instagram.com/sparrowmta/
--- YouTube : https://youtube.com/c/SparroWMTA/

--- Discord : https://discord.gg/DzgEcvy

--[[
 ______     ______     ______   __  __     ______     __     ______     __  __     ______      ______     __  __       
/\  ___\   /\  __ \   /\  == \ /\ \_\ \   /\  == \   /\ \   /\  ___\   /\ \_\ \   /\__  _\    /\  == \   /\ \_\ \      
\ \ \____  \ \ \/\ \  \ \  _-/ \ \____ \  \ \  __<   \ \ \  \ \ \__ \  \ \  __ \  \/_/\ \/    \ \  __<   \ \____ \     
 \ \_____\  \ \_____\  \ \_\    \/\_____\  \ \_\ \_\  \ \_\  \ \_____\  \ \_\ \_\    \ \_\     \ \_____\  \/\_____\    
  \/_____/   \/_____/   \/_/     \/_____/   \/_/ /_/   \/_/   \/_____/   \/_/\/_/     \/_/      \/_____/   \/_____/    
                                                                                                                       
 ______   __  __     __     ______     ______     ______        ______     ______     ______                           
/\__  _\ /\ \_\ \   /\ \   /\  ___\   /\  __ \   /\  ___\      /\  ___\   /\  ___\   /\  == \                          
\/_/\ \/ \ \  __ \  \ \ \  \ \ \__ \  \ \  __ \  \ \___  \     \ \___  \  \ \ \____  \ \  __<                          
   \ \_\  \ \_\ \_\  \ \_\  \ \_____\  \ \_\ \_\  \/\_____\     \/\_____\  \ \_____\  \ \_\ \_\                        
    \/_/   \/_/\/_/   \/_/   \/_____/   \/_/\/_/   \/_____/      \/_____/   \/_____/   \/_/ /_/                                                                                                                                    
--]]

---------------/CONFIG UTILS\---------------
function getPlayerACLGroupFromTable (player, table)
    for i, v in ipairs (table) do
        if aclGetGroup (v) then
            local accName = getAccountName (getPlayerAccount (player))
            return isObjectInACLGroup ("user." ..accName, aclGetGroup (v))
        else
            outputDebugString ("Gerekli ACL Gruplarını Oluştur, Gerekli ACL Grupları : "..v.."Admin Panelinden !.", 4, 255, 0, 0)
            return false
        end
    end
end
---------------/CONFIG UTILS\---------------

---------------/CONFIG COMMAND\---------------
addCommandHandler (config["Command"], function (player, cmd)
    if getPlayerACLGroupFromTable (player, config["Acls"]) then
        local data = getElementData (player, "onPlayerStaff")
        if not data then
            setElementData (player, "onPlayerStaff", true)
            outputChatBox ("[#00FF00 BİLGİ #FFFFFF] - Wallhack'i etkinleştirdiniz.", player, 255, 255, 255, true)
        else
            removeElementData (player, "onPlayerStaff")
            outputChatBox ("[#00FFFF BİLGİ #FFFFFF] - Wallhack'i devre dışı bıraktınız.", player, 255, 255, 255, true)
        end
    else
        outputChatBox ("[#FF0000 HATA #FFFFFF] - Yeterli izniniz yok.", player, 255, 255, 255, true)
    end
end)
---------------/CONFIG COMMAND\---------------



--- Sitemiz : https://sparrow-mta.blogspot.com/

--- Facebook : https://facebook.com/sparrowgta/
--- İnstagram : https://instagram.com/sparrowmta/
--- YouTube : https://youtube.com/c/SparroWMTA/

--- Discord : https://discord.gg/DzgEcvy