local road = {}

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		local texture = dxCreateTexture("img/vegasdirtyroad3_256.jpg", "dxt3")
		local shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "vegasdirtyroad3_256")
		road[1] = {texture, shader, {"vegasdirtyroad3_256"}}
		
		texture = dxCreateTexture("img/Tar_1line256HVblend2.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "vegasdirtyroad3_256")
		engineApplyShaderToWorldTexture(shader, "Tar_1line256HVblend2")
		engineApplyShaderToWorldTexture(shader, "Tar_1line256HVblenddrt")
		engineApplyShaderToWorldTexture(shader, "Tar_1line256HVblenddrtdot")
		engineApplyShaderToWorldTexture(shader, "Tar_1line256HVgtravel")
		engineApplyShaderToWorldTexture(shader, "Tar_1line256HVlightsand")
		engineApplyShaderToWorldTexture(shader, "Tar_lineslipway")
		engineApplyShaderToWorldTexture(shader, "Tar_venturasjoin")
		engineApplyShaderToWorldTexture(shader, "conc_slabgrey_256128")
		road[2] = {texture, shader, {"vegasdirtyroad3_256", "Tar_1line256HVblend2", "Tar_1line256HVblenddrt", "Tar_1line256HVblenddrtdot", "Tar_1line256HVgtravel", "Tar_1line256HVlightsand", "Tar_lineslipway", "Tar_venturasjoin", "conc_slabgrey_256128"}}
		
		texture = dxCreateTexture("img/snpedtest1BLND.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "ws_freeway3blend")
		engineApplyShaderToWorldTexture(shader, "snpedtest1BLND")
		engineApplyShaderToWorldTexture(shader, "vegastriproad1_256")
		
		road[3] = {texture, shader, {"ws_freeway3blend", "snpedtest1BLND", "vegastriproad1_256"}}
		
		texture = dxCreateTexture("img/desert_1line256.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "desert_1line256")
		engineApplyShaderToWorldTexture(shader, "desert_1linetar")
		engineApplyShaderToWorldTexture(shader, "roaddgrassblnd")
		
		road[4] = {texture, shader, {"desert_1line256", "desert_1linetar", "roaddgrassblnd"}}
		
		texture = dxCreateTexture("img/crossing2_law.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "crossing2_law")
		engineApplyShaderToWorldTexture(shader, "lasunion994")
		engineApplyShaderToWorldTexture(shader, "motocross_256")
		
		road[5] = {texture, shader, {"crossing2_law", "lasunion994", "motocross_256"}}
		
		texture = dxCreateTexture("img/crossing_law.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "crossing_law")
		engineApplyShaderToWorldTexture(shader, "crossing_law2")
		engineApplyShaderToWorldTexture(shader, "crossing_law3")
		engineApplyShaderToWorldTexture(shader, "sf_junction5")
		engineApplyShaderToWorldTexture(shader, "crossing_law.bmp")
		
		road[6] = {texture, shader, {"crossing_law", "crossing_law2", "crossing_law3", "sf_junction5", "crossing_law.bmp"}}
		
		texture = dxCreateTexture("img/dt_road_stoplinea.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "dt_road_stoplinea")
		
		road[7] = {texture, shader, {"dt_road_stoplinea"}}
		
		texture = dxCreateTexture("img/Tar_freewyleft.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "Tar_freewyleft")
		
		road[8] = {texture, shader, {"Tar_freewyleft"}}
		
		texture = dxCreateTexture("img/Tar_freewyright.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "Tar_freewyright")
		
		road[9] = {texture, shader, {"Tar_freewyright"}}
		
		texture = dxCreateTexture("img/Tar_1line256HV.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "Tar_1line256HV")
		engineApplyShaderToWorldTexture(shader, "Tar_1linefreewy")
		engineApplyShaderToWorldTexture(shader, "des_1line256")
		engineApplyShaderToWorldTexture(shader, "des_1lineend")
		engineApplyShaderToWorldTexture(shader, "des_1linetar")
		
		road[10] = {texture, shader, {"Tar_1line256HV", "Tar_1linefreewy", "des_1line256", "des_1lineend", des_1linetar}}
		
		texture = dxCreateTexture("img/sf_junction2.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "sf_junction2")
		
		road[11] = {texture, shader, {"sf_junction2"}}
		
		texture = dxCreateTexture("img/vegastriproad1_256.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "vegastriproad1_256")
		engineApplyShaderToWorldTexture(shader, "ws_freeway3")
		engineApplyShaderToWorldTexture(shader, "cuntroad01_law")
		engineApplyShaderToWorldTexture(shader, "roadnew4blend_256")
		engineApplyShaderToWorldTexture(shader, "sf_road5")
		engineApplyShaderToWorldTexture(shader, "sl_roadbutt1")
		engineApplyShaderToWorldTexture(shader, "snpedtest1")
		
		road[12] = {texture, shader, {"vegastriproad1_256", "ws_freeway3", "cuntroad01_law", "roadnew4blend_256", "sf_road5", "sl_roadbutt1", "snpedtest1"}}
		
		texture = dxCreateTexture("img/vegastriproad1_256.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "vegastriproad1_256")
		engineApplyShaderToWorldTexture(shader, "ws_freeway3")
		engineApplyShaderToWorldTexture(shader, "cuntroad01_law")
		engineApplyShaderToWorldTexture(shader, "roadnew4blend_256")
		engineApplyShaderToWorldTexture(shader, "sf_road5")
		engineApplyShaderToWorldTexture(shader, "sl_roadbutt1")
		engineApplyShaderToWorldTexture(shader, "snpedtest1")
		
		road[13] = {texture, shader, {"vegastriproad1_256", "ws_freeway3", "cuntroad01_law", "roadnew4blend_256", "sf_road5", "sl_roadbutt1", "snpedtest1"}}
		
		texture = dxCreateTexture("img/sl_freew2road1.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "sl_freew2road1")
		engineApplyShaderToWorldTexture(shader, "snpedtest1blend")
		engineApplyShaderToWorldTexture(shader, "ws_carpark3")
		
		road[14] = {texture, shader, {"sl_freew2road1", "snpedtest1blend", "ws_carpark3"}}
		
		texture = dxCreateTexture("img/cos_hiwaymid_256.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "cos_hiwaymid_256")
		engineApplyShaderToWorldTexture(shader, "sf_road5")
		
		road[15] = {texture, shader, {"cos_hiwaymid_256", "sf_road5"}}
		
		texture = dxCreateTexture("img/hiwayend_256.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "hiwayend_256")
		engineApplyShaderToWorldTexture(shader, "hiwaymidlle_256")
		engineApplyShaderToWorldTexture(shader, "vegasroad2_256")
		
		road[16] = {texture, shader, {"hiwayend_256", "hiwaymidlle_256", "vegasroad2_256"}}
		
		texture = dxCreateTexture("img/roadnew4_256.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "roadnew4_256")
		engineApplyShaderToWorldTexture(shader, "roadnew4_512")
		engineApplyShaderToWorldTexture(shader, "vegasroad1_256")
		engineApplyShaderToWorldTexture(shader, "dt_road")
		engineApplyShaderToWorldTexture(shader, "vgsN_road2sand01")
		engineApplyShaderToWorldTexture(shader, "hiwayoutside_256")
		engineApplyShaderToWorldTexture(shader, "vegasdirtyroad1_256")
		engineApplyShaderToWorldTexture(shader, "vegasdirtyroad2_256")
		engineApplyShaderToWorldTexture(shader, "vegasroad3_256")
		
		road[17] = {texture, shader, {"roadnew4_256", "roadnew4_512", "vegasroad1_256", "dt_road", "vgsN_road2sand01", "hiwayoutside_256", "vegasdirtyroad1_256", "vegasdirtyroad2_256", "vegasroad3_256"}}
		
		texture = dxCreateTexture("img/sf_junction1.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "sf_junction1")
		engineApplyShaderToWorldTexture(shader, "sf_junction3")
		
		road[18] = {texture, shader, {"sf_junction1", "sf_junction3"}}
		
		texture = dxCreateTexture("img/des_oldrunway.jpg", "dxt3")
		shader = dxCreateShader("shader.fx")
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, "des_oldrunway")
		engineApplyShaderToWorldTexture(shader, "des_panelconc")
		engineApplyShaderToWorldTexture(shader, "plaintarmac1")
		
		road[19] = {texture, shader, {"des_oldrunway", "des_panelconc", "plaintarmac1"}}
		setElementData(localPlayer, "yolDurum", true)
end)

addEvent("yolDurum", true)
addEventHandler("yolDurum", root, function(state)
	setElementData(localPlayer, "yolDurum", not state)
	for i, v in ipairs(road) do
		for j, k in ipairs(v[3]) do
			if state then
				engineRemoveShaderFromWorldTexture(v[2], k)
			else
				engineApplyShaderToWorldTexture(v[2], k)
			end
		end
	end
end)



----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy
