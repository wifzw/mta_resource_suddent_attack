function tele (thePlayer)
	setElementPosition ( thePlayer,-2246.0295410156, 1894.1909179688, 5.1711626052856 )
	outputChatBox ('#000000[#FF0000 Info #000000]: #00FFFF' .. getPlayerName(thePlayer) .. ' #868686Foi Para O Treinamento Gang#FF0000/*********', root, 255, 255, 255, true)
end
addCommandHandler ( "treinar", tele )