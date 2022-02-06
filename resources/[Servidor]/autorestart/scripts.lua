local scripts_refrescar = {

	-- Script folder, script that changes, actualsize (dont change, 0 default)
	--[[
	
		EXAMPLE:
		
		  folder		   file		size
			V				V		 V 
		{"vehicles","vehicles_c.lua",0},
	
	]]
	
}

local refreshtime = 2000

local abierto = {}

setTimer( function()
	for i=1, #scripts_refrescar do 
		local v = scripts_refrescar[i]
		if fileExists( ":"..v[1].."/"..v[2] ) then
			if not abierto[i] then
				abierto[i] = fileOpen( ":"..v[1].."/"..v[2]  )
			else
				if v[3] == 0 then
					v[3] = fileGetSize( abierto[i] )
				else
					if fileGetSize( abierto[i] ) ~= v[3] then
						if restartResource( getResourceFromName(v[1]) ) then
							outputDebugString( "[AUTORESTART] Resource "..v[1].." changed. Restarting..." )
							v[3] = fileGetSize( abierto[i] )
							fileClose( abierto[i] )
							abierto[i] = nil
						end
					end
				end
			end
		end
	end
end, refreshtime, 0 )