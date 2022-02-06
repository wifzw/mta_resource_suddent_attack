function sendHeadshot ( attacker, weapon, bodypart, loss )
	if attacker == getLocalPlayer() then
		if bodypart == 9 then
			triggerServerEvent( "onServerHeadshot", getRootElement(), source, attacker, weapon, loss )
			setElementHealth ( source, 0 )
			setPedHeadless( source, true )
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), sendHeadshot )
addEventHandler ( "onClientPlayerDamage", getRootElement(), sendHeadshot )
