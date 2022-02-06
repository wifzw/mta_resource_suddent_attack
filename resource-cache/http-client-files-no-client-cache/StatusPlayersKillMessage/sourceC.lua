local maxMessages = 5; -- Maximo de Mensagens
local DefaultTime = 15;

local sx, sy = guiGetScreenSize ( )
local DefaultPos = true;

local timer_top =  { }
local timer_btm = { }


local messages_top = { }
local messages_btm = { }

function sendClientMessage ( msg, r, g, b, pos, time )
	local r, g, b = r, g, b or 255, 255, 255
	if ( pos == nil ) then pos = DefaultPos end -- Check for pos
	if ( time == nil ) then time = DefaultTime end -- Check for time
	local GsubedMessage = msg:gsub ( "#%x%x%x%x%x%x", "" )
	if ( pos == true ) then
	if ( not isTimer ( timer_top[GsubedMessage] ) ) then
	local c_messages = messages_top;
	if ( #messages_top >= maxMessages ) then
	local c_messages = messages_top;
	messages_top = { }
	for i,v in ipairs ( c_messages ) do
	if ( i ~= 1 ) then
	table.insert ( messages_top, { v[1], v[2], v[3], v[4] } )
	end
	end
	end
	table.insert ( messages_top, { msg, r, g, b } )
	timer_top[GsubedMessage] = setTimer ( function ( msg )
	for i,v in ipairs ( messages_top ) do
	if ( v[1] == msg ) then
	table.remove ( messages_top, i )
	break
	end
	end
	end, time*1000, 1, msg )
	return_value = true
	else return_value = false end
	else
	if not ( isTimer ( timer_btm[GsubedMessage] ) ) then
	local c_messages = messages_btm;
	if ( #messages_btm >= maxMessages ) then
	local c_messages = messages_btm;
	messages_btm = { }
	for i,v in ipairs ( c_messages ) do
	if ( i ~= 1 ) then
	table.insert ( messages_btm, { v[1], v[2], v[3], v[4] } )
	end
	end
	end
	table.insert ( messages_btm, { msg, r, g, b } )
	timer_btm[GsubedMessage] = setTimer ( function ( msg )
	for i,v in ipairs ( messages_btm ) do
	if ( v[1] == msg ) then
	table.remove ( messages_btm, i )
	break
	end
	end
	end, time*1000, 1, msg )
	return_value = true
	else return_value = false end
	end
	return return_value or false
end 
addEvent("sendServerMessage", true)
addEventHandler("sendServerMessage", root, sendClientMessage)

function dxDrawNotificationBar ( )
	for i,v in ipairs ( messages_top ) do
	local i = i - 1 
	dxDrawRectangle ( ( sx/2-530/2 ), i*25, 530, 25, tocolor ( 0, 0, 0, 100 ) )
	dxDrawText ( v[1], 0, i*25+5, sx, 25, tocolor ( v[2], v[3], v[4], 255 ), 1, "default-bold", "center", "top", true, false, false, true )
	end
	for i,v in pairs ( messages_btm ) do
	local i = i - 1
	local y = i * 25+25
	if ( i+1 == #messages_btm ) then
	dxDrawRectangle ( ( sx/2-530/2 ), (sy-y), 530, 25, tocolor ( 0, 0, 0, 170 ) )
	end
	dxDrawRectangle ( ( sx/2-530/2 ), (sy-y), 530, 25, tocolor ( 0, 0, 0, 150 ) )
	dxDrawText ( v[1], 0, (sy-y+5), sx, sy, tocolor ( v[2], v[3], v[4], 255 ), 1, "default-bold", "center", "top", true, false, false, true )
	end
end
addEventHandler ( "onClientRender", root, dxDrawNotificationBar )

addEventHandler('onClientPlayerChangeNick', root,
	function(oldNick, newNick)
	sendClientMessage("#FFFFFF"..oldNick.."#FFFFFF Mudou o nick para : "..newNick..".", 255, 100, 100, false, 5)
	end
)


addEventHandler('onClientPlayerJoin', root,
	function()
		sendClientMessage("#FFFFFF"..getPlayerName(source).." #FFFFFFEntrou no servidor.", 255, 100, 100, false, 5)
	end
)