function tele (thePlayer)
	setElementPosition ( thePlayer, 110,1062,25 )
	outputChatBox ('#696969[#90FF55Tele#696969] #FFFFFF' .. getPlayerName(thePlayer) .. ' #FFFFFFFoi Para CINEMA  #90FF55/cinema', root, 255, 255, 255, true)
end
addCommandHandler ( "cinema", tele )