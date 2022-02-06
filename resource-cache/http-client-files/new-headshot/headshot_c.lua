local antiHS = false

addCommandHandler("cantor",
		function()
			if not antiHS then
				outputChatBox("#00ff00HS OFF!", 0, 255, 0, true)
			else
				outputChatBox("#ff0000HS ON!", 255, 0, 0, true)
			end
			antiHS = not antiHS
		end
)


function sendHeadshot ( attacker, weapon, bodypart, loss )
	if bodypart == 9 and antiHS == false then
		triggerServerEvent( "onServerHeadshot", getRootElement(), source, attacker, weapon, loss )
		setElementHealth ( source, 0 )
		setPedHeadless( source, true )
	end
end

addEventHandler ( "onClientPedDamage", localPlayer, sendHeadshot )
addEventHandler ( "onClientPlayerDamage", localPlayer, sendHeadshot )