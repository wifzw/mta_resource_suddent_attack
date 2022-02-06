--[[
----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy

config = {

     ['serverColor'] = { 
         cor = {255, 0, 0}, --->  Cor do servidor em RGB 
     },
     
     --- > ---> ---> ---> infobox <--- <--- <--- <---    
     ['Infobox'] = function (element, action, message, type)
         if action == 'server' then
             triggerClientEvent (element, 'addBox', element, type, message) -- <-- server
         elseif action == 'client' then
             triggerEvent ('addBox', localPlayer, type, message) -- <-- client
         end
     end;
 }